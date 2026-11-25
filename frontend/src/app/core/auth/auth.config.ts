import { HttpClient } from '@angular/common/http';
import { EnvironmentProviders } from '@angular/core';
import { map } from 'rxjs';
import {
  OpenIdConfiguration,
  StsConfigHttpLoader,
  StsConfigLoader,
  provideAuth,
} from 'angular-auth-oidc-client';
import { AppConfig, DEFAULT_CONFIG } from '../config/app-config';

/** Build the OIDC config (Keycloak, code flow + PKCE S256) from runtime config. */
export function buildOidcConfig(cfg: AppConfig): OpenIdConfiguration {
  const origin = typeof window !== 'undefined' ? window.location.origin : '';
  const auth = cfg.auth ?? DEFAULT_CONFIG.auth;
  return {
    configId: 'sige',
    authority: auth.authority,
    redirectUrl: origin,
    postLoginRoute: '/',
    postLogoutRedirectUri: origin,
    clientId: auth.clientId || 'sige-frontend',
    scope: 'openid profile email',
    responseType: 'code', // Authorization Code flow
    // PKCE with S256 is the library default for the code flow.
    silentRenew: true,
    useRefreshToken: true,
    ignoreNonceAfterRefresh: true,
    autoUserInfo: true,
    renewTimeBeforeTokenExpiresInSeconds: 30,
    secureRoutes: [`${cfg.apiBaseUrl || ''}/api`],
  };
}

/** Loads config.json over HTTP and maps it to the OIDC config the library needs. */
export function authConfigLoaderFactory(http: HttpClient): StsConfigLoader {
  const config$ = http
    .get<AppConfig>('config.json')
    .pipe(map((cfg) => buildOidcConfig({ ...DEFAULT_CONFIG, ...cfg })));
  return new StsConfigHttpLoader(config$);
}

/** Auth providers. Always registered; the AuthService and guard honor the
 *  `auth.enabled` flag, so when it is false no OIDC call is ever triggered. */
export function provideSigeAuth(): EnvironmentProviders {
  return provideAuth({
    loader: {
      provide: StsConfigLoader,
      useFactory: authConfigLoaderFactory,
      deps: [HttpClient],
    },
  });
}
