import { createContext, useContext, useState, useCallback, useEffect, type ReactNode } from 'react';
import type { User, Role, CompanyRole, PermissionKey, PermissionMap, RoleConfig } from '../types';
import * as api from '../lib/api';
import { supabase } from '../lib/supabase';



export const ROLES = {
    COMPANY_ADMIN: 'company_admin' as const,
    MANAGER: 'manager' as const,
    MEMBER: 'member' as const,
};

export const PERMISSIONS: Record<CompanyRole, PermissionMap> = {
    company_admin: {
        canEditPositioning: true, canEditCompanyKeywords: true, canManageUsers: true,
        canManageSettings: true, canManageCompany: true, canCreateCampaigns: true,
        canEditCampaigns: true, canViewAllCampaigns: true, canDeleteItems: true,
        canManageTouchpoints: true, canEditAudiences: true, canViewAudiences: true,
        canSeeBudget: true, canEditBudget: true, canAssignTasks: true,
        canCreateCampaignTasks: true, canEditAllTasks: true, canEditOwnTasks: true,
        canEditContent: true, canUseSocialHub: true,
    },
    manager: {
        canEditPositioning: false, canEditCompanyKeywords: false, canManageUsers: false,
        canManageSettings: false, canManageCompany: false, canCreateCampaigns: true,
        canEditCampaigns: true, canViewAllCampaigns: true, canDeleteItems: true,
        canManageTouchpoints: true, canEditAudiences: true, canViewAudiences: true,
        canSeeBudget: true, canEditBudget: true, canAssignTasks: true,
        canCreateCampaignTasks: true, canEditAllTasks: true, canEditOwnTasks: true,
        canEditContent: true, canUseSocialHub: true,
    },
    member: {
        canEditPositioning: false, canEditCompanyKeywords: false, canManageUsers: false,
        canManageSettings: false, canManageCompany: false, canCreateCampaigns: false,
        canEditCampaigns: false, canViewAllCampaigns: false, canDeleteItems: false,
        canManageTouchpoints: false, canEditAudiences: false, canViewAudiences: true,
        canSeeBudget: false, canEditBudget: false, canAssignTasks: false,
        canCreateCampaignTasks: false, canEditAllTasks: false, canEditOwnTasks: true,
        canEditContent: false, canUseSocialHub: false,
    },
};

export const ROLE_CONFIG: Record<CompanyRole, RoleConfig> & { super_admin: RoleConfig } = {
    super_admin: {
        label: 'Super-Administrator', shortLabel: 'Super-Admin',
        color: '#f59e0b', bgColor: 'rgba(245, 158, 11, 0.12)',
        description: 'Globale Verwaltung aller Projekt und Benutzer',
    },
    company_admin: {
        label: 'Projekt-Admin', shortLabel: 'Admin',
        color: '#c1292e', bgColor: 'rgba(193, 41, 46, 0.12)',
        description: 'Vollständige Kontrolle über das Projekt, User-Management',
    },
    manager: {
        label: 'Marketing Manager', shortLabel: 'Manager',
        color: '#8b5cf6', bgColor: 'rgba(139, 92, 246, 0.12)',
        description: 'Kampagnen und Aufgaben erstellen, Team koordinieren',
    },
    member: {
        label: 'Team-Member', shortLabel: 'Member',
        color: '#14b8a6', bgColor: 'rgba(20, 184, 166, 0.12)',
        description: 'Eigene Aufgaben bearbeiten, Kampagnendaten einsehen',
    },
};

/**
 * Pure utility — testable without React context.
 * Returns whether the given role has the given permission.
 * Super-admins always have all permissions.
 */
export function computePermission(
    role: CompanyRole | null | undefined,
    permission: PermissionKey,
    isSuperAdmin?: boolean,
): boolean {
    if (isSuperAdmin) return true;
    if (!role) return false;
    return PERMISSIONS[role]?.[permission] === true;
}

interface AuthContextValue {
    currentUser: User | null;
    sessionLoading: boolean;
    /** The user's role in the currently selected company */
    activeCompanyRole: CompanyRole | null;
    setActiveCompanyRole: (role: CompanyRole | null) => void;
    isSuperAdmin: boolean;
    login: (user: User) => void;
    loginWithCredentials: (email: string, password: string) => Promise<User | null>;
    registerWithCredentials: (input: {
        name: string;
        email: string;
        password: string;
        phone: string;
        whatsappConsent: boolean;
        companyName?: string;
        planId?: string;
    }) => Promise<User>;
    logout: () => void;
    can: (permission: PermissionKey) => boolean;
    isRole: (role: Role) => boolean;
    ROLE_CONFIG: typeof ROLE_CONFIG;
}

