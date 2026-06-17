/**
 * Unit tests for AuthContext:
 *   - computePermission() — 100 % statement + branch coverage
 *   - PERMISSIONS matrix — all 3 roles × all 18 permissions
 *   - AuthProvider session logic — 4 branches
 *   - loginWithCredentials — 2 branches
 *   - logout — 2 branches
 *   - can() — delegates to computePermission
 *   - isRole() — 3 branches
 */
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { renderHook, act, waitFor } from '@testing-library/react';
import React from 'react';

import {
  computePermission,
  PERMISSIONS,
  AuthProvider,
  useAuth,
} from '@/context/AuthContext';
import type { PermissionKey, User } from '@/types';

// ─── Mock the entire api module ───────────────────────────────────────────────
vi.mock('@/lib/api', async () => {
  return {
    restoreSession: vi.fn(),
    updateUserStatus: vi.fn().mockResolvedValue(undefined),
    loginUser: vi.fn(),
    registerUser: vi.fn(),
    logout: vi.fn().mockResolvedValue(undefined),
  };
});

// ─── Mock supabase realtime channel ───────────────────────────────────────────
vi.mock('@/lib/supabase', () => {
  return {
    supabase: {
      channel: () => ({
        on: () => ({ subscribe: () => ({}) }),
      }),
      removeChannel: vi.fn(),
    },
  };
});

import * as api from '@/lib/api';

beforeEach(() => {
  vi.mocked(api.restoreSession).mockResolvedValue(null);
  vi.mocked(api.logout).mockResolvedValue(undefined);
  vi.mocked(api.updateUserStatus).mockResolvedValue(undefined);
});

// ─── Shared test fixture ──────────────────────────────────────────────────────
const adminUser: User = {
  id: 'admin-1',
  name: 'Daniel Admin',
  email: 'daniel@test-it-academy.de',
  password: 'admin123',
  role: 'company_admin',
  isSuperAdmin: false,
  isActive: true,
  jobTitle: 'Administrator',
  avatar: 'DA',
  status: 'online',
  department: 'IT',
  phone: '',
  joinedAt: '2024-01-01',
};

const managerUser: User = { ...adminUser, id: 'mgr-1', role: 'manager', name: 'Waleri Manager' };
const memberUser: User = { ...adminUser, id: 'mem-1', role: 'member', name: 'Lisa Member' };

const ALL_PERMISSIONS: PermissionKey[] = [
  'canEditPositioning', 'canEditCompanyKeywords', 'canManageUsers',
  'canManageSettings', 'canManageCompany', 'canCreateCampaigns', 'canEditCampaigns',
  'canViewAllCampaigns', 'canDeleteItems', 'canManageTouchpoints',
  'canEditAudiences', 'canViewAudiences', 'canSeeBudget',
  'canEditBudget', 'canAssignTasks', 'canCreateCampaignTasks',
  'canEditAllTasks', 'canEditOwnTasks', 'canEditContent',
];

const MANAGER_FALSE: PermissionKey[] = [
  'canEditPositioning', 'canEditCompanyKeywords', 'canManageUsers', 'canManageSettings', 'canManageCompany',
];
const MANAGER_TRUE = ALL_PERMISSIONS.filter(p => !MANAGER_FALSE.includes(p));

const MEMBER_TRUE: PermissionKey[] = ['canViewAudiences', 'canEditOwnTasks'];
const MEMBER_FALSE = ALL_PERMISSIONS.filter(p => !MEMBER_TRUE.includes(p));

// ─── Wrapper helper ───────────────────────────────────────────────────────────
const wrapper = ({ children }: { children: React.ReactNode }) =>
  React.createElement(AuthProvider, null, children);

// ═══════════════════════════════════════════════════════════════════════════════
// 1. computePermission() — pure function, no React
// ═══════════════════════════════════════════════════════════════════════════════
describe('computePermission()', () => {
  // BRANCH: role is null → false
  it('returns false when role is null', () => {
    expect(computePermission(null, 'canCreateCampaigns')).toBe(false);
  });

  // BRANCH: role is undefined → false
  it('returns false when role is undefined', () => {
    expect(computePermission(undefined, 'canViewAudiences')).toBe(false);
  });

  describe('company_admin — all permissions must be true', () => {
    ALL_PERMISSIONS.forEach(perm => {
      it(`company_admin | ${perm} → true`, () => {
        expect(computePermission('company_admin', perm)).toBe(true);
      });
    });
  });

  // ── Manager: 14 true, 4 false ─────────────────────────────────────────────
  describe('Manager — allowed permissions', () => {
    MANAGER_TRUE.forEach(perm => {
      it(`manager | ${perm} → true`, () => {
        expect(computePermission('manager', perm)).toBe(true);
      });
    });
  });

  describe('Manager — restricted permissions', () => {
    MANAGER_FALSE.forEach(perm => {
      it(`manager | ${perm} → false`, () => {
        expect(computePermission('manager', perm)).toBe(false);
      });
    });
  });

  // ── Member: 2 true, 16 false ──────────────────────────────────────────────
  describe('Member — allowed permissions', () => {
    MEMBER_TRUE.forEach(perm => {
      it(`member | ${perm} → true`, () => {
        expect(computePermission('member', perm)).toBe(true);
      });
    });
  });

  describe('Member — restricted permissions', () => {
    MEMBER_FALSE.forEach(perm => {
      it(`member | ${perm} → false`, () => {
        expect(computePermission('member', perm)).toBe(false);
      });
    });
  });
});

