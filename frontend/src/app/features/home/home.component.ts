import { ChangeDetectionStrategy, Component } from '@angular/core';
import { RouterLink } from '@angular/router';

interface Shortcut {
  label: string;
  route: string;
  desc: string;
}

/** Landing/home page with quick access to the main modules. */
@Component({
  selector: 'app-home',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [RouterLink],
  template: `
    <div class="page">
      <h1>SIGE — Sistema Integrado</h1>
      <p class="muted">ERP migrado desde PowerBuilder. Seleccione un módulo para comenzar.</p>
      <div class="cards mt-2">
        @for (s of shortcuts; track s.route) {
          <a class="card card-link" [routerLink]="s.route">
            <div class="card-body">
              <strong>{{ s.label }}</strong>
              <div class="muted">{{ s.desc }}</div>
            </div>
          </a>
        }
      </div>
    </div>
  `,
  styles: [
    `
      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
        gap: 0.9rem;
      }
      .card-link {
        display: block;
        color: inherit;
        text-decoration: none;
      }
      .card-link:hover {
        border-color: var(--c-primary);
        box-shadow: var(--shadow-2);
        text-decoration: none;
      }
    `,
  ],
})
export class HomeComponent {
  readonly shortcuts: Shortcut[] = [
    { label: 'Maestros', route: '/maestros', desc: 'Monedas, clientes, unidades y más' },
    { label: 'Logística', route: '/logistica', desc: 'Productos, almacenes, kardex' },
    { label: 'Facturación', route: '/ventas/facturas', desc: 'Emisión y consulta de facturas' },
    { label: 'Personal', route: '/rrhh', desc: 'Registro de personal y planillas' },
    { label: 'Contabilidad', route: '/contabilidad', desc: 'Plan contable y registros' },
    { label: 'Finanzas', route: '/finanzas', desc: 'Bancos, caja y conciliaciones' },
    { label: 'Producción', route: '/produccion', desc: 'Operaciones de producción' },
    { label: 'Gerencial', route: '/gerencial', desc: 'Reportes (en migración)' },
  ];
}
