import { registerLocaleData } from '@angular/common';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import localeEsPe from '@angular/common/locales/es-PE';
import {
  ApplicationConfig,
  LOCALE_ID,
  inject,
  provideAppInitializer,
  provideBrowserGlobalErrorListeners,
} from '@angular/core';
import { provideRouter, withInMemoryScrolling } from '@angular/router';

import { routes } from './app.routes';
import { ConfigService, loadRuntimeConfig } from './core/config/config.service';
import { AuthService } from './core/auth/auth.service';
import { provideSigeAuth } from './core/auth/auth.config';
import { authInterceptor } from './core/auth/auth.interceptor';
import { errorInterceptor } from './core/http/error.interceptor';
import { loadingInterceptor } from './core/loading/loading.interceptor';

registerLocaleData(localeEsPe, 'es-PE');

export const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners(),
    { provide: LOCALE_ID, useValue: 'es-PE' },
    provideRouter(routes, withInMemoryScrolling({ scrollPositionRestoration: 'enabled' })),
    provideHttpClient(
      withInterceptors([loadingInterceptor, errorInterceptor, authInterceptor]),
    ),
    provideSigeAuth(),
    // Load runtime config.json first, then initialize auth state.
    provideAppInitializer(async () => {
      const config = inject(ConfigService);
      const auth = inject(AuthService);
      await loadRuntimeConfig(config);
      auth.init();
    }),
  ],
};
