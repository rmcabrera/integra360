import { ChangeDetectionStrategy, Component, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { AuthService } from '../../../core/auth/auth.service';
import { ToastService } from '../../../core/toast/toast.service';
import { VentasService } from '../../../core/api/ventas.service';
import { FacturaDetalle } from '../../../core/api/models';

@Component({
  selector: 'app-factura-detail',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [FormsModule, RouterLink],
  templateUrl: './factura-detail.component.html',
  styles: [
    `
      .meta-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
        gap: 0.75rem;
      }
      .req {
        color: var(--c-danger);
      }
    `,
  ],
})
export class FacturaDetailComponent {
  private readonly route = inject(ActivatedRoute);
  private readonly ventas = inject(VentasService);
  private readonly toast = inject(ToastService);
  private readonly auth = inject(AuthService);

  readonly data = signal<FacturaDetalle | null>(null);
  readonly loading = signal(true);
  readonly showAnular = signal(false);
  readonly motivo = signal('');
  readonly anulando = signal(false);

  readonly canWrite = this.auth.canWrite('ventas');

  private readonly codiFact = this.route.snapshot.paramMap.get('id') ?? '';

  constructor() {
    this.ventas.getFactura(this.codiFact).subscribe({
      next: (d) => {
        this.data.set(d);
        this.loading.set(false);
      },
      error: () => this.loading.set(false),
    });
  }

  openAnular(): void {
    this.motivo.set('');
    this.showAnular.set(true);
  }

  cerrarAnular(): void {
    this.showAnular.set(false);
  }

  confirmarAnular(): void {
    const motivo = this.motivo().trim();
    if (!motivo) {
      this.toast.warning('Indique el motivo', 'El motivo de anulación es obligatorio.');
      return;
    }
    this.anulando.set(true);
    this.ventas.anular(this.codiFact, motivo).subscribe({
      next: (factura) => {
        this.toast.success('Factura anulada');
        this.data.update((d) => (d ? { ...d, cabecera: factura } : d));
        this.showAnular.set(false);
        this.anulando.set(false);
      },
      error: () => this.anulando.set(false),
    });
  }
}
