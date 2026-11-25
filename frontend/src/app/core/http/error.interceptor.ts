import { HttpErrorResponse, HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, throwError } from 'rxjs';
import { ToastService } from '../toast/toast.service';
import { ProblemDetail } from '../api/models';

/** Surfaces backend errors as toasts, reading RFC 9457 problem+json when present.
 *  Re-throws so callers can still react (e.g. reload on optimistic-lock 409). */
export const errorInterceptor: HttpInterceptorFn = (req, next) => {
  const toast = inject(ToastService);
  return next(req).pipe(
    catchError((err: unknown) => {
      if (err instanceof HttpErrorResponse) {
        const problem = asProblem(err);
        const title = problem?.title || defaultTitle(err.status);
        const detail = problem?.code
          ? `${problem.detail ?? ''} (${problem.code})`.trim()
          : problem?.detail;
        // Optimistic-lock conflicts get a clearer, action-oriented message.
        if (problem?.code === 'OPTIMISTIC_LOCK' || err.status === 409) {
          toast.warning(
            'Registro modificado por otro usuario',
            'Vuelva a cargar el registro antes de guardar.',
          );
        } else if (err.status !== 0 || title) {
          toast.error(title, detail);
        }
      }
      return throwError(() => err);
    }),
  );
};

function asProblem(err: HttpErrorResponse): ProblemDetail | null {
  const body = err.error;
  if (body && typeof body === 'object' && ('title' in body || 'detail' in body || 'code' in body)) {
    return body as ProblemDetail;
  }
  return null;
}

function defaultTitle(status: number): string {
  switch (status) {
    case 0:
      return 'No se pudo conectar con el servidor';
    case 400:
      return 'Solicitud inválida';
    case 401:
      return 'Sesión no autorizada';
    case 403:
      return 'Acceso denegado';
    case 404:
      return 'No encontrado';
    case 500:
      return 'Error interno del servidor';
    default:
      return `Error ${status}`;
  }
}