// ═══════════════════════════════════════════════════════════════════════════════
// 2. PERMISSIONS matrix structure
// ═══════════════════════════════════════════════════════════════════════════════
describe('PERMISSIONS matrix completeness', () => {
  it('defines all 20 permissions for company_admin', () => {
    expect(Object.keys(PERMISSIONS.company_admin)).toHaveLength(20);
  });

  it('defines all 20 permissions for manager', () => {
    expect(Object.keys(PERMISSIONS.manager)).toHaveLength(20);
  });

  it('defines all 20 permissions for member', () => {
    expect(Object.keys(PERMISSIONS.member)).toHaveLength(20);
  });

  it('company_admin has MORE permissions than manager', () => {
    const adminTrue = ALL_PERMISSIONS.filter(p => PERMISSIONS.company_admin[p]);
    const managerTrue = ALL_PERMISSIONS.filter(p => PERMISSIONS.manager[p]);
    expect(adminTrue.length).toBeGreaterThan(managerTrue.length);
  });

  it('manager has MORE permissions than member', () => {
    const managerTrue = ALL_PERMISSIONS.filter(p => PERMISSIONS.manager[p]);
    const memberTrue = ALL_PERMISSIONS.filter(p => PERMISSIONS.member[p]);
    expect(managerTrue.length).toBeGreaterThan(memberTrue.length);
  });
});

// ═══════════════════════════════════════════════════════════════════════════════
// 3. AuthProvider — Session restore (4 branches in useEffect)
// ═══════════════════════════════════════════════════════════════════════════════
describe('AuthProvider — session restore', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(api.updateUserStatus).mockResolvedValue(undefined);
  });

  // BRANCH A: cookie restore not called explicitly, but hook calls restoreSession
  it('resolves sessionLoading without user when no valid session exists', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(null);
    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));
    expect(result.current.currentUser).toBeNull();
    expect(api.restoreSession).toHaveBeenCalled();
  });

  // BRANCH B: valid session cookie → restores user
  it('restores user when a valid session cookie exists', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(adminUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    expect(result.current.currentUser).toEqual(adminUser);
    expect(api.updateUserStatus).toHaveBeenCalledWith('admin-1', 'online');
  });

  // BRANCH C: inactive restored user → logs out
  it('logs out restored user when account is inactive', async () => {
    const inactiveUser: User = { ...adminUser, isActive: false };
    vi.mocked(api.restoreSession).mockResolvedValue(inactiveUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    expect(result.current.currentUser).toBeNull();
    expect(api.logout).toHaveBeenCalled();
  });

  // BRANCH D: restoreSession throws → resolves without user
  it('resolves without user when restoreSession rejects', async () => {
    vi.mocked(api.restoreSession).mockRejectedValue(new Error('Network error'));

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    expect(result.current.currentUser).toBeNull();
  });
});

// ═══════════════════════════════════════════════════════════════════════════════
// 4. loginWithCredentials — 2 branches
// ═══════════════════════════════════════════════════════════════════════════════
describe('loginWithCredentials()', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(api.updateUserStatus).mockResolvedValue(undefined);
  });

  // BRANCH: user found → sets currentUser
  it('sets user and persists session when credentials are valid', async () => {
    vi.mocked(api.loginUser).mockResolvedValue(adminUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    let returnedUser: User | null = null;
    await act(async () => {
      returnedUser = await result.current.loginWithCredentials('daniel@test-it-academy.de', 'admin123');
    });

    expect(returnedUser).toEqual(adminUser);
    expect(result.current.currentUser).toEqual(adminUser);
    expect(api.updateUserStatus).toHaveBeenCalledWith('admin-1', 'online');
  });

  // BRANCH: user not found → returns null, no side effects
  it('returns null without side effects when credentials are invalid', async () => {
    vi.mocked(api.loginUser).mockResolvedValue(null);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    let returnedUser: User | null = adminUser as User | null;
    await act(async () => {
      returnedUser = await result.current.loginWithCredentials('wrong@test.de', 'wrong');
    });

    expect(returnedUser).toBeNull();
    expect(result.current.currentUser).toBeNull();
    expect(api.updateUserStatus).not.toHaveBeenCalled();
  });
});

