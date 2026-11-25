import { ChangeDetectionStrategy, Component, computed, inject, signal } from '@angular/core';
import { CurrencyPipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { ConfigService } from '../../../core/config/config.service';
import { LogisticaService } from '../../../core/api/logistica.service';
import { VentasService } from '../../../core/api/ventas.service';
import { ToastService } from '../../../core/toast/toast.service';
import { NuevaFactura, NuevaFacturaItem, Producto } from '../../../core/api/models';

interface Header {
  codiAlma: string;
  codiTipoDocu: string;
  serie: string;
  codiClieProv: string;
  fecha: string;
  vencimiento: string;
  codiMone: string;
  tipoCambio: string;
  codiTipoPago: string;
  aplicaIgv: boolean;
  preciosIncluyenIgv: boolean;
  ordenCompra: string;
  vendedor: string;
}

/** "Nueva factura" form: header + dynamic item lines with product typeahead and
 *  live client-side totals (display only; the server computes the real values). */
@Component({
  selector: 'app-factura-form',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [FormsModule, RouterLink, CurrencyPipe],
  templateUrl: './factura-form.component.html',
  styleUrl: './factura-form.component.scss',
})
export class FacturaFormComponent {
  private readonly logistica = inject(LogisticaService);
  private readonly ventas = inject(VentasService);
  private readonly toast = inject(ToastService);
  private readonly router = inject(Router);
  private readonly config = inject(ConfigService);

  readonly igvPercent = this.config.igvPercent;

  readonly header = signal<Header>({
    codiAlma: '',
    codiTipoDocu: '',
    serie: '',
    codiClieProv: '',
    fecha: today(),
    vencimiento: '',
    codiMone: 'S/',
    tipoCambio: '',
    codiTipoPago: '',
    aplicaIgv: true,
    preciosIncluyenIgv: false,
    ordenCompra: '',
    vendedor: '',
  });

  readonly items = signal<NuevaFacturaItem[]>([]);
  readonly saving = signal(false);

  // Product typeahead state.
  readonly productQuery = signal('');
  readonly productResults = signal<Producto[]>([]);
  readonly searching = signal(false);
  private searchTimer: ReturnType<typeof setTimeout> | null = null;

  /** Per-line amount before tax adjustments: qty * price - discount. */
  lineAmount(item: NuevaFacturaItem): number {
    const gross = (item.cantidad || 0) * (item.precioUnitario || 0);
    return Math.max(0, gross - (item.descuento || 0));
  }

  readonly totals = computed(() => {
    const h = this.header();
    const rate = this.igvPercent / 100;
    const sum = this.items().reduce((acc, it) => acc + this.lineAmount(it), 0);
    if (!h.aplicaIgv) {
      return { valor: sum, igv: 0, total: sum };
    }
    if (h.preciosIncluyenIgv) {
      const valor = sum / (1 + rate);
      return { valor, igv: sum - valor, total: sum };
    }
    const igv = sum * rate;
    return { valor: sum, igv, total: sum + igv };
  });

  setHeader<K extends keyof Header>(key: K, value: Header[K]): void {
    this.header.update((h) => ({ ...h, [key]: value }));
  }

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

  addProduct(p: Producto): void {
    this.items.update((list) => [
      ...list,
      {
        codiProd: p.codiProd,
        descripcion: p.descProd ?? '',
        codiUnidMedi: p.codiUnidMedi ?? '',
        cantidad: 1,
        precioUnitario: p.precProm ?? 0,
        descuento: 0,
        oferta: false,
      },
    ]);
    this.productQuery.set('');
    this.productResults.set([]);
  }

  updateItem<K extends keyof NuevaFacturaItem>(
    index: number,
    key: K,
    value: NuevaFacturaItem[K],
  ): void {
    this.items.update((list) =>
      list.map((it, i) => (i === index ? { ...it, [key]: value } : it)),
    );
  }

  removeItem(index: number): void {
    this.items.update((list) => list.filter((_, i) => i !== index));
  }

  guardar(): void {
    const h = this.header();
    const missing = !h.codiAlma || !h.codiTipoDocu || !h.serie || !h.codiClieProv || !h.fecha || !h.codiMone;
    if (missing) {
      this.toast.warning('Faltan datos', 'Complete los campos obligatorios de la cabecera.');
      return;
    }
    if (!this.items().length) {
      this.toast.warning('Sin ítems', 'Agregue al menos un producto.');
      return;
    }
    const body: NuevaFactura = {
      codiAlma: h.codiAlma,
      codiTipoDocu: h.codiTipoDocu,
      serie: h.serie,
      codiClieProv: h.codiClieProv,
      fecha: h.fecha,
      vencimiento: h.vencimiento || undefined,
      codiMone: h.codiMone,
      tipoCambio: h.tipoCambio ? Number(h.tipoCambio) : undefined,
      codiTipoPago: h.codiTipoPago || undefined,
      aplicaIgv: h.aplicaIgv,
      preciosIncluyenIgv: h.preciosIncluyenIgv,
      ordenCompra: h.ordenCompra || undefined,
      vendedor: h.vendedor || undefined,
      items: this.items(),
    };
    this.saving.set(true);
    this.ventas.crearFactura(body).subscribe({
      next: (factura) => {
        this.toast.success('Factura creada');
        this.saving.set(false);
        this.router.navigate(['/ventas/facturas', factura.codiFact]);
      },
      error: () => this.saving.set(false),
    });
  }
}

function today(): string {
  return new Date().toISOString().slice(0, 10);
}
