import { TestBed } from '@angular/core/testing';
import { OidcSecurityService } from 'angular-auth-oidc-client';
import { ConfigService } from '../config/config.service';
import { AuthService } from './auth.service';

describe('AuthService.canWrite', () => {
  let auth: AuthService;
  let config: ConfigService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        AuthService,
        ConfigService,
        // init() is not called in these tests, so a bare stub is enough.
        { provide: OidcSecurityService, useValue: {} },
      ],
    });
    config = TestBed.inject(ConfigService);
    auth = TestBed.inject(AuthService);
  });

  it('allows everything when auth is disabled', () => {
    expect(auth.enabled).toBe(false);
    expect(auth.canWrite('ventas')).toBe(true);
    expect(auth.canWrite('contabilidad')).toBe(true);
  });

  it('honors realm roles when auth is enabled', () => {
    config.set({
      apiBaseUrl: '',
      auth: { enabled: true, authority: 'http://kc/realms/sige', clientId: 'sige-frontend' },
    });
    expect(auth.enabled).toBe(true);

    auth.roles.set(['ventas-editor']);
    expect(auth.canWrite('ventas')).toBe(true);
    expect(auth.canWrite('maestros')).toBe(false);

    auth.roles.set(['admin']);
    expect(auth.canWrite('ventas')).toBe(true);
    expect(auth.canWrite('maestros')).toBe(true);

    auth.roles.set([]);
    expect(auth.canWrite('ventas')).toBe(false);
  });
});
