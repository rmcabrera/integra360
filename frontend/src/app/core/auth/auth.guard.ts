import { inject } from '@angular/core';
import { CanActivateFn } from '@angular/router';
import { AuthService } from './auth.service';

/** Blocks a route until the user is authenticated. When auth is disabled the
 *  AuthService reports authenticated, so this always passes. */
export const authGuard: CanActivateFn = () => {
  const auth = inject(AuthService);
  if (!auth.enabled || auth.isAuthenticated()) {
    return true;
  }
  auth.login();
  return false;
};
