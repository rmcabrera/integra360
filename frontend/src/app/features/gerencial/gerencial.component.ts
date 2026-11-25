import { ChangeDetectionStrategy, Component } from '@angular/core';

/** Placeholder for the legacy "Gerencial" subsystem: its reports are still
 *  being migrated. Lists them as pending so the menu entry is not a dead end. */
@Component({
  selector: 'app-gerencial',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    <div class="page">
      <h1>Gerencial</h1>
      <p class="muted">Los reportes gerenciales están en migración desde el sistema PowerBuilder.</p>
      <div class="card mt-2">
        <div class="card-body">
          <ul class="report-list">
            @for (r of reports; track r) {
              <li>
                <span>{{ r }}</span>
                <span class="badge">en migración</span>
              </li>
            }
          </ul>
        </div>
      </div>
    </div>
  `,
  styles: [
    `
      .report-list {
        list-style: none;
        margin: 0;
        padding: 0;
      }
      .report-list li {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 1rem;
        padding: 0.5rem 0;
        border-bottom: 1px solid var(--c-border);
      }
      .report-list li:last-child {
        border-bottom: 0;
      }
    `,
  ],
})
export class GerencialComponent {
  readonly reports = [
    'Saldos Generales',
    'Flujo de Fondos',
    'Flujo de Caja Real',
    'Liquidación de Impuestos',
    'Lista de Precios de Venta',
    'Punto de Equilibrio',
    'Indicadores',
    'Análisis Stock de Producto',
    'Reporte de Ventas - Utilidad x Sucursal',
    'Kardex Administrativo',
  ];
}
