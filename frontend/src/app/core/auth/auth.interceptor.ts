import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { AuthService } from './auth.service';

/** Adds the bearer token to API requests. No-op when auth is disabled. */
export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const auth = inject(AuthService);
  if (!auth.enabled) {
    return next(req);
  }
  const token = auth.accessToken();
  const isApi = req.url.includes('/api/');
  if (token && isApi) {
    return next(
      req.clone({ setHeaders: { Authorization: `Bearer ${token}` } }),
    );
  }
  return next(req);
};
