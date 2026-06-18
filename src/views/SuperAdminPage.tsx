'use client';

import { useState, useEffect, useCallback, type FormEvent } from 'react';
import {
    Shield, Building2, Users2, Plus, Trash2, Search,
    ArrowLeft, Crown, UserCheck, X, Edit3, Check, ChevronDown, ChevronUp,
    UserPlus, UserMinus,
} from 'lucide-react';
import Link from 'next/link';
import { useAuth, ROLE_CONFIG } from '../context/AuthContext';
import { useCompany } from '../context/CompanyContext';
import { useLanguage } from '../context/LanguageContext';
import type { Company, CompanyRole, User, Subscription, Plan, Organisation } from '../types';
import * as api from '../lib/api';
import PageHelp from '../components/PageHelp';

type AdminTab = 'organisations' | 'users';

export default function SuperAdminPage() {
    const { currentUser, isSuperAdmin } = useAuth();
    const { activeCompany } = useCompany();
    const { t } = useLanguage();
    const [activeTab, setActiveTab] = useState<AdminTab>('organisations');
    const [searchQuery, setSearchQuery] = useState('');
    const [showCreateOrganisationModal, setShowCreateOrganisationModal] = useState(false);
    const [showAddUserModal, setShowAddUserModal] = useState(false);

    // Organisation data
    const [organisations, setOrganisations] = useState<Organisation[]>([]);
    const [users, setUsers] = useState<User[]>([]);
    const [allSubscriptions, setAllSubscriptions] = useState<Subscription[]>([]);
    const [allPlans, setAllPlans] = useState<Plan[]>([]);

    // Per-organisation cached data for expanded view
    const [orgUsers, setOrgUsers] = useState<Record<string, User[]>>({});
    const [orgCompanies, setOrgCompanies] = useState<Record<string, Company[]>>({});
    const [expandedOrgId, setExpandedOrgId] = useState<string | null>(null);

    // Company members within an organisation's expanded view
    const [companyMembers, setCompanyMembers] = useState<Record<string, { memberId: string; userId: string; role: CompanyRole; userName: string; userEmail: string }[]>>({});
    const [assignByCompany, setAssignByCompany] = useState<Record<string, { userId: string; role: CompanyRole }>>({});
    const [addToOrgUserId, setAddToOrgUserId] = useState<Record<string, string>>({});
    const [orgFeedback, setOrgFeedback] = useState<Record<string, { error?: string; success?: string }>>({});
    const [companyFeedback, setCompanyFeedback] = useState<Record<string, { error?: string; success?: string }>>({});

    // Create organisation modal state
    const [newOrgName, setNewOrgName] = useState('');
    const [newOrgOwnerId, setNewOrgOwnerId] = useState<string>('');
    const [newOrgPlanId, setNewOrgPlanId] = useState<string>('');
    const [createOrgLoading, setCreateOrgLoading] = useState(false);
    const [createOrgError, setCreateOrgError] = useState('');

    // Create user modal state
    const [newUserName, setNewUserName] = useState('');
    const [newUserEmail, setNewUserEmail] = useState('');
    const [newUserPhone, setNewUserPhone] = useState('');
    const [newUserPassword, setNewUserPassword] = useState('');
    const [newUserRole, setNewUserRole] = useState<CompanyRole>('member');
    const [newUserPlanId, setNewUserPlanId] = useState<string>('');
    const [newUserActive, setNewUserActive] = useState(false);
    const [newUserOrganisationId, setNewUserOrganisationId] = useState<string>('');
    const [createUserLoading, setCreateUserLoading] = useState(false);
    const [createUserError, setCreateUserError] = useState('');

    // Inline editing of organisation name
    const [editingOrgId, setEditingOrgId] = useState<string | null>(null);
    const [editingOrgName, setEditingOrgName] = useState('');

    const loadOrganisations = async () => {
        try {
            const data = await api.fetchOrganisations();
            setOrganisations(data);
        } catch (err) {
            console.error('Failed to load organisations:', err);
        }
    };

    const loadUsers = async () => {
        try {
            const data = await api.fetchUsers();
            setUsers(data);
        } catch (err) {
            console.error('Failed to load users:', err);
        }
    };

    const loadSubscriptions = async () => {
        try {
            const data = await api.fetchAllSubscriptions();
            setAllSubscriptions(data);
        } catch (err) {
            console.error('Failed to load subscriptions:', err);
        }
    };

    const loadPlans = async () => {
        try {
            const data = await api.fetchPlans();
            setAllPlans(data);
        } catch (err) {
            console.error('Failed to load plans:', err);
        }
    };

    const refreshAll = useCallback(async () => {
        await Promise.all([loadOrganisations(), loadUsers(), loadSubscriptions(), loadPlans()]);
    }, []);

    useEffect(() => {
        if (isSuperAdmin) {
            refreshAll();
        }
    }, [isSuperAdmin, refreshAll]);

    if (!isSuperAdmin) {
        return (
            <div style={{
                minHeight: '100vh', display: 'flex', alignItems: 'center',
                justifyContent: 'center', background: 'var(--bg-base)',
                flexDirection: 'column', gap: '16px',
            }}>
                <Shield size={48} style={{ color: 'var(--color-danger)' }} />
                <h2 style={{ color: 'var(--text-primary)', fontWeight: 700 }}>{t({ de: 'Kein Zugriff', en: 'No Access', tr: 'Erişim Yok' })}</h2>
                <p style={{ color: 'var(--text-secondary)' }}>
                    {t({ de: 'Diese Seite ist nur für Super-Administratoren zugänglich.', en: 'This page is only accessible to super administrators.', tr: 'Bu sayfa yalnızca süper yöneticiler için erişilebilir.' })}
                </p>
                <Link href="/dashboard" className="btn btn-primary">
                    <ArrowLeft size={16} /> {t({ de: 'Zurück zum Dashboard', en: 'Back to Dashboard', tr: 'Panele Dön' })}
                </Link>
            </div>
        );
    }

    const generateSlug = (value: string): string =>
        value
            .toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '')
            .replace(/[^a-z0-9]+/g, '-')
            .replace(/(^-|-$)/g, '');

    const orgSubscription = (orgId: string) => allSubscriptions.find(s => s.organisationId === orgId);

    const filteredOrganisations = organisations.filter(o =>
        o.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        o.slug.toLowerCase().includes(searchQuery.toLowerCase())
    );

    const filteredUsers = users.filter(u =>
        u.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
        u.email.toLowerCase().includes(searchQuery.toLowerCase())
    );

    const handleDeleteOrganisation = async (id: string) => {
        if (!confirm(t({ de: 'Soll diese Organisation wirklich gelöscht werden? Alle zugehörigen Daten gehen verloren.', en: 'Do you really want to delete this organisation? All associated data will be lost.', tr: 'Bu organizasyon gerçekten silinsin mi? Tüm ilişkili veriler kaybolacak.' }))) return;
        try {
            await api.deleteOrganisation(id);
            loadOrganisations();
        } catch (err) {
            console.error('Failed to delete organisation:', err);
        }
    };

    const handleCreateOrganisation = async (e: FormEvent) => {
        e.preventDefault();
        setCreateOrgError('');
        const name = newOrgName.trim();
        if (!name) {
            setCreateOrgError(t({ de: 'Bitte einen Organisationsnamen eingeben.', en: 'Please enter an organisation name.', tr: 'Lütfen bir organizasyon adı girin.' }));
            return;
        }
        setCreateOrgLoading(true);
        try {
            const org = await api.createOrganisation({
                name,
                slug: `${generateSlug(name)}-${Date.now().toString(36)}`,
                ownerUserId: newOrgOwnerId || null,
                planId: null,
                requestedPlanId: null,
                status: 'active',
            });
            if (newOrgPlanId) {
                await api.createSubscription(org.id, newOrgPlanId);
            }
            setNewOrgName('');
            setNewOrgOwnerId('');
            setNewOrgPlanId('');
            setShowCreateOrganisationModal(false);
            refreshAll();
        } catch (err) {
            setCreateOrgError(err instanceof Error ? err.message : t({ de: 'Organisation konnte nicht erstellt werden.', en: 'Failed to create organisation.', tr: 'Organizasyon oluşturulamadı.' }));
        } finally {
            setCreateOrgLoading(false);
        }
    };

    const handleCreateUser = async (e: FormEvent) => {
        e.preventDefault();
        setCreateUserError('');
        const name = newUserName.trim();
        const email = newUserEmail.trim().toLowerCase();
        const phone = newUserPhone.trim();
        const password = newUserPassword;
        if (!name || !email || !password || password.length < 8) {
            setCreateUserError(t({ de: 'Bitte Name, E-Mail und ein Passwort mit mindestens 8 Zeichen eingeben.', en: 'Please enter name, email and a password with at least 8 characters.', tr: 'Lütfen ad, e-posta ve en az 8 karakterlik bir şifre girin.' }));
            return;
        }
        setCreateUserLoading(true);
        try {
            await api.createUser({
                name,
                email,
                password,
                role: newUserRole,
                isSuperAdmin: false,
                isActive: newUserActive,
                jobTitle: '',
                avatar: name.split(/\s+/).filter(Boolean).map((p: string) => p.charAt(0).toUpperCase()).slice(0, 2).join('') || 'U',
                status: 'offline',
                department: '',
                phone,
                whatsappConsent: false,
                organisationId: newUserOrganisationId || null,
                joinedAt: new Date().toISOString(),
            });
            // If a plan is selected and the user belongs to an organisation, set up subscription.
            const organisationId = newUserOrganisationId || undefined;
            if (newUserPlanId && organisationId) {
                await api.ensureSubscription(organisationId, newUserPlanId, newUserActive ? 'active' : 'paused');
            }
            setNewUserName('');
            setNewUserEmail('');
            setNewUserPhone('');
            setNewUserPassword('');
            setNewUserRole('member');
            setNewUserPlanId('');
            setNewUserActive(false);
            setNewUserOrganisationId('');
            setShowAddUserModal(false);
            refreshAll();
            // Reload expanded organisation users if applicable
            if (organisationId && expandedOrgId === organisationId) {
                await loadOrganisationUsers(organisationId);
            }
        } catch (err) {
            setCreateUserError(err instanceof Error ? err.message : t({ de: 'Benutzer konnte nicht erstellt werden.', en: 'Failed to create user.', tr: 'Kullanıcı oluşturulamadı.' }));
        } finally {
            setCreateUserLoading(false);
        }
    };

    const handleToggleSuperAdmin = async (userId: string, currentStatus: boolean) => {
        if (userId === currentUser?.id) return;
        try {
            await api.updateUserSuperAdmin(userId, !currentStatus);
            loadUsers();
            if (expandedOrgId) loadOrganisationUsers(expandedOrgId);
        } catch (err) {
            console.error('Failed to update super-admin status:', err);
        }
    };

    const handleDeleteUser = async (userId: string) => {
        if (userId === currentUser?.id) return;
        if (!confirm(t({ de: 'Soll dieser Benutzer wirklich gelöscht werden?', en: 'Do you really want to delete this user?', tr: 'Bu kullanıcı gerçekten silinsin mi?' }))) return;
        try {
            await api.deleteUser(userId);
            loadUsers();
            if (expandedOrgId) loadOrganisationUsers(expandedOrgId);
        } catch (err) {
            console.error('Failed to delete user:', err);
        }
    };

    const getUserOrganisation = (user: User): Organisation | undefined =>
        organisations.find(o => o.id === user.organisationId);

    const handleToggleUserActive = async (user: User) => {
        if (user.id === currentUser?.id) return;
        const nextActive = !user.isActive;
        const org = getUserOrganisation(user);
        try {
            await api.updateUserActiveStatus(user.id, nextActive);
            if (nextActive && org) {
                const planId = org.requestedPlanId ?? org.planId ?? allPlans[0]?.id;
                if (planId) {
                    await api.ensureSubscription(org.id, planId, 'active');
                    if (org.requestedPlanId) {
                        await api.updateOrganisationRequestedPlan(org.id, null);
                    }
                }
            } else if (!nextActive && org) {
                const sub = orgSubscription(org.id);
                if (sub) {
                    await api.updateSubscription(sub.id, { status: 'paused' });
                }
            }
            loadUsers();
            loadSubscriptions();
            if (user.organisationId) loadOrganisationUsers(user.organisationId);
        } catch (err) {
            console.error('Failed to update active status:', err);
        }
    };

    const handleChangeUserPlan = async (user: User, newPlanId: string) => {
        const org = getUserOrganisation(user);
        if (!org) return;
        try {
            await api.updateOrganisationRequestedPlan(org.id, newPlanId || null);
            loadOrganisations();
            loadSubscriptions();
        } catch (err) {
            console.error('Failed to update organisation requested plan:', err);
        }
    };

    const handleApproveOrganisationPlanChange = async (org: Organisation) => {
        if (!org.requestedPlanId) return;
        try {
            const requestedPlan = allPlans.find(p => p.id === org.requestedPlanId);
            if (!requestedPlan) {
                setOrgMessage(org.id, { error: t({ de: 'Angeforderter Plan nicht gefunden.', en: 'Requested plan not found.', tr: 'Talep edilen plan bulunamadı.' }) });
                return;
            }
            const usersInOrg = orgUsers[org.id] ?? await api.fetchOrganisationUsers(org.id);
            if (usersInOrg.length > requestedPlan.maxSeats) {
                setOrgMessage(org.id, { error: t({ de: `Planwechsel abgelehnt: ${usersInOrg.length} Benutzer passen nicht in ${requestedPlan.name} (${requestedPlan.maxSeats} Plätze).`, en: `Plan change rejected: ${usersInOrg.length} users do not fit into ${requestedPlan.name} (${requestedPlan.maxSeats} seats).`, tr: `Plan değişikliği reddedildi: ${usersInOrg.length} kullanıcı ${requestedPlan.name} (${requestedPlan.maxSeats} koltuk) planına sığmıyor.` }) });
                return;
            }
            const sub = orgSubscription(org.id);
            if (sub) {
                await api.updateSubscription(sub.id, { planId: requestedPlan.id, status: 'active' });
            } else {
                await api.createSubscription(org.id, requestedPlan.id, 'monthly');
            }
            await api.updateOrganisationRequestedPlan(org.id, null);
            setOrgMessage(org.id, { success: t({ de: `Planwechsel zu ${requestedPlan.name} freigegeben.`, en: `Plan change to ${requestedPlan.name} approved.`, tr: `${requestedPlan.name} plan değişikliği onaylandı.` }) });
            refreshAll();
        } catch (err) {
            console.error('Failed to approve organisation plan change:', err);
            setOrgMessage(org.id, { error: t({ de: 'Freigabe fehlgeschlagen.', en: 'Approval failed.', tr: 'Onay başarısız.' }) });
        }
    };

    const handleRejectOrganisationPlanChange = async (org: Organisation) => {
        try {
            await api.updateOrganisationRequestedPlan(org.id, null);
            setOrgMessage(org.id, { success: t({ de: 'Planwechsel abgelehnt.', en: 'Plan change rejected.', tr: 'Plan değişikliği reddedildi.' }) });
            loadOrganisations();
        } catch (err) {
            console.error('Failed to reject organisation plan change:', err);
            setOrgMessage(org.id, { error: t({ de: 'Ablehnung fehlgeschlagen.', en: 'Rejection failed.', tr: 'Ret başarısız.' }) });
        }
    };

    const handleApplyOrganisationPlan = async (org: Organisation, newPlanId: string) => {
        try {
            const sub = orgSubscription(org.id);
            if (sub) {
                await api.updateSubscription(sub.id, { planId: newPlanId, status: 'active' });
            } else if (newPlanId) {
                await api.createSubscription(org.id, newPlanId, 'monthly');
            }
            if (org.requestedPlanId) {
                await api.updateOrganisationRequestedPlan(org.id, null);
            }
            setOrgMessage(org.id, { success: t({ de: 'Plan direkt aktualisiert.', en: 'Plan updated directly.', tr: 'Plan doğrudan güncellendi.' }) });
            refreshAll();
        } catch (err) {
            console.error('Failed to apply organisation plan:', err);
            setOrgMessage(org.id, { error: t({ de: 'Plan konnte nicht aktualisiert werden.', en: 'Failed to update plan.', tr: 'Plan güncellenemedi.' }) });
        }
    };

    const handleEditOrganisationName = async (org: Organisation) => {
        const name = editingOrgName.trim();
        if (!name || name === org.name) {
            setEditingOrgId(null);
            return;
        }
        try {
            await api.updateOrganisation(org.id, { name, slug: `${generateSlug(name)}-${Date.now().toString(36)}` });
            setEditingOrgId(null);
            loadOrganisations();
        } catch (err) {
            console.error('Failed to update organisation name:', err);
        }
    };

    const loadOrganisationUsers = async (organisationId: string) => {
        try {
            const data = await api.fetchOrganisationUsers(organisationId);
            setOrgUsers(prev => ({ ...prev, [organisationId]: data }));
            return data;
        } catch (err) {
            console.error('Failed to load organisation users:', err);
            return [];
        }
    };

    const loadOrganisationCompanies = async (organisationId: string) => {
        try {
            const data = await api.fetchOrganisationCompanies(organisationId);
            setOrgCompanies(prev => ({ ...prev, [organisationId]: data }));
            return data;
        } catch (err) {
            console.error('Failed to load organisation companies:', err);
            return [];
        }
    };

    const toggleExpandOrganisation = async (orgId: string) => {
        if (expandedOrgId === orgId) {
            setExpandedOrgId(null);
            return;
        }
        setExpandedOrgId(orgId);
        await Promise.all([loadOrganisationUsers(orgId), loadOrganisationCompanies(orgId)]);
        const companies = await api.fetchOrganisationCompanies(orgId);
        for (const company of companies) {
            await loadCompanyMembers(company.id);
        }
    };

    const setOrgMessage = (orgId: string, payload: { error?: string; success?: string }) => {
        setOrgFeedback(prev => ({ ...prev, [orgId]: payload }));
    };

    const setCompanyMessage = (companyId: string, payload: { error?: string; success?: string }) => {
        setCompanyFeedback(prev => ({ ...prev, [companyId]: payload }));
    };

    const loadCompanyMembers = async (companyId: string) => {
        try {
            const members = await api.fetchCompanyMembers(companyId);
            const firstUnassignedUser = users.find(u => !members.some(m => m.userId === u.id));
            setCompanyMembers(prev => ({
                ...prev,
                [companyId]: members.map(m => ({
                    memberId: m.id,
                    userId: m.userId,
                    role: m.role,
                    userName: m.userName ?? t({ de: 'Unbekannt', en: 'Unknown', tr: 'Bilinmeyen' }),
                    userEmail: m.userEmail ?? '',
                })),
            }));
            setAssignByCompany(prev => ({
                ...prev,
                [companyId]: prev[companyId] ?? {
                    userId: firstUnassignedUser?.id ?? '',
                    role: 'member',
                },
            }));
        } catch (err) {
            console.error('Failed to load members:', err);
        }
    };

    const handleAssignUserToCompany = async (companyId: string, organisationId: string) => {
        const selectedUserId = assignByCompany[companyId]?.userId;
        const selectedRole = assignByCompany[companyId]?.role ?? 'member';
        if (!selectedUserId) {
            setCompanyMessage(companyId, { error: t({ de: 'Bitte zuerst einen Benutzer auswählen.', en: 'Please select a user first.', tr: 'Lütfen önce bir kullanıcı seçin.' }) });
            return;
        }
        const selectedUser = users.find(u => u.id === selectedUserId);
        if (!selectedUser) {
            setCompanyMessage(companyId, { error: t({ de: 'Benutzer nicht gefunden.', en: 'User not found.', tr: 'Kullanıcı bulunamadı.' }) });
            return;
        }
        try {
            setCompanyMessage(companyId, {});
            // Super-admins may assign any user to any project. Add the membership first,
            // then move the user to the project's organisation if necessary.
            await api.addCompanyMember(companyId, selectedUserId, selectedRole);
            if (selectedUser.organisationId !== organisationId) {
                await api.assignUserToOrganisation(selectedUserId, organisationId || null);
            }
            await loadCompanyMembers(companyId);
            const updatedMembers = companyMembers[companyId] ?? [];
            const nextUnassigned = users.find(u => !updatedMembers.some(m => m.userId === u.id));
            setAssignByCompany(prev => ({
                ...prev,
                [companyId]: {
                    userId: nextUnassigned?.id ?? '',
                    role: 'member',
                },
            }));
            setCompanyMessage(companyId, { success: t({ de: 'Benutzer erfolgreich zum Projekt zugewiesen.', en: 'User successfully assigned to project.', tr: 'Kullanıcı projeye başarıyla atandı.' }) });
            loadSubscriptions();
            loadUsers();
            if (selectedUser.organisationId && selectedUser.organisationId !== organisationId) {
                loadOrganisationUsers(selectedUser.organisationId);
            }
            if (organisationId) loadOrganisationUsers(organisationId);
        } catch (err) {
            setCompanyMessage(companyId, { error: err instanceof Error ? err.message : t({ de: 'Zuweisung fehlgeschlagen. Benutzer ist ggf. bereits Mitglied.', en: 'Assignment failed. User may already be a member.', tr: 'Atama başarısız. Kullanıcı zaten üye olabilir.' }) });
        }
    };

    const handleUpdateCompanyMemberRole = async (companyId: string, memberId: string, role: CompanyRole) => {
        try {
            setCompanyMessage(companyId, {});
            await api.updateCompanyMemberRole(memberId, role);
            setCompanyMembers(prev => ({
                ...prev,
                [companyId]: (prev[companyId] ?? []).map(member =>
                    member.memberId === memberId ? { ...member, role } : member,
                ),
            }));
            setCompanyMessage(companyId, { success: t({ de: 'Projektrolle aktualisiert.', en: 'Project role updated.', tr: 'Proje rolü güncellendi.' }) });
        } catch {
            setCompanyMessage(companyId, { error: t({ de: 'Rolle konnte nicht aktualisiert werden.', en: 'Role could not be updated.', tr: 'Rol güncellenemedi.' }) });
        }
    };

    const handleRemoveCompanyMember = async (companyId: string, memberId: string, userName: string) => {
        const companyList = companyMembers[companyId] ?? [];
        const targetMember = companyList.find(m => m.memberId === memberId);
        if (!targetMember) {
            setCompanyMessage(companyId, { error: t({ de: 'Mitglied nicht gefunden.', en: 'Member not found.', tr: 'Üye bulunamadı.' }) });
            return;
        }

        const isCurrentUserInActiveCompany =
            targetMember.userId === currentUser?.id && activeCompany?.id === companyId;
        if (isCurrentUserInActiveCompany) {
            setCompanyMessage(companyId, { error: t({ de: 'Du kannst deinen eigenen Account nicht aus dem aktiven Projekt entfernen.', en: 'You cannot remove your own account from the active project.', tr: 'Aktif projeden kendi hesabınızı kaldıramazsınız.' }) });
            return;
        }

        const adminCount = companyList.filter(m => m.role === 'company_admin').length;
        const isLastAdmin = targetMember.role === 'company_admin' && adminCount <= 1;
        if (isLastAdmin) {
            setCompanyMessage(companyId, { error: t({ de: 'Der letzte Admin eines Projekts kann nicht entfernt werden.', en: 'The last admin of a project cannot be removed.', tr: 'Bir projenin son admini kaldırılamaz.' }) });
            return;
        }

        const confirmed = confirm(t({ de: `Soll ${userName} wirklich aus diesem Projekt entfernt werden?`, en: `Do you really want to remove ${userName} from this project?`, tr: `${userName} bu projeden gerçekten kaldırılsın mı?` }));
        if (!confirmed) return;
        try {
            setCompanyMessage(companyId, {});
            await api.removeCompanyMember(memberId);
            await loadCompanyMembers(companyId);
            setCompanyMessage(companyId, { success: t({ de: `${userName} wurde aus dem Projekt entfernt.`, en: `${userName} was removed from the project.`, tr: `${userName} projeden kaldırıldı.` }) });
        } catch {
            setCompanyMessage(companyId, { error: t({ de: 'Mitglied konnte nicht entfernt werden.', en: 'Member could not be removed.', tr: 'Üye kaldırılamadı.' }) });
        }
    };

    const handleDeleteCompany = async (companyId: string, organisationId: string) => {
        if (!confirm(t({ de: 'Soll dieses Projekt wirklich gelöscht werden? Alle zugehörigen Daten gehen verloren.', en: 'Do you really want to delete this project? All associated data will be lost.', tr: 'Bu proje gerçekten silinsin mi? Tüm ilişkili veriler kaybolacak.' }))) return;
        try {
            await api.deleteCompany(companyId);
            loadOrganisationCompanies(organisationId);
            loadSubscriptions();
        } catch (err) {
            console.error('Failed to delete company:', err);
        }
    };

    const handleChangeUserRole = async (user: User, role: CompanyRole) => {
        if (user.id === currentUser?.id) return;
        try {
            await api.updateUserRole(user.id, role);
            loadUsers();
            if (user.organisationId) loadOrganisationUsers(user.organisationId);
        } catch (err) {
            console.error('Failed to update user role:', err);
        }
    };

    const handleChangeUserOrganisation = async (user: User, organisationId: string) => {
        if (user.id === currentUser?.id) return;
        try {
            await api.assignUserToOrganisation(user.id, organisationId || null);
            const previousOrgId = user.organisationId;
            loadUsers();
            loadOrganisations();
            if (previousOrgId) loadOrganisationUsers(previousOrgId);
            if (organisationId) loadOrganisationUsers(organisationId);
        } catch (err) {
            console.error('Failed to update user organisation:', err);
        }
    };

    const handleAssignUserToOrganisation = async (organisationId: string) => {
        const userId = addToOrgUserId[organisationId];
        if (!userId) {
            setOrgMessage(organisationId, { error: t({ de: 'Bitte zuerst einen Benutzer auswählen.', en: 'Please select a user first.', tr: 'Lütfen önce bir kullanıcı seçin.' }) });
            return;
        }
        try {
            setOrgMessage(organisationId, {});
            await api.assignUserToOrganisation(userId, organisationId);
            setAddToOrgUserId(prev => ({ ...prev, [organisationId]: '' }));
            setOrgMessage(organisationId, { success: t({ de: 'Benutzer wurde zur Organisation hinzugefügt.', en: 'User was added to the organisation.', tr: 'Kullanıcı organizasyona eklendi.' }) });
            loadUsers();
            loadOrganisationUsers(organisationId);
        } catch (err) {
            setOrgMessage(organisationId, { error: err instanceof Error ? err.message : t({ de: 'Benutzer konnte nicht hinzugefügt werden.', en: 'User could not be added.', tr: 'Kullanıcı eklenemedi.' }) });
        }
    };

    const handleRemoveUserFromOrganisation = async (user: User) => {
        if (user.id === currentUser?.id || !user.organisationId) return;
        const org = getUserOrganisation(user);
        if (!org) return;
        if (!confirm(t({ de: `Soll ${user.name} wirklich aus der Organisation "${org.name}" entfernt werden? Alle Projektmitgliedschaften in dieser Organisation werden ebenfalls aufgelöst.`, en: `Do you really want to remove ${user.name} from the organisation "${org.name}"? All project memberships in this organisation will also be removed.`, tr: `${user.name} gerçekten "${org.name}" organizasyonundan kaldırılsın mı? Bu organizasyondaki tüm proje üyelikleri de kaldırılacak.` }))) return;
        try {
            setOrgMessage(org.id, {});
            const companies = orgCompanies[org.id] ?? await api.fetchOrganisationCompanies(org.id);
            for (const company of companies) {
                const members = await api.fetchCompanyMembers(company.id);
                const member = members.find(m => m.userId === user.id);
                if (member) {
                    await api.removeCompanyMember(member.id);
                }
            }
            await api.assignUserToOrganisation(user.id, null);
            setOrgMessage(org.id, { success: t({ de: `${user.name} wurde aus der Organisation entfernt.`, en: `${user.name} was removed from the organisation.`, tr: `${user.name} organizasyondan kaldırıldı.` }) });
            loadUsers();
            loadOrganisationUsers(org.id);
            for (const company of companies) {
                loadCompanyMembers(company.id);
            }
        } catch (err) {
            setOrgMessage(org.id, { error: err instanceof Error ? err.message : t({ de: 'Benutzer konnte nicht entfernt werden.', en: 'User could not be removed.', tr: 'Kullanıcı kaldırılamadı.' }) });
        }
    };

    const ownerName = (ownerId?: string | null) => {
        if (!ownerId) return t({ de: 'Kein Eigentümer', en: 'No owner', tr: 'Sahip yok' });
        const owner = users.find(u => u.id === ownerId);
        return owner?.name ?? t({ de: 'Unbekannt', en: 'Unknown', tr: 'Bilinmeyen' });
    };

    const tabs: { id: AdminTab; label: string; icon: typeof Building2; count: number }[] = [
        { id: 'organisations', label: t({ de: 'Organisationen', en: 'Organisations', tr: 'Organizasyonlar' }), icon: Building2, count: organisations.length },
        { id: 'users', label: t({ de: 'Benutzer', en: 'Users', tr: 'Kullanıcılar' }), icon: Users2, count: users.length },
    ];

    const renderOrganisationUsers = (orgId: string) => {
        const usersInOrg = orgUsers[orgId] ?? [];
        const availableUsers = users.filter(u => u.id !== currentUser?.id && u.organisationId !== orgId);
        return (
            <div>
                <div style={{
                    fontSize: 'var(--font-size-xs)', fontWeight: 600,
                    color: 'var(--text-tertiary)', marginBottom: '8px',
                    textTransform: 'uppercase',
                }}>
                    {t({ de: 'Benutzer', en: 'Users', tr: 'Kullanıcılar' })} ({usersInOrg.length})
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', flexWrap: 'wrap', marginBottom: '12px' }}>
                    <select
                        className="form-select"
                        value={addToOrgUserId[orgId] ?? ''}
                        onChange={e => setAddToOrgUserId(prev => ({ ...prev, [orgId]: e.target.value }))}
                        style={{ minWidth: '220px', fontSize: '0.72rem' }}
                    >
                        <option value="">{t({ de: 'Benutzer zur Organisation hinzufügen...', en: 'Add user to organisation...', tr: 'Organizasyona kullanıcı ekle...' })}</option>
                        {availableUsers.map(user => (
                            <option key={user.id} value={user.id}>
                                {user.name} ({user.email})
                            </option>
                        ))}
                    </select>
                    <button
                        className="btn btn-primary btn-sm"
                        onClick={() => handleAssignUserToOrganisation(orgId)}
                        disabled={!addToOrgUserId[orgId]}
                    >
                        <UserPlus size={14} /> {t({ de: 'Hinzufügen', en: 'Add', tr: 'Ekle' })}
                    </button>
                </div>
                {usersInOrg.length === 0 ? (
                    <p style={{ fontSize: 'var(--font-size-xs)', color: 'var(--text-tertiary)' }}>
                        {t({ de: 'Keine Benutzer zugewiesen.', en: 'No users assigned.', tr: 'Kullanıcı atanmadı.' })}
                    </p>
                ) : (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                        {usersInOrg.map(user => {
                            const isMe = user.id === currentUser?.id;
                            return (
                                <div key={user.id} style={{
                                    display: 'flex', alignItems: 'center', gap: '10px',
                                    padding: '8px 10px', borderRadius: 'var(--radius-sm)',
                                    background: 'var(--bg-hover)',
                                }}>
                                    <div style={{
                                        width: 32, height: 32, borderRadius: 'var(--radius-md)',
                                        background: user.isSuperAdmin ? 'rgba(245, 158, 11, 0.12)' : 'var(--bg-base)',
                                        display: 'flex', alignItems: 'center', justifyContent: 'center',
                                        fontWeight: 700, fontSize: 'var(--font-size-xs)', flexShrink: 0,
                                        color: user.isSuperAdmin ? '#f59e0b' : 'var(--text-secondary)',
                                    }}>
                                        {user.avatar}
                                    </div>
                                    <div style={{ flex: 1, minWidth: 0 }}>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '6px', flexWrap: 'wrap' }}>
                                            <span style={{ fontSize: 'var(--font-size-xs)', fontWeight: 600 }}>{user.name}</span>
                                            {isMe && (
                                                <span style={{
                                                    fontSize: '0.6rem', padding: '1px 5px',
                                                    borderRadius: 'var(--radius-full)',
                                                    background: 'rgba(220,38,38,0.1)',
                                                    color: 'var(--color-primary-light)', fontWeight: 700,
                                                }}>{t({ de: 'Du', en: 'You', tr: 'Sen' })}</span>
                                            )}
                                            {user.isSuperAdmin && (
                                                <span style={{
                                                    display: 'flex', alignItems: 'center', gap: '3px',
                                                    fontSize: '0.6rem', padding: '1px 6px',
                                                    borderRadius: 'var(--radius-full)',
                                                    background: 'rgba(245, 158, 11, 0.12)',
                                                    color: '#f59e0b', fontWeight: 700,
                                                }}>
                                                    <Crown size={9} /> {t({ de: 'Super-Admin', en: 'Super Admin', tr: 'Süper Admin' })}
                                                </span>
                                            )}
                                            <span style={{
                                                fontSize: '0.6rem', padding: '1px 5px',
                                                borderRadius: 'var(--radius-full)',
                                                background: user.isActive ? 'rgba(16, 185, 129, 0.1)' : 'rgba(239, 68, 68, 0.1)',
                                                color: user.isActive ? '#10b981' : '#ef4444', fontWeight: 600,
                                            }}>
                                                {user.isActive ? 'Active' : 'Pending Approval'}
                                            </span>
                                        </div>
                                        <div style={{ fontSize: '0.68rem', color: 'var(--text-tertiary)', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                                            {user.email}
                                        </div>
                                    </div>
                                    <div style={{ display: 'flex', gap: '4px', flexShrink: 0 }}>
                                        {!isMe && (
                                            <>
                                                <button
                                                    className="btn btn-ghost btn-sm"
                                                    style={{ color: user.isSuperAdmin ? '#f59e0b' : 'var(--text-tertiary)', padding: '4px 6px' }}
                                                    onClick={() => handleToggleSuperAdmin(user.id, user.isSuperAdmin)}
                                                    title={user.isSuperAdmin ? t({ de: 'Super-Admin entziehen', en: 'Revoke Super Admin', tr: 'Süper Admin\'i Kaldır' }) : t({ de: 'Zum Super-Admin machen', en: 'Make Super Admin', tr: 'Süper Admin Yap' })}
                                                >
                                                    <Crown size={14} />
                                                </button>
                                                <button
                                                    className="btn btn-ghost btn-sm"
                                                    style={{ color: user.isActive ? 'var(--color-danger)' : 'var(--color-success)', padding: '4px 6px' }}
                                                    onClick={() => handleToggleUserActive(user)}
                                                    title={user.isActive ? 'Deactivate User' : 'Approve & Activate User'}
                                                >
                                                    {user.isActive ? <X size={14} /> : <Check size={14} />}
                                                </button>
                                                <button
                                                    className="btn btn-ghost btn-sm"
                                                    style={{ color: 'var(--color-danger)', padding: '4px 6px' }}
                                                    onClick={() => handleDeleteUser(user.id)}
                                                >
                                                    <Trash2 size={14} />
                                                </button>
                                                {user.organisationId && (
                                                    <button
                                                        className="btn btn-ghost btn-sm"
                                                        style={{ color: 'var(--text-tertiary)', padding: '4px 6px' }}
                                                        onClick={() => handleRemoveUserFromOrganisation(user)}
                                                        title={t({ de: 'Aus Organisation entfernen', en: 'Remove from organisation', tr: 'Organizasyondan kaldır' })}
                                                    >
                                                        <UserMinus size={14} />
                                                    </button>
                                                )}
                                            </>
                                        )}
                                    </div>
                                </div>
                            );
                        })}
                    </div>
                )}
            </div>
        );
    };

    const renderOrganisationCompanies = (orgId: string) => {
        const companiesInOrg = orgCompanies[orgId] ?? [];
        return (
            <div style={{ marginTop: '16px' }}>
                <div style={{
                    fontSize: 'var(--font-size-xs)', fontWeight: 600,
                    color: 'var(--text-tertiary)', marginBottom: '8px',
                    textTransform: 'uppercase',
                }}>
                    {t({ de: 'Projekte', en: 'Projects', tr: 'Projeler' })} ({companiesInOrg.length})
                </div>
                {companiesInOrg.length === 0 ? (
                    <p style={{ fontSize: 'var(--font-size-xs)', color: 'var(--text-tertiary)' }}>
                        {t({ de: 'Keine Projekte zugewiesen.', en: 'No projects assigned.', tr: 'Proje atanmadı.' })}
                    </p>
                ) : (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                        {companiesInOrg.map(company => (
                            <div key={company.id} style={{
                                padding: '12px', borderRadius: 'var(--radius-md)',
                                background: 'var(--bg-base)', border: '1px solid var(--border-color)',
                            }}>
                                <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: '10px', marginBottom: '10px' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '10px', minWidth: 0 }}>
                                        <div style={{
                                            width: 32, height: 32, borderRadius: 'var(--radius-md)',
                                            background: 'linear-gradient(135deg, var(--color-primary), var(--color-accent))',
                                            display: 'flex', alignItems: 'center', justifyContent: 'center',
                                            fontWeight: 700, color: 'white', fontSize: 'var(--font-size-xs)', flexShrink: 0,
                                        }}>
                                            {company.logo || company.name.charAt(0)}
                                        </div>
                                        <div style={{ minWidth: 0 }}>
                                            <div style={{ fontSize: 'var(--font-size-xs)', fontWeight: 700 }}>{company.name}</div>
                                            <div style={{ fontSize: '0.68rem', color: 'var(--text-tertiary)' }}>
                                                {company.industry || t({ de: 'Keine Branche', en: 'No industry', tr: 'Sektör yok' })} · {(companyMembers[company.id] ?? []).length} {t({ de: 'Mitglieder', en: 'Members', tr: 'Üyeler' })}
                                            </div>
                                        </div>
                                    </div>
                                    <button
                                        className="btn btn-ghost btn-sm"
                                        style={{ color: 'var(--color-danger)', padding: '4px 6px' }}
                                        onClick={() => handleDeleteCompany(company.id, orgId)}
                                    >
                                        <Trash2 size={14} />
                                    </button>
                                </div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', flexWrap: 'wrap', marginBottom: '10px' }}>
                                    <select
                                        className="form-select"
                                        value={assignByCompany[company.id]?.userId ?? ''}
                                        onChange={e => setAssignByCompany(prev => ({
                                            ...prev,
                                            [company.id]: {
                                                userId: e.target.value,
                                                role: prev[company.id]?.role ?? 'member',
                                            },
                                        }))}
                                        style={{ minWidth: '200px', fontSize: '0.72rem' }}
                                    >
                                        <option value="">{t({ de: 'Benutzer wählen', en: 'Select user', tr: 'Kullanıcı seç' })}</option>
                                        {users
                                            .filter(user => !(companyMembers[company.id] ?? []).some(member => member.userId === user.id))
                                            .map(user => (
                                                <option key={user.id} value={user.id}>
                                                    {user.name} ({user.email})
                                                </option>
                                            ))}
                                    </select>
                                    <select
                                        className="form-select"
                                        value={assignByCompany[company.id]?.role ?? 'member'}
                                        onChange={e => setAssignByCompany(prev => ({
                                            ...prev,
                                            [company.id]: {
                                                userId: prev[company.id]?.userId ?? '',
                                                role: e.target.value as CompanyRole,
                                            },
                                        }))}
                                        style={{ minWidth: '110px', fontSize: '0.72rem' }}
                                    >
                                        <option value="company_admin">Admin</option>
                                        <option value="manager">Manager</option>
                                        <option value="member">Member</option>
                                    </select>
                                    <button
                                        className="btn btn-primary btn-sm"
                                        onClick={() => handleAssignUserToCompany(company.id, orgId)}
                                    >
                                        <UserCheck size={14} /> {t({ de: 'Zuweisen', en: 'Assign', tr: 'Ata' })}
                                    </button>
                                </div>
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                                    {(companyMembers[company.id] ?? []).length === 0 ? (
                                        <p style={{ fontSize: 'var(--font-size-xs)', color: 'var(--text-tertiary)' }}>
                                            {t({ de: 'Keine Mitglieder zugewiesen.', en: 'No members assigned.', tr: 'Üye atanmadı.' })}
                                        </p>
                                    ) : (
                                        (companyMembers[company.id] ?? []).map((member, idx) => {
                                            const roleCfg = ROLE_CONFIG[member.role];
                                            const adminCount = (companyMembers[company.id] ?? []).filter(m => m.role === 'company_admin').length;
                                            const isLastAdmin = member.role === 'company_admin' && adminCount <= 1;
                                            const isCurrentUserInActiveCompany =
                                                member.userId === currentUser?.id && activeCompany?.id === company.id;
                                            const removeDisabled = isLastAdmin || isCurrentUserInActiveCompany;
                                            const removeTitle = isLastAdmin
                                                ? t({ de: 'Letzten Admin kann man nicht entfernen', en: 'Cannot remove the last admin', tr: 'Son admin kaldırılamaz' })
                                                : isCurrentUserInActiveCompany
                                                    ? t({ de: 'Eigenen Account im aktiven Projekt kann man nicht entfernen', en: 'Cannot remove your own account from the active project', tr: 'Aktif projeden kendi hesabınızı kaldıramazsınız' })
                                                    : t({ de: 'Mitglied entfernen', en: 'Remove member', tr: 'Üyeyi kaldır' });
                                            return (
                                                <div key={idx} style={{
                                                    display: 'grid',
                                                    gridTemplateColumns: 'minmax(0, 1fr) auto auto auto',
                                                    alignItems: 'center',
                                                    gap: '8px',
                                                    padding: '6px 8px', borderRadius: 'var(--radius-sm)',
                                                    background: 'var(--bg-hover)',
                                                }}>
                                                    <div style={{ minWidth: 0, display: 'flex', flexDirection: 'column', gap: '2px' }}>
                                                        <div style={{ fontSize: 'var(--font-size-xs)', fontWeight: 600, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                                                            {member.userName}
                                                        </div>
                                                        {member.userEmail && (
                                                            <div style={{ fontSize: '0.65rem', color: 'var(--text-tertiary)', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                                                                {member.userEmail}
                                                            </div>
                                                        )}
                                                    </div>
                                                    <select
                                                        className="form-select"
                                                        value={member.role}
                                                        onChange={e => handleUpdateCompanyMemberRole(company.id, member.memberId, e.target.value as CompanyRole)}
                                                        style={{ minWidth: '110px', fontSize: '0.7rem', width: '110px' }}
                                                    >
                                                        <option value="company_admin">Admin</option>
                                                        <option value="manager">Manager</option>
                                                        <option value="member">Member</option>
                                                    </select>
                                                    <span style={{
                                                        fontSize: '0.6rem', padding: '1px 6px',
                                                        borderRadius: 'var(--radius-full)',
                                                        background: roleCfg.bgColor, color: roleCfg.color,
                                                        fontWeight: 700,
                                                    }}>
                                                        {roleCfg.shortLabel}
                                                    </span>
                                                    <button
                                                        className="btn btn-ghost btn-sm"
                                                        style={{ color: 'var(--color-danger)', padding: '4px 6px', justifySelf: 'end' }}
                                                        onClick={() => handleRemoveCompanyMember(company.id, member.memberId, member.userName)}
                                                        title={removeTitle}
                                                        disabled={removeDisabled}
                                                    >
                                                        <Trash2 size={14} />
                                                    </button>
                                                </div>
                                            );
                                        })
                                    )}
                                </div>
                                {(companyFeedback[company.id]?.error || companyFeedback[company.id]?.success) && (
                                    <div style={{
                                        marginTop: '8px',
                                        fontSize: 'var(--font-size-xs)',
                                        color: companyFeedback[company.id]?.error ? 'var(--color-danger)' : 'var(--color-success)',
                                    }}>
                                        {companyFeedback[company.id]?.error || companyFeedback[company.id]?.success}
                                    </div>
                                )}
                            </div>
                        ))}
                    </div>
                )}
            </div>
        );
    };

    return (
        <div style={{
            height: '100vh',
            display: 'flex',
            flexDirection: 'column',
            overflow: 'hidden',
            background: 'var(--bg-base)',
        }}>
            {/* Header */}
            <header style={{
                display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                padding: '16px 32px', borderBottom: '1px solid var(--border-color)',
                background: 'var(--bg-surface)',
                flexShrink: 0,
            }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <Link href="/dashboard" style={{ color: 'var(--text-tertiary)', textDecoration: 'none' }}>
                        <ArrowLeft size={20} />
                    </Link>
                    <div style={{
                        width: 36, height: 36, borderRadius: 'var(--radius-md)',
                        background: 'linear-gradient(135deg, #f59e0b, #d97706)',
                        display: 'flex', alignItems: 'center', justifyContent: 'center',
                        fontSize: '1rem', color: 'white', fontWeight: 700,
                    }}>
                        <Shield size={18} />
                    </div>
                    <div>
                        <div style={{ fontWeight: 700, fontSize: 'var(--font-size-base)', color: 'var(--text-primary)' }}>
                            {t({ de: 'Super-Admin Panel', en: 'Super Admin Panel', tr: 'Süper Admin Paneli' })}
                        </div>
                        <div style={{ fontSize: 'var(--font-size-xs)', color: '#f59e0b', fontWeight: 600 }}>
                            {t({ de: 'Globale Verwaltung', en: 'Global Management', tr: 'Genel Yönetim' })}
                        </div>
                    </div>
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                    <PageHelp title={t({ de: 'Super-Admin: Organisationen und Benutzer', en: 'Super Admin: Organisations and Users', tr: 'Süper Admin: Organizasyonlar ve Kullanıcılar' })}>
                        <p><strong>{t({ de: 'Organisationen-Tab:', en: 'Organisations tab:', tr: 'Organizasyonlar sekmesi:' })}</strong> {t({ de: 'Verwalte Organisationen, deren Plan, Benutzer und Projekte. Klappe eine Organisation auf, um Benutzer und Projekte zu bearbeiten.', en: 'Manage organisations, their plan, users and projects. Expand an organisation to edit users and projects.', tr: 'Organizasyonları, planlarını, kullanıcılarını ve projelerini yönetin. Kullanıcıları ve projeleri düzenlemek için bir organizasyonu genişletin.' })}</p>
                        <ul style={{ marginTop: '8px', paddingLeft: '18px' }}>
                            <li>{t({ de: 'Jede Organisation hat einen Eigentümer, einen aktuellen Plan und optional einen angeforderten Plan.', en: 'Each organisation has an owner, a current plan and optionally a requested plan.', tr: 'Her organizasyonun bir sahibi, mevcut bir planı ve isteğe bağlı olarak talep edilen bir planı vardır.' })}</li>
                            <li>{t({ de: 'Benutzer können innerhalb einer Organisation aktiviert, deaktiviert und als Super-Admin markiert werden.', en: 'Users within an organisation can be activated, deactivated and marked as super admin.', tr: 'Bir organizasyon içindeki kullanıcılar etkinleştirilebilir, devre dışı bırakılabilir ve süper admin olarak işaretlenebilir.' })}</li>
                            <li>{t({ de: 'Bestehende Benutzer können einem Projekt innerhalb der Organisation zugewiesen werden.', en: 'Existing users can be assigned to a project within the organisation.', tr: 'Mevcut kullanıcılar organizasyon içindeki bir projeye atanabilir.' })}</li>
                        </ul>
                        <p style={{ marginTop: '10px' }}><strong>{t({ de: 'Benutzer-Tab:', en: 'Users tab:', tr: 'Kullanıcılar sekmesi:' })}</strong> {t({ de: 'Hier werden globale Benutzer gepflegt, inkl. Super-Admin-Status und Organisationszugehörigkeit.', en: 'Global users are managed here, including super admin status and organisation membership.', tr: 'Burada global kullanıcılar yönetilir, süper admin statüsü ve organizasyon üyeliği dahil.' })}</p>
                    </PageHelp>
                    <span style={{ fontSize: 'var(--font-size-sm)', color: 'var(--text-secondary)' }}>
                        {currentUser?.name}
                    </span>
                </div>
            </header>

            <div style={{
                flex: 1,
                display: 'flex',
                justifyContent: 'center',
                overflow: 'hidden',
            }}>
                <div style={{
                    display: 'flex',
                    gap: '0',
                    width: '100%',
                    maxWidth: '1400px',
                    padding: '24px 32px',
                }}>
                    {/* Sidebar */}
                    <div style={{ width: '220px', flexShrink: 0, marginRight: '24px' }}>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                        {tabs.map(tab => {
                            const Icon = tab.icon;
                            return (
                                <button
                                    key={tab.id}
                                    className={`sidebar-link ${activeTab === tab.id ? 'active' : ''}`}
                                    onClick={() => { setActiveTab(tab.id); setSearchQuery(''); }}
                                >
                                    <Icon size={18} />
                                    {tab.label}
                                    <span style={{
                                        marginLeft: 'auto', fontSize: 'var(--font-size-xs)',
                                        background: 'var(--bg-hover)', padding: '1px 7px',
                                        borderRadius: 'var(--radius-full)', color: 'var(--text-tertiary)',
                                        fontWeight: 600,
                                    }}>
                                        {tab.count}
                                    </span>
                                </button>
                            );
                        })}
                    </div>

                    {/* Stats */}
                    <div style={{
                        marginTop: '24px', padding: '16px',
                        background: 'var(--bg-surface)', borderRadius: 'var(--radius-md)',
                        border: '1px solid var(--border-color)',
                    }}>
                        <div style={{
                            fontSize: 'var(--font-size-xs)', color: 'var(--text-tertiary)',
                            fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.05em',
                            marginBottom: '12px',
                        }}>
                            {t({ de: 'Übersicht', en: 'Overview', tr: 'Genel Bakış' })}
                        </div>
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <span style={{ fontSize: 'var(--font-size-xs)', color: 'var(--text-secondary)' }}>{t({ de: 'Organisationen', en: 'Organisations', tr: 'Organizasyonlar' })}</span>
                                <span style={{ fontSize: 'var(--font-size-sm)', fontWeight: 700, color: 'var(--text-primary)' }}>
                                    {organisations.length}
                                </span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <span style={{ fontSize: 'var(--font-size-xs)', color: 'var(--text-secondary)' }}>{t({ de: 'Benutzer', en: 'Users', tr: 'Kullanıcılar' })}</span>
                                <span style={{ fontSize: 'var(--font-size-sm)', fontWeight: 700, color: 'var(--text-primary)' }}>
                                    {users.length}
                                </span>
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <span style={{ fontSize: 'var(--font-size-xs)', color: 'var(--text-secondary)' }}>{t({ de: 'Super-Admins', en: 'Super Admins', tr: 'Süper Adminler' })}</span>
                                <span style={{ fontSize: 'var(--font-size-sm)', fontWeight: 700, color: '#f59e0b' }}>
                                    {users.filter(u => u.isSuperAdmin).length}
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Main Content */}
                <div className="no-scrollbar" style={{ flex: 1, overflow: 'auto', minWidth: 0, paddingBottom: '80px' }}>
                    {/* Search Bar */}
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '20px' }}>
                        <div style={{ flex: 1, position: 'relative' }}>
                            <Search size={16} style={{
                                position: 'absolute', left: '12px', top: '50%',
                                transform: 'translateY(-50%)', color: 'var(--text-tertiary)',
                            }} />
                            <input
                                type="text"
                                className="form-input"
                                placeholder={activeTab === 'organisations' ? t({ de: 'Organisation suchen...', en: 'Search organisations...', tr: 'Organizasyon ara...' }) : t({ de: 'Benutzer suchen...', en: 'Search users...', tr: 'Kullanıcı ara...' })}
                                value={searchQuery}
                                onChange={e => setSearchQuery(e.target.value)}
                                style={{ paddingLeft: '36px' }}
                            />
                        </div>
                        {activeTab === 'organisations' && (
                            <button className="btn btn-primary" onClick={() => setShowCreateOrganisationModal(true)}>
                                <Plus size={16} /> {t({ de: 'Neue Organisation', en: 'New Organisation', tr: 'Yeni Organizasyon' })}
                            </button>
                        )}
                        {activeTab === 'users' && (
                            <button className="btn btn-primary" onClick={() => setShowAddUserModal(true)}>
                                <Plus size={16} /> {t({ de: 'Neuer Benutzer', en: 'New User', tr: 'Yeni Kullanıcı' })}
                            </button>
                        )}
                    </div>

                    {/* Organisations Tab */}
                    {activeTab === 'organisations' && (
                        <div className="animate-in" style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                            {filteredOrganisations.length === 0 ? (
                                <div className="card" style={{ textAlign: 'center', padding: '40px' }}>
                                    <Building2 size={40} style={{ color: 'var(--text-tertiary)', marginBottom: '12px' }} />
                                    <p style={{ color: 'var(--text-secondary)' }}>{t({ de: 'Keine Organisationen gefunden.', en: 'No organisations found.', tr: 'Organizasyon bulunamadı.' })}</p>
                                </div>
                            ) : (
                                filteredOrganisations.map(org => {
                                    const sub = orgSubscription(org.id);
                                    const currentPlanName = allPlans.find(p => p.id === sub?.planId)?.name ?? t({ de: 'Kein Plan', en: 'No plan', tr: 'Plan yok' });
                                    const userCount = (orgUsers[org.id] ?? []).length;
                                    const companyCount = (orgCompanies[org.id] ?? []).length;
                                    return (
                                        <div key={org.id} className="card" style={{
                                            padding: '16px',
                                            borderLeft: '3px solid var(--color-primary)',
                                        }}>
                                            <div style={{ display: 'flex', alignItems: 'center', gap: '14px' }}>
                                                <div style={{
                                                    width: 44, height: 44, borderRadius: 'var(--radius-md)', flexShrink: 0,
                                                    background: 'linear-gradient(135deg, var(--color-primary), var(--color-accent))',
                                                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                                                    fontWeight: 700, color: 'white', fontSize: 'var(--font-size-base)',
                                                }}>
                                                    {org.name.charAt(0)}
                                                </div>
                                                <div style={{ flex: 1, minWidth: 0 }}>
                                                    {editingOrgId === org.id ? (
                                                        <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                                                            <input
                                                                type="text"
                                                                className="form-input"
                                                                value={editingOrgName}
                                                                onChange={e => setEditingOrgName(e.target.value)}
                                                                style={{ fontSize: 'var(--font-size-sm)', padding: '4px 8px' }}
                                                                autoFocus
                                                                onKeyDown={e => { if (e.key === 'Enter') handleEditOrganisationName(org); if (e.key === 'Escape') setEditingOrgId(null); }}
                                                            />
                                                            <button className="btn btn-primary btn-sm" onClick={() => handleEditOrganisationName(org)}><Check size={13} /></button>
                                                            <button className="btn btn-ghost btn-sm" onClick={() => setEditingOrgId(null)}><X size={13} /></button>
                                                        </div>
                                                    ) : (
                                                        <>
                                                            <div style={{ fontWeight: 700, fontSize: 'var(--font-size-sm)' }}>
                                                                {org.name}
                                                            </div>
                                                            <div style={{ fontSize: 'var(--font-size-xs)', color: 'var(--text-tertiary)' }}>
                                                                {t({ de: 'Eigentümer', en: 'Owner', tr: 'Sahip' })}: {ownerName(org.ownerUserId)} · {userCount} {t({ de: 'Benutzer', en: 'Users', tr: 'Kullanıcılar' })} · {companyCount} {t({ de: 'Projekte', en: 'Projects', tr: 'Projeler' })}
                                                            </div>
                                                        </>
                                                    )}
                                                </div>
                                                <div style={{ display: 'flex', gap: '6px', flexShrink: 0 }}>
                                                    <button
                                                        className="btn btn-ghost btn-sm"
                                                        onClick={() => {
                                                            setEditingOrgId(org.id);
                                                            setEditingOrgName(org.name);
                                                        }}
                                                        title={t({ de: 'Namen bearbeiten', en: 'Edit name', tr: 'Adı düzenle' })}
                                                    >
                                                        <Edit3 size={14} />
                                                    </button>
                                                    <button
                                                        className="btn btn-ghost btn-sm"
                                                        onClick={() => toggleExpandOrganisation(org.id)}
                                                    >
                                                        {expandedOrgId === org.id ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
                                                        {t({ de: 'Mitglieder & Projekte', en: 'Members & Projects', tr: 'Üyeler ve Projeler' })}
                                                    </button>
                                                    <button
                                                        className="btn btn-ghost btn-sm"
                                                        style={{ color: 'var(--color-danger)' }}
                                                        onClick={() => handleDeleteOrganisation(org.id)}
                                                    >
                                                        <Trash2 size={14} />
                                                    </button>
                                                </div>
                                            </div>

                                            {/* Plan info & approval */}
                                            <div style={{
                                                marginTop: '12px',
                                                padding: '10px 12px',
                                                borderRadius: 'var(--radius-md)',
                                                background: 'var(--bg-hover)',
                                                display: 'flex',
                                                alignItems: 'center',
                                                gap: '12px',
                                                flexWrap: 'wrap',
                                                fontSize: 'var(--font-size-xs)',
                                            }}>
                                                <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                                                    <span style={{ color: 'var(--text-tertiary)' }}>{t({ de: 'Aktueller Plan:', en: 'Current plan:', tr: 'Mevcut plan:' })}</span>
                                                    <strong style={{ color: 'var(--text-primary)' }}>{currentPlanName}</strong>
                                                </div>
                                                {org.requestedPlanId && (
                                                    <>
                                                        <div style={{ display: 'flex', alignItems: 'center', gap: '6px' }}>
                                                            <span style={{ color: 'var(--text-tertiary)' }}>{t({ de: 'Angefordert:', en: 'Requested:', tr: 'Talep edilen:' })}</span>
                                                            <strong style={{ color: '#b45309' }}>
                                                                {allPlans.find(p => p.id === org.requestedPlanId)?.name ?? org.requestedPlanId}
                                                            </strong>
                                                        </div>
                                                        <div style={{ display: 'flex', gap: '6px', marginLeft: 'auto' }}>
                                                            <button
                                                                className="btn btn-primary btn-sm"
                                                                onClick={() => handleApproveOrganisationPlanChange(org)}
                                                            >
                                                                <Check size={13} /> {t({ de: 'Freigeben', en: 'Approve', tr: 'Onayla' })}
                                                            </button>
                                                            <button
                                                                className="btn btn-ghost btn-sm"
                                                                style={{ color: 'var(--color-danger)' }}
                                                                onClick={() => handleRejectOrganisationPlanChange(org)}
                                                            >
                                                                <X size={13} /> {t({ de: 'Ablehnen', en: 'Reject', tr: 'Reddet' })}
                                                            </button>
                                                        </div>
                                                    </>
                                                )}
                                                {!org.requestedPlanId && (
                                                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px', marginLeft: 'auto' }}>
                                                        <select
                                                            className="form-select"
                                                            value={sub?.planId ?? ''}
                                                            onChange={e => handleApplyOrganisationPlan(org, e.target.value)}
                                                            style={{ minWidth: '140px', fontSize: '0.72rem' }}
                                                        >
                                                            <option value="">{t({ de: 'Plan wählen', en: 'Select plan', tr: 'Plan seç' })}</option>
                                                            {allPlans.map(p => (
                                                                <option key={p.id} value={p.id}>{p.name}</option>
                                                            ))}
                                                        </select>
                                                    </div>
                                                )}
                                            </div>

                                            {expandedOrgId === org.id && (
                                                <div style={{
                                                    marginTop: '12px', paddingTop: '12px',
                                                    borderTop: '1px solid var(--border-color)',
                                                }}>
                                                    {renderOrganisationUsers(org.id)}
                                                    {renderOrganisationCompanies(org.id)}
                                                    {(orgFeedback[org.id]?.error || orgFeedback[org.id]?.success) && (
                                                        <div style={{
                                                            marginTop: '10px',
                                                            fontSize: 'var(--font-size-xs)',
                                                            color: orgFeedback[org.id]?.error ? 'var(--color-danger)' : 'var(--color-success)',
                                                        }}>
                                                            {orgFeedback[org.id]?.error || orgFeedback[org.id]?.success}
                                                        </div>
                                                    )}
                                                </div>
                                            )}
                                        </div>
                                    );
                                })
                            )}
                        </div>
                    )}

                    {/* Users Tab */}
                    {activeTab === 'users' && (
                        <div className="animate-in" style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                            {filteredUsers.length === 0 ? (
                                <div className="card" style={{ textAlign: 'center', padding: '40px' }}>
                                    <Users2 size={40} style={{ color: 'var(--text-tertiary)', marginBottom: '12px' }} />
                                    <p style={{ color: 'var(--text-secondary)' }}>{t({ de: 'Keine Benutzer gefunden.', en: 'No users found.', tr: 'Kullanıcı bulunamadı.' })}</p>
                                </div>
                            ) : (
                                filteredUsers.map(user => {
                                    const isMe = user.id === currentUser?.id;
                                    const org = getUserOrganisation(user);
                                    const sub = org ? orgSubscription(org.id) : null;
                                    return (
                                        <div key={user.id} className="card" style={{
                                            padding: '16px',
                                            borderLeft: user.isSuperAdmin ? '3px solid #f59e0b' : '3px solid var(--border-color)',
                                        }}>
                                            <div style={{ display: 'flex', alignItems: 'center', gap: '14px' }}>
                                                <div style={{
                                                    width: 40, height: 40, borderRadius: 'var(--radius-md)',
                                                    background: user.isSuperAdmin
                                                        ? 'rgba(245, 158, 11, 0.12)'
                                                        : 'var(--bg-hover)',
                                                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                                                    fontWeight: 700, fontSize: 'var(--font-size-xs)', flexShrink: 0,
                                                    color: user.isSuperAdmin ? '#f59e0b' : 'var(--text-secondary)',
                                                }}>
                                                    {user.avatar}
                                                </div>
                                                <div style={{ flex: 1, minWidth: 0 }}>
                                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', flexWrap: 'wrap' }}>
                                                        <span style={{ fontWeight: 600, fontSize: 'var(--font-size-sm)' }}>
                                                            {user.name}
                                                        </span>
                                                        {isMe && (
                                                            <span style={{
                                                                fontSize: '0.6rem', padding: '1px 5px',
                                                                borderRadius: 'var(--radius-full)',
                                                                background: 'rgba(220,38,38,0.1)',
                                                                color: 'var(--color-primary-light)', fontWeight: 700,
                                                            }}>{t({ de: 'Du', en: 'You', tr: 'Sen' })}</span>
                                                        )}
                                                        {user.isSuperAdmin && (
                                                            <span style={{
                                                                display: 'flex', alignItems: 'center', gap: '3px',
                                                                fontSize: '0.6rem', padding: '1px 6px',
                                                                borderRadius: 'var(--radius-full)',
                                                                background: 'rgba(245, 158, 11, 0.12)',
                                                                color: '#f59e0b', fontWeight: 700,
                                                            }}>
                                                                <Crown size={9} /> {t({ de: 'Super-Admin', en: 'Super Admin', tr: 'Süper Admin' })}
                                                            </span>
                                                        )}
                                                        <span style={{
                                                            fontSize: '0.6rem', padding: '1px 5px',
                                                            borderRadius: 'var(--radius-full)',
                                                            background: user.isActive ? 'rgba(16, 185, 129, 0.1)' : 'rgba(239, 68, 68, 0.1)',
                                                            color: user.isActive ? '#10b981' : '#ef4444', fontWeight: 600,
                                                        }}>
                                                            {user.isActive ? 'Active' : 'Pending Approval'}
                                                        </span>
                                                    </div>
                                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', flexWrap: 'wrap', fontSize: 'var(--font-size-xs)', color: 'var(--text-tertiary)' }}>
                                                        <span>{user.email} · {user.jobTitle} · {user.department}</span>
                                                        <select
                                                            value={user.role}
                                                            onChange={(e) => handleChangeUserRole(user, e.target.value as CompanyRole)}
                                                            disabled={isMe}
                                                            style={{
                                                                fontSize: '0.7rem',
                                                                padding: '2px 5px',
                                                                borderRadius: 'var(--radius-sm)',
                                                                border: '1px solid var(--border-color)',
                                                                background: 'var(--bg-base)',
                                                                color: 'var(--text-primary)',
                                                                outline: 'none',
                                                                cursor: isMe ? 'not-allowed' : 'pointer',
                                                                opacity: isMe ? 0.6 : 1,
                                                            }}
                                                        >
                                                            <option value="company_admin">Admin</option>
                                                            <option value="manager">Manager</option>
                                                            <option value="member">Member</option>
                                                        </select>
                                                        <select
                                                            value={user.organisationId ?? ''}
                                                            onChange={(e) => handleChangeUserOrganisation(user, e.target.value)}
                                                            disabled={isMe}
                                                            style={{
                                                                fontSize: '0.7rem',
                                                                padding: '2px 5px',
                                                                borderRadius: 'var(--radius-sm)',
                                                                border: '1px solid var(--border-color)',
                                                                background: 'var(--bg-base)',
                                                                color: 'var(--text-primary)',
                                                                outline: 'none',
                                                                cursor: isMe ? 'not-allowed' : 'pointer',
                                                                opacity: isMe ? 0.6 : 1,
                                                            }}
                                                        >
                                                            <option value="">{t({ de: 'Keine Organisation', en: 'No organisation', tr: 'Organizasyon yok' })}</option>
                                                            {organisations.map(o => (
                                                                <option key={o.id} value={o.id}>{o.name}</option>
                                                            ))}
                                                        </select>
                                                        {allPlans.length > 0 && org && (
                                                            <select
                                                                value={org.requestedPlanId ?? sub?.planId ?? ''}
                                                                onChange={(e) => handleChangeUserPlan(user, e.target.value)}
                                                                disabled={isMe}
                                                                style={{
                                                                    fontSize: '0.7rem',
                                                                    padding: '2px 5px',
                                                                    borderRadius: 'var(--radius-sm)',
                                                                    border: '1px solid var(--border-color)',
                                                                    background: 'var(--bg-base)',
                                                                    color: 'var(--text-primary)',
                                                                    outline: 'none',
                                                                    cursor: isMe ? 'not-allowed' : 'pointer',
                                                                    opacity: isMe ? 0.6 : 1,
                                                                }}
                                                            >
                                                                <option value="">{t({ de: 'Kein Plan', en: 'No plan', tr: 'Plan yok' })}</option>
                                                                {allPlans.map(p => (
                                                                    <option key={p.id} value={p.id}>{p.name}</option>
                                                                ))}
                                                            </select>
                                                        )}
                                                        {org?.requestedPlanId && org.requestedPlanId !== (sub?.planId ?? '') && !user.isActive && (
                                                            <span style={{
                                                                fontSize: '0.6rem', padding: '1px 5px',
                                                                borderRadius: 'var(--radius-full)',
                                                                background: 'rgba(59, 130, 246, 0.1)',
                                                                color: '#3b82f6', fontWeight: 600,
                                                            }}>
                                                                {t({ de: 'Angefragt', en: 'Requested', tr: 'Talep edilen' })}
                                                            </span>
                                                        )}
                                                    </div>
                                                </div>
                                                <div style={{ display: 'flex', gap: '6px', alignItems: 'center', flexShrink: 0 }}>
                                                    {!isMe && (
                                                        <>
                                                            <button
                                                                className="btn btn-ghost btn-sm"
                                                                style={{
                                                                    color: user.isSuperAdmin ? '#f59e0b' : 'var(--text-tertiary)',
                                                                    fontSize: 'var(--font-size-xs)',
                                                                }}
                                                                onClick={() => handleToggleSuperAdmin(user.id, user.isSuperAdmin)}
                                                                title={user.isSuperAdmin ? t({ de: 'Super-Admin entziehen', en: 'Revoke Super Admin', tr: 'Süper Admin\'i Kaldır' }) : t({ de: 'Zum Super-Admin machen', en: 'Make Super Admin', tr: 'Süper Admin Yap' })}
                                                            >
                                                                <Crown size={14} />
                                                                {user.isSuperAdmin ? t({ de: 'SA entziehen', en: 'Revoke SA', tr: 'SA Kaldır' }) : t({ de: 'SA erteilen', en: 'Grant SA', tr: 'SA Ata' })}
                                                            </button>
                                                            <button
                                                                className="btn btn-ghost btn-sm"
                                                                style={{
                                                                    color: user.isActive ? 'var(--color-danger)' : 'var(--color-success)',
                                                                    fontSize: 'var(--font-size-xs)',
                                                                }}
                                                                onClick={() => handleToggleUserActive(user)}
                                                                title={user.isActive ? 'Deactivate User' : 'Approve & Activate User'}
                                                            >
                                                                {user.isActive ? <X size={14} /> : <Check size={14} />}
                                                                {user.isActive ? 'Deactivate' : 'Approve'}
                                                            </button>
                                                            <button
                                                                className="btn btn-ghost btn-sm"
                                                                style={{ color: 'var(--color-danger)' }}
                                                                onClick={() => handleDeleteUser(user.id)}
                                                            >
                                                                <Trash2 size={14} />
                                                            </button>
                                                        </>
                                                    )}
                                                </div>
                                            </div>
                                        </div>
                                    );
                                })
                            )}
                        </div>
                    )}
                </div>
            </div>
            </div>

            {/* Create Organisation Modal */}
            {showCreateOrganisationModal && (
                <div style={{
                    position: 'fixed', inset: 0, zIndex: 100,
                    background: 'rgba(0,0,0,0.4)', display: 'flex',
                    alignItems: 'center', justifyContent: 'center', padding: '24px',
                }} onClick={() => setShowCreateOrganisationModal(false)}>
                    <div style={{
                        background: 'var(--bg-surface)', borderRadius: 'var(--radius-lg)',
                        border: '1px solid var(--border-color)', width: '100%', maxWidth: '420px',
                        padding: '24px',
                    }} onClick={e => e.stopPropagation()}>
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '16px' }}>
                            <h3 style={{ fontWeight: 700, fontSize: 'var(--font-size-base)', color: 'var(--text-primary)' }}>
                                {t({ de: 'Neue Organisation erstellen', en: 'Create new organisation', tr: 'Yeni organizasyon oluştur' })}
                            </h3>
                            <button className="btn btn-ghost btn-sm" onClick={() => setShowCreateOrganisationModal(false)}><X size={16} /></button>
                        </div>
                        <form onSubmit={handleCreateOrganisation} style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                            <div>
                                <label className="form-label">{t({ de: 'Organisationsname', en: 'Organisation name', tr: 'Organizasyon adı' })}</label>
                                <input
                                    type="text"
                                    className="form-input"
                                    value={newOrgName}
                                    onChange={e => setNewOrgName(e.target.value)}
                                    placeholder="WAMOCON GmbH"
                                    disabled={createOrgLoading}
                                />
                            </div>
                            <div>
                                <label className="form-label">{t({ de: 'Eigentümer (optional)', en: 'Owner (optional)', tr: 'Sahip (isteğe bağlı)' })}</label>
                                <select
                                    className="form-select"
                                    value={newOrgOwnerId}
                                    onChange={e => setNewOrgOwnerId(e.target.value)}
                                    disabled={createOrgLoading}
                                >
                                    <option value="">{t({ de: 'Kein Eigentümer', en: 'No owner', tr: 'Sahip yok' })}</option>
                                    {users.map(u => (
                                        <option key={u.id} value={u.id}>{u.name} ({u.email})</option>
                                    ))}
                                </select>
                            </div>
                            <div>
                                <label className="form-label">{t({ de: 'Plan (optional)', en: 'Plan (optional)', tr: 'Plan (isteğe bağlı)' })}</label>
                                <select
                                    className="form-select"
                                    value={newOrgPlanId}
                                    onChange={e => setNewOrgPlanId(e.target.value)}
                                    disabled={createOrgLoading}
                                >
                                    <option value="">{t({ de: 'Kein Plan', en: 'No plan', tr: 'Plan yok' })}</option>
                                    {allPlans.map(p => (
                                        <option key={p.id} value={p.id}>{p.name}</option>
                                    ))}
                                </select>
                            </div>
                            {createOrgError && (
                                <div style={{ fontSize: 'var(--font-size-xs)', color: 'var(--color-danger)' }}>{createOrgError}</div>
                            )}
                            <div style={{ display: 'flex', gap: '8px', justifyContent: 'flex-end', marginTop: '8px' }}>
                                <button type="button" className="btn btn-ghost" onClick={() => setShowCreateOrganisationModal(false)} disabled={createOrgLoading}>
                                    {t({ de: 'Abbrechen', en: 'Cancel', tr: 'İptal' })}
                                </button>
                                <button type="submit" className="btn btn-primary" disabled={createOrgLoading || !newOrgName.trim()}>
                                    {createOrgLoading ? '...' : t({ de: 'Erstellen', en: 'Create', tr: 'Oluştur' })}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            )}

            {/* Create User Modal */}
            {showAddUserModal && (
                <div style={{
                    position: 'fixed', inset: 0, zIndex: 100,
                    background: 'rgba(0,0,0,0.4)', display: 'flex',
                    alignItems: 'center', justifyContent: 'center', padding: '24px',
                }} onClick={() => setShowAddUserModal(false)}>
                    <div style={{
                        background: 'var(--bg-surface)', borderRadius: 'var(--radius-lg)',
                        border: '1px solid var(--border-color)', width: '100%', maxWidth: '420px',
                        padding: '24px',
                    }} onClick={e => e.stopPropagation()}>
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '16px' }}>
                            <h3 style={{ fontWeight: 700, fontSize: 'var(--font-size-base)', color: 'var(--text-primary)' }}>
                                {t({ de: 'Neuen Benutzer erstellen', en: 'Create new user', tr: 'Yeni kullanıcı oluştur' })}
                            </h3>
                            <button className="btn btn-ghost btn-sm" onClick={() => setShowAddUserModal(false)}><X size={16} /></button>
                        </div>
                        <form onSubmit={handleCreateUser} style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                            <div>
                                <label className="form-label">{t({ de: 'Name', en: 'Name', tr: 'Ad' })}</label>
                                <input
                                    type="text"
                                    className="form-input"
                                    value={newUserName}
                                    onChange={e => setNewUserName(e.target.value)}
                                    placeholder="Max Mustermann"
                                    disabled={createUserLoading}
                                />
                            </div>
                            <div>
                                <label className="form-label">{t({ de: 'E-Mail', en: 'Email', tr: 'E-posta' })}</label>
                                <input
                                    type="email"
                                    className="form-input"
                                    value={newUserEmail}
                                    onChange={e => setNewUserEmail(e.target.value)}
                                    placeholder="name@unternehmen.de"
                                    disabled={createUserLoading}
                                />
                            </div>
                            <div>
                                <label className="form-label">{t({ de: 'Telefon', en: 'Phone', tr: 'Telefon' })}</label>
                                <input
                                    type="tel"
                                    className="form-input"
                                    value={newUserPhone}
                                    onChange={e => setNewUserPhone(e.target.value)}
                                    placeholder="+49 170 1234567"
                                    disabled={createUserLoading}
                                />
                            </div>
                            <div>
                                <label className="form-label">{t({ de: 'Passwort', en: 'Password', tr: 'Şifre' })}</label>
                                <input
                                    type="password"
                                    className="form-input"
                                    value={newUserPassword}
                                    onChange={e => setNewUserPassword(e.target.value)}
                                    placeholder="••••••••"
                                    disabled={createUserLoading}
                                />
                            </div>
                            <div>
                                <label className="form-label">{t({ de: 'Rolle', en: 'Role', tr: 'Rol' })}</label>
                                <select
                                    className="form-select"
                                    value={newUserRole}
                                    onChange={e => setNewUserRole(e.target.value as CompanyRole)}
                                    disabled={createUserLoading}
                                >
                                    <option value="company_admin">Admin</option>
                                    <option value="manager">Manager</option>
                                    <option value="member">Member</option>
                                </select>
                            </div>
                            <div>
                                <label className="form-label">{t({ de: 'Organisation', en: 'Organisation', tr: 'Organizasyon' })}</label>
                                <select
                                    className="form-select"
                                    value={newUserOrganisationId}
                                    onChange={e => setNewUserOrganisationId(e.target.value)}
                                    disabled={createUserLoading}
                                >
                                    <option value="">{t({ de: 'Keine Organisation', en: 'No organisation', tr: 'Organizasyon yok' })}</option>
                                    {organisations.map(o => (
                                        <option key={o.id} value={o.id}>{o.name}</option>
                                    ))}
                                </select>
                            </div>
                            <div>
                                <label className="form-label">{t({ de: 'Plan (optional)', en: 'Plan (optional)', tr: 'Plan (isteğe bağlı)' })}</label>
                                <select
                                    className="form-select"
                                    value={newUserPlanId}
                                    onChange={e => setNewUserPlanId(e.target.value)}
                                    disabled={createUserLoading}
                                >
                                    <option value="">{t({ de: 'Kein Plan', en: 'No plan', tr: 'Plan yok' })}</option>
                                    {allPlans.map(p => (
                                        <option key={p.id} value={p.id}>{p.name}</option>
                                    ))}
                                </select>
                            </div>
                            <label style={{ display: 'flex', alignItems: 'center', gap: '8px', fontSize: 'var(--font-size-xs)', color: 'var(--text-secondary)' }}>
                                <input
                                    type="checkbox"
                                    checked={newUserActive}
                                    onChange={e => setNewUserActive(e.target.checked)}
                                    disabled={createUserLoading}
                                />
                                {t({ de: 'Sofort aktivieren', en: 'Activate immediately', tr: 'Hemen etkinleştir' })}
                            </label>
                            {createUserError && (
                                <div style={{ fontSize: 'var(--font-size-xs)', color: 'var(--color-danger)' }}>{createUserError}</div>
                            )}
                            <div style={{ display: 'flex', gap: '8px', justifyContent: 'flex-end', marginTop: '8px' }}>
                                <button type="button" className="btn btn-ghost" onClick={() => setShowAddUserModal(false)} disabled={createUserLoading}>
                                    {t({ de: 'Abbrechen', en: 'Cancel', tr: 'İptal' })}
                                </button>
                                <button type="submit" className="btn btn-primary" disabled={createUserLoading || !newUserName.trim() || !newUserEmail.trim() || !newUserPassword}>
                                    {createUserLoading ? '...' : t({ de: 'Erstellen', en: 'Create', tr: 'Oluştur' })}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            )}
        </div>
    );
}
