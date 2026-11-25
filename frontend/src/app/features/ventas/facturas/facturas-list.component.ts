import { ChangeDetectionStrategy, Component, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { VentasService } from '../../../core/api/ventas.service';
import { Factura, FacturaListFilters } from '../../../core/api/models';

@Component({
  selector: 'app-facturas-list',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [FormsModule, RouterLink],
  templateUrl: './facturas-list.component.html',
  styles: [
    `
      .filters {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
        gap: 0 1rem;
      }
      .filters .field {
        margin-bottom: 0.5rem;
      }
    `,
  ],
})
export class FacturasListComponent {
  private readonly ventas = inject(VentasService);

  readonly filters = signal<FacturaListFilters>({});
  readonly rows = signal<Factura[]>([]);
  readonly total = signal(0);
  readonly pageIndex = signal(0);
  readonly pageSize = signal(50);
  readonly loading = signal(false);

  constructor() {
    this.load();
  }

  setFilter<K extends keyof FacturaListFilters>(key: K, value: string): void {
    this.filters.update((f) => ({ ...f, [key]: value }));
  }

  buscar(): void {
    this.pageIndex.set(0);
    this.load();
  }

  limpiar(): void {
    this.filters.set({});
    this.pageIndex.set(0);
    this.load();
  }

  nextPage(delta: number): void {
    const next = this.pageIndex() + delta;
    if (next < 0 || next * this.pageSize() >= this.total()) return;
    this.pageIndex.set(next);
    this.load();
  }

  private load(): void {
    this.loading.set(true);
    this.ventas.listFacturas(this.filters(), this.pageIndex(), this.pageSize()).subscribe({
      next: (page) => {
        this.rows.set(page.items ?? []);
        this.total.set(page.total ?? 0);
        this.loading.set(false);
      },
      error: () => this.loading.set(false),
    });
  }
}
