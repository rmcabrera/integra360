import { ChangeDetectionStrategy, Component, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { LogisticaService } from '../../../core/api/logistica.service';
import { KardexRow, Producto, StockAlmacen } from '../../../core/api/models';

/** Kardex consultation: pick a product, period and (optional) warehouse, then
 *  show the kardex movements plus the stock per warehouse. */
@Component({
  selector: 'app-kardex',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [FormsModule],
  templateUrl: './kardex.component.html',
  styleUrl: './kardex.component.scss',
})
export class KardexComponent {
  private readonly logistica = inject(LogisticaService);

  readonly productQuery = signal('');
  readonly productResults = signal<Producto[]>([]);
  readonly searching = signal(false);
  private searchTimer: ReturnType<typeof setTimeout> | null = null;

  readonly selected = signal<Producto | null>(null);
  readonly periodo = signal(String(new Date().getFullYear()));
  readonly almacen = signal('');

  readonly rows = signal<KardexRow[]>([]);
  readonly stock = signal<StockAlmacen[]>([]);
  readonly loading = signal(false);
  readonly consulted = signal(false);

  onQueryChange(value: string): void {
    this.productQuery.set(value);
    if (this.searchTimer) clearTimeout(this.searchTimer);
    if (!value.trim()) {
      this.productResults.set([]);
      return;
    }
    this.searchTimer = setTimeout(() => this.runSearch(value.trim()), 300);
  }

  private runSearch(q: string): void {
    this.searching.set(true);
    this.logistica.buscarProductos(q, 0, 10).subscribe({
      next: (page) => {
        this.productResults.set(page.items ?? []);
        this.searching.set(false);
      },
      error: () => this.searching.set(false),
    });
  }

  select(p: Producto): void {
    this.selected.set(p);
    this.productQuery.set(`${p.codiProd} — ${p.descProd ?? ''}`);
    this.productResults.set([]);
    this.loadStock(p.codiProd);
  }

  consultar(): void {
    const p = this.selected();
    if (!p) return;
    this.loading.set(true);
    this.consulted.set(true);
    this.logistica
      .kardex({ producto: p.codiProd, periodo: this.periodo(), almacen: this.almacen() || undefined })
      .subscribe({
        next: (rows) => {
          this.rows.set(rows ?? []);
          this.loading.set(false);
        },
        error: () => this.loading.set(false),
      });
  }

  private loadStock(codiProd: string): void {
    this.logistica.stock(codiProd).subscribe({
      next: (s) => this.stock.set(s ?? []),
      error: () => this.stock.set([]),
    });
  }
}
