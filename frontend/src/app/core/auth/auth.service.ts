import { Injectable, inject, signal } from '@angular/core';
import { OidcSecurityService } from 'angular-auth-oidc-client';
import { ConfigService } from '../config/config.service';
import { Svc } from '../config/app-config';

interface KeycloakAccessToken {
  preferred_username?: string;
  name?: string;
  realm_access?: { roles?: string[] };
  [key: string]: unknown;
}

/** Thin wrapper over OidcSecurityService that exposes auth state as signals and
 *  centralizes the "auth disabled => allow everything" rule. */
@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly oidc = inject(OidcSecurityService);
  private readonly config = inject(ConfigService);

  readonly isAuthenticated = signal(false);
  readonly userName = signal('');
  readonly roles = signal<string[]>([]);
  readonly accessToken = signal('');

  get enabled(): boolean {
    return this.config.authEnabled;
  }

  /** Called once at startup from the app initializer. */
  init(): void {
    if (!this.enabled) {
      // No authentication: present an anonymous user with full access.
      this.isAuthenticated.set(true);
      this.userName.set('Invitado');
      this.roles.set(['admin']);
      return;
    }

    this.oidc.checkAuth().subscribe();
    this.oidc.isAuthenticated$.subscribe(({ isAuthenticated }) => {
      this.isAuthenticated.set(isAuthenticated);
      if (isAuthenticated) {
        this.oidc.getAccessToken().subscribe((token) => this.applyToken(token));
      } else {
        this.accessToken.set('');
        this.roles.set([]);
        this.userName.set('');
      }
    });
  }

  login(): void {
    if (this.enabled) this.oidc.authorize();
  }

  logout(): void {
    if (this.enabled) {
      this.oidc.logoff().subscribe();
    }
  }

  /** True when the current user may perform write actions on a service. */
  canWrite(svc: Svc): boolean {
    if (!this.enabled) return true;
    const roles = this.roles();
    return roles.includes('admin') || roles.includes(`${svc}-editor`);
  }

  private applyToken(token: string): void {
    this.accessToken.set(token ?? '');
    const payload = decodeJwt(token);
    if (!payload) {
      this.roles.set([]);
      return;
    }
    this.userName.set(payload.preferred_username || payload.name || '');
    this.roles.set(payload.realm_access?.roles ?? []);
  }
}

/** Decode a JWT payload without verifying (server verifies; UI only reads claims). */
function decodeJwt(token: string): KeycloakAccessToken | null {
  if (!token) return null;
  const parts = token.split('.');
  if (parts.length < 2) return null;
  try {
    const base64 = parts[1].replace(/-/g, '+').replace(/_/g, '/');
    const json = decodeURIComponent(
      atob(base64)
        .split('')
        .map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
        .join(''),
    );
    return JSON.parse(json) as KeycloakAccessToken;
  } catch {
    return null;
  }
}
