import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { ToastService } from './toast.service';

@Component({
  selector: 'app-toasts',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="toast-stack" aria-live="polite" aria-atomic="false">
      @for (t of toasts.toasts(); track t.id) {
        <div class="toast" [class]="'toast-' + t.kind" role="status">
          <div class="toast-body">
            <strong>{{ t.title }}</strong>
            @if (t.detail) {
              <span class="muted">{{ t.detail }}</span>
            }
          </div>
          <button
            type="button"
            class="btn btn-ghost btn-icon"
            (click)="toasts.dismiss(t.id)"
            aria-label="Cerrar notificación"
          >
            &times;
          </button>
        </div>
      }
    </div>
  `,
  styles: [
    `
      .toast-stack {
        position: fixed;
        right: 1rem;
        bottom: 1rem;
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        z-index: 200;
        max-width: min(420px, calc(100vw - 2rem));
      }
      .toast {
        display: flex;
        align-items: flex-start;
        gap: 0.5rem;
        background: var(--c-surface);
        border: 1px solid var(--c-border);
        border-left: 4px solid var(--c-text-muted);
        border-radius: 8px;
        box-shadow: var(--shadow-2);
        padding: 0.65rem 0.75rem;
      }
      .toast-body {
        display: flex;
        flex-direction: column;
        gap: 0.15rem;
      }
      .toast-success {
        border-left-color: var(--c-success);
      }
      .toast-error {
        border-left-color: var(--c-danger);
      }
      .toast-warning {
        border-left-color: var(--c-warning);
      }
      .toast-info {
        border-left-color: var(--c-primary);
      }
    `,
  ],
})
export class ToastsComponent {
  readonly toasts = inject(ToastService);
}