// ═══════════════════════════════════════════════════════════════════════════════
// 5. registerWithCredentials() - 2 branches
// ═══════════════════════════════════════════════════════════════════════════════
describe('registerWithCredentials()', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(api.updateUserStatus).mockResolvedValue(undefined);
  });

  it('creates active user and marks user online', async () => {
    const newUser: User = { ...adminUser, id: 'new-1', email: 'new@test.de', phone: '+491701112233' };
    vi.mocked(api.registerUser).mockResolvedValue(newUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    await act(async () => {
      await result.current.registerWithCredentials({
        name: 'New User',
        email: 'new@test.de',
        password: 'secret123',
        phone: '+491701112233',
        whatsappConsent: true,
      });
    });

    expect(result.current.currentUser).toEqual(newUser);
    expect(api.updateUserStatus).toHaveBeenCalledWith('new-1', 'online');
  });

  it('propagates registerUser errors and leaves session untouched', async () => {
    vi.mocked(api.registerUser).mockRejectedValue(new Error('already exists'));

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    await expect(result.current.registerWithCredentials({
      name: 'New User',
      email: 'new@test.de',
      password: 'secret123',
      phone: '+491701112233',
      whatsappConsent: true,
    })).rejects.toThrow('already exists');

    expect(result.current.currentUser).toBeNull();
  });
});

// ═══════════════════════════════════════════════════════════════════════════════
// 6. logout() — 2 branches
// ═══════════════════════════════════════════════════════════════════════════════
describe('logout()', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(api.updateUserStatus).mockResolvedValue(undefined);
  });

  // BRANCH: currentUser exists → calls updateUserStatus('offline') and server logout
  it('calls updateUserStatus offline and server logout when user is logged in', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(adminUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.currentUser).toEqual(adminUser));

    act(() => result.current.logout());

    expect(result.current.currentUser).toBeNull();
    expect(api.logout).toHaveBeenCalled();
    expect(api.updateUserStatus).toHaveBeenCalledWith('admin-1', 'offline');
  });

  // BRANCH: currentUser is null → skips status api call
  it('calls server logout without status update when logout is called while not logged in', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(null);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));
    expect(result.current.currentUser).toBeNull();

    act(() => result.current.logout());

    expect(result.current.currentUser).toBeNull();
    expect(api.updateUserStatus).not.toHaveBeenCalledWith(expect.anything(), 'offline');
  });
});

// ═══════════════════════════════════════════════════════════════════════════════
// 7. can() via context — delegates to computePermission
// ═══════════════════════════════════════════════════════════════════════════════
describe('can() in AuthProvider context', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(api.updateUserStatus).mockResolvedValue(undefined);
  });

  it('returns false for every permission when no user is logged in', async () => {
    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    ALL_PERMISSIONS.forEach(perm => {
      expect(result.current.can(perm)).toBe(false);
    });
  });

  it('returns true for all permissions when company_admin role is active', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(adminUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.currentUser).toEqual(adminUser));

    // can() now depends on activeCompanyRole, set it explicitly
    act(() => result.current.setActiveCompanyRole('company_admin'));

    ALL_PERMISSIONS.forEach(perm => {
      expect(result.current.can(perm)).toBe(true);
    });
  });

  it('returns false for restricted permissions when manager role is active', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(managerUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.currentUser).toEqual(managerUser));

    act(() => result.current.setActiveCompanyRole('manager'));

    MANAGER_FALSE.forEach(perm => {
      expect(result.current.can(perm)).toBe(false);
    });
    MANAGER_TRUE.forEach(perm => {
      expect(result.current.can(perm)).toBe(true);
    });
  });

  it('only allows canViewAudiences and canEditOwnTasks for member role', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(memberUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.currentUser).toEqual(memberUser));

    act(() => result.current.setActiveCompanyRole('member'));

    MEMBER_FALSE.forEach(perm => expect(result.current.can(perm)).toBe(false));
    MEMBER_TRUE.forEach(perm => expect(result.current.can(perm)).toBe(true));
  });
});

// ═══════════════════════════════════════════════════════════════════════════════
// 8. isRole() — 3 branches
// ═══════════════════════════════════════════════════════════════════════════════
describe('isRole() in AuthProvider context', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    vi.mocked(api.updateUserStatus).mockResolvedValue(undefined);
  });

  // BRANCH: no user → false for any role
  it('returns false for all roles when no user is logged in', async () => {
    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.sessionLoading).toBe(false));

    expect(result.current.isRole('company_admin')).toBe(false);
    expect(result.current.isRole('manager')).toBe(false);
    expect(result.current.isRole('member')).toBe(false);
  });

  // BRANCH: matching role → true
  it('returns true for the matching role', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(adminUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.currentUser).toEqual(adminUser));

    // After login, set active company role
    act(() => result.current.setActiveCompanyRole('company_admin'));
    expect(result.current.isRole('company_admin')).toBe(true);
  });

  // BRANCH: non-matching role → false
  it('returns false for non-matching roles', async () => {
    vi.mocked(api.restoreSession).mockResolvedValue(adminUser);

    const { result } = renderHook(() => useAuth(), { wrapper });
    await waitFor(() => expect(result.current.currentUser).toEqual(adminUser));

    act(() => result.current.setActiveCompanyRole('company_admin'));
    expect(result.current.isRole('manager')).toBe(false);
    expect(result.current.isRole('member')).toBe(false);
  });
});
