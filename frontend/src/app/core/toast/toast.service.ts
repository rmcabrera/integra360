import { Injectable, signal } from '@angular/core';

export type ToastKind = 'info' | 'success' | 'error' | 'warning';

export interface Toast {
  id: number;
  kind: ToastKind;
  title: string;
  detail?: string;
}

@Injectable({ providedIn: 'root' })
export class ToastService {
  private seq = 0;
  readonly toasts = signal<Toast[]>([]);

  show(kind: ToastKind, title: string, detail?: string, timeoutMs = 6000): void {
    const toast: Toast = { id: ++this.seq, kind, title, detail };
    this.toasts.update((list) => [...list, toast]);
    if (timeoutMs > 0) {
      setTimeout(() => this.dismiss(toast.id), timeoutMs);
    }
  }

  success(title: string, detail?: string): void {
    this.show('success', title, detail);
  }
  error(title: string, detail?: string): void {
    this.show('error', title, detail, 9000);
  }
  info(title: string, detail?: string): void {
    this.show('info', title, detail);
  }
  warning(title: string, detail?: string): void {
    this.show('warning', title, detail);
  }

  dismiss(id: number): void {
    this.toasts.update((list) => list.filter((t) => t.id !== id));
  }
}