const AuthContext = createContext<AuthContextValue | null>(null);

export function AuthProvider({ children }: { children: ReactNode }) {
    const [currentUser, setCurrentUser] = useState<User | null>(null);
    const [sessionLoading, setSessionLoading] = useState(true);
    const [activeCompanyRole, setActiveCompanyRole] = useState<CompanyRole | null>(null);

    // Restore session from HTTP-only cookie on mount
    useEffect(() => {
        api.restoreSession()
            .then(user => {
                if (user) {
                    if (!user.isSuperAdmin && user.isActive === false) {
                        api.logout().catch(console.error);
                    } else {
                        setCurrentUser(user);
                        api.updateUserStatus(user.id, 'online').catch(console.error);
                    }
                }
            })
            .catch(() => {})
            .finally(() => setSessionLoading(false));
    }, []);

    const login = useCallback((user: User) => {
        setCurrentUser(user);
        api.updateUserStatus(user.id, 'online').catch(console.error);
    }, []);

    const loginWithCredentials = useCallback(async (email: string, password: string): Promise<User | null> => {
        const user = await api.loginUser(email, password);
        if (user) {
            setCurrentUser(user);
            api.updateUserStatus(user.id, 'online').catch(console.error);
            return user;
        }
        return null;
    }, []);

    const registerWithCredentials = useCallback(async (input: {
        name: string;
        email: string;
        password: string;
        phone: string;
        whatsappConsent: boolean;
        companyName?: string;
        planId?: string;
    }): Promise<User> => {
        const user = await api.registerUser(input);
        if (user.isActive) {
            setCurrentUser(user);
            api.updateUserStatus(user.id, 'online').catch(console.error);
        }
        return user;
    }, []);

    const logout = useCallback(() => {
        if (currentUser) {
            api.updateUserStatus(currentUser.id, 'offline').catch(console.error);
        }
        api.logout().catch(console.error);
        localStorage.removeItem('momentum_active_company');
        setCurrentUser(null);
        setActiveCompanyRole(null);
    }, [currentUser]);

    // Watch for deactivation in realtime and via polling. If the current user is
    // deactivated (and is not a super-admin), log them out immediately.
    useEffect(() => {
        if (!currentUser) return;

        const checkActive = async () => {
            try {
                const user = await api.fetchUserById(currentUser.id);
                if (user && !user.isSuperAdmin && user.isActive === false) {
                    logout();
                }
            } catch {
                // Ignore network errors; polling will retry.
            }
        };

        const intervalId = setInterval(checkActive, 30000);

        const channel = supabase
            .channel(`auth_user:${currentUser.id}`)
            .on(
                'postgres_changes',
                {
                    event: 'UPDATE',
                    schema: '*',
                    table: 'users',
                    filter: `id=eq.${currentUser.id}`,
                },
                (payload: { new?: Record<string, unknown> }) => {
                    const updated = payload.new;
                    if (!updated) return;
                    const isActive = updated.is_active as boolean | undefined;
                    const isSuperAdmin = updated.is_super_admin as boolean | undefined;
                    if (isActive === false && !isSuperAdmin) {
                        logout();
                    }
                },
            )
            .subscribe();

        return () => {
            clearInterval(intervalId);
            supabase.removeChannel(channel);
        };
    }, [currentUser, logout]);

    const isSuperAdmin = currentUser?.isSuperAdmin === true;

    const can = useCallback((permission: PermissionKey): boolean =>
        computePermission(activeCompanyRole, permission, isSuperAdmin), [activeCompanyRole, isSuperAdmin]);

    const isRole = useCallback((role: Role) => activeCompanyRole === role, [activeCompanyRole]);

    return (
        <AuthContext.Provider value={{
            currentUser, sessionLoading, activeCompanyRole, setActiveCompanyRole,
            isSuperAdmin, login, loginWithCredentials, registerWithCredentials, logout, can, isRole, ROLE_CONFIG,
        }}>
            {children}
        </AuthContext.Provider>
    );
}

export function useAuth(): AuthContextValue {
    const ctx = useContext(AuthContext);
    if (!ctx) throw new Error('useAuth must be used within AuthProvider');
    return ctx;
}
