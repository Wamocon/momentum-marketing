import {
  createContext, useContext, useState, useEffect, useCallback,
  type ReactNode,
} from 'react';
import type { Plan, Subscription, PlanFeatures } from '../types';
import { useAuth } from './AuthContext';
import { useCompany } from './CompanyContext';
import * as api from '../lib/api';
import { PLAN_SLUGS, hasFeature, planTierOrder, type PlanSlug } from '../lib/pricing';

// ─── Context value shape ───────────────────────────────────

interface SubscriptionContextValue {
  /** All active plans from the DB (cached). */
  plans: Plan[];
  /** The active subscription for the current company. null = no subscription. */
  subscription: Subscription | null;
  /** Resolved plan object for the current subscription. */
  currentPlan: Plan | null;
  /** Slug shortcut, e.g. 'starter' | 'pro' | 'ultimate'. Falls back to 'starter'. */
  currentPlanSlug: PlanSlug;
  /** True while loading subscription data. */
  loading: boolean;
  /** Check if the current plan has a specific feature. */
  can: (feature: keyof PlanFeatures) => boolean;
  /** True if the current plan is lower than the given slug. */
  isBelow: (slug: PlanSlug) => boolean;
  /** True if current plan is strictly below 'pro'. */
  needsUpgrade: boolean;
  /** Switch the company to a different plan. */
  changePlan: (planId: string) => Promise<void>;
  /** Re-fetch subscription from the server. */
  refresh: () => Promise<void>;
}

const SubscriptionContext = createContext<SubscriptionContextValue | null>(null);

// ─── Provider ──────────────────────────────────────────────

export function SubscriptionProvider({ children }: { children: ReactNode }) {
  const { currentUser, isSuperAdmin } = useAuth();
  const { activeCompany } = useCompany();

  const [plans, setPlans] = useState<Plan[]>([]);
  const [subscription, setSubscription] = useState<Subscription | null>(null);
  const [loading, setLoading] = useState(true);

  // Fetch all plans once on mount
  useEffect(() => {
    let cancelled = false;
    api.fetchPlans()
      .then(data => { if (!cancelled) setPlans(data); })
      .catch(console.error);
    return () => { cancelled = true; };
  }, []);

  // Fetch subscription whenever the active project or organisation changes
  const activeOrganisationId = activeCompany?.organisationId || currentUser?.organisationId;
  const activeCompanyId = activeCompany?.id;
  useEffect(() => {
    if (!currentUser?.id || (!activeCompanyId && !activeOrganisationId)) {
      setSubscription(null);
      setLoading(false);
      return;
    }
    let cancelled = false;
    setLoading(true);
    const subscriptionRequest = activeCompanyId
      ? api.fetchCompanySubscription(activeCompanyId, activeCompany?.organisationId)
      : api.fetchSubscription(activeOrganisationId!);
    subscriptionRequest
      .then(sub => { if (!cancelled) setSubscription(sub); })
      .catch(console.error)
      .finally(() => { if (!cancelled) setLoading(false); });
    return () => { cancelled = true; };
  }, [currentUser?.id, activeCompanyId, activeCompany?.organisationId, activeOrganisationId]);

  // ── Derived state ──

  const currentPlan: Plan | null =
    subscription?.plan ??
    plans.find(p => p.id === subscription?.planId) ??
    null;

  const currentPlanSlug: PlanSlug =
    (currentPlan?.slug as PlanSlug) ?? PLAN_SLUGS.STARTER;

  const can = useCallback(
    (feature: keyof PlanFeatures): boolean => hasFeature(currentPlan?.features, feature),
    [currentPlan],
  );

  const isBelow = useCallback(
    (slug: PlanSlug): boolean => planTierOrder(currentPlanSlug) < planTierOrder(slug),
    [currentPlanSlug],
  );

  const needsUpgrade = isBelow(PLAN_SLUGS.PRO);

  const [changing, setChanging] = useState(false);

  const changePlan = useCallback(async (planId: string) => {
    const organisationId = activeCompany?.organisationId || currentUser?.organisationId;
    if (changing) return;
    setChanging(true);
    try {
      // Normal users request a plan change; Super Admins apply it immediately.
      if (isSuperAdmin) {
        if (subscription?.id) {
          await api.updateSubscription(subscription.id, { planId });
        } else if (organisationId) {
          await api.createSubscription(organisationId, planId);
        } else {
          return;
        }
        // Clear any pending request the organisation may have had.
        if (organisationId) {
          await api.updateOrganisationRequestedPlan(organisationId, null);
        }
        const refreshed = activeCompany?.id
          ? await api.fetchCompanySubscription(activeCompany.id, activeCompany.organisationId)
          : organisationId
            ? await api.fetchSubscription(organisationId)
            : null;
        setSubscription(refreshed);
      } else {
        if (!organisationId) return;
        await api.updateOrganisationRequestedPlan(organisationId, planId);
      }
    } finally {
      setChanging(false);
    }
  }, [activeCompany, currentUser, subscription, changing, isSuperAdmin]);

  const refresh = useCallback(async () => {
    const organisationId = activeCompany?.organisationId || currentUser?.organisationId;
    if (!activeCompany?.id && !organisationId) return;
    const refreshed = activeCompany?.id
      ? await api.fetchCompanySubscription(activeCompany.id, activeCompany.organisationId)
      : organisationId
        ? await api.fetchSubscription(organisationId)
        : null;
    setSubscription(refreshed);
  }, [activeCompany, currentUser]);

  return (
    <SubscriptionContext.Provider value={{
      plans, subscription, currentPlan, currentPlanSlug,
      loading, can, isBelow, needsUpgrade, changePlan, refresh,
    }}>
      {children}
    </SubscriptionContext.Provider>
  );
}

// ─── Hook ──────────────────────────────────────────────────

export function useSubscription(): SubscriptionContextValue {
  const ctx = useContext(SubscriptionContext);
  if (!ctx) throw new Error('useSubscription must be used within SubscriptionProvider');
  return ctx;
}
