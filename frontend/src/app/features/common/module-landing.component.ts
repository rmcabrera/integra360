import { ChangeDetectionStrategy, Component, computed, inject, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { DataService } from '../../core/api/data.service';
import { TableInfo } from '../../core/api/models';
import { Svc } from '../../core/config/app-config';

/** Landing page for a module: lists every table of the service (live from the
 *  API) with a search box, each linking to the generic grid. */
@Component({
  selector: 'app-module-landing',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [FormsModule, RouterLink],
  template: `
    <div class="page">
      <h1>{{ title }}</h1>
      <p class="muted">Tablas del servicio <code>{{ svc }}</code></p>

      <div class="row mt-1 mb-2">
        <label class="search">
          <span class="visually-hidden">Filtrar tablas</span>
          <input
            type="search"
            placeholder="Filtrar tablas…"
            [ngModel]="query()"
            (ngModelChange)="query.set($event)"
          />
        </label>
      </div>

      @if (loading()) {
        <p class="muted">Cargando tablas…</p>
      } @else if (error()) {
        <p class="muted">No se pudo cargar la lista de tablas.</p>
      } @else {
        <div class="cards">
          @for (t of filtered(); track t.name) {
            <a class="card card-link" [routerLink]="['tablas', t.name]">
              <div class="card-body">
                <strong>{{ t.label || t.name }}</strong>
                <div class="muted">{{ t.legacyName }}</div>
                <div class="muted">{{ t.fields }} campos</div>
              </div>
            </a>
          } @empty {
            <p class="muted">Sin coincidencias.</p>
          }
        </div>
      }
    </div>
  `,
  styles: [
    `
      .cards {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
        gap: 0.75rem;
      }
      .card-link {
        display: block;
        color: inherit;
        text-decoration: none;
        transition: border-color 0.12s ease, box-shadow 0.12s ease;
      }
      .card-link:hover {
        border-color: var(--c-primary);
        box-shadow: var(--shadow-2);
        text-decoration: none;
      }
      .search input {
        min-width: 260px;
      }
    `,
  ],
})
export class ModuleLandingComponent {
  private readonly route = inject(ActivatedRoute);
  private readonly data = inject(DataService);

  readonly svc = this.route.snapshot.data['svc'] as Svc;
  readonly title = (this.route.snapshot.data['title'] as string) ?? this.svc;

  readonly tables = signal<TableInfo[]>([]);
  readonly loading = signal(true);
  readonly error = signal(false);
  readonly query = signal('');

  readonly filtered = computed(() => {
    const q = this.query().trim().toLowerCase();
    const list = this.tables();
    if (!q) return list;
    return list.filter(
      (t) =>
        t.name.toLowerCase().includes(q) ||
        (t.label ?? '').toLowerCase().includes(q) ||
        (t.legacyName ?? '').toLowerCase().includes(q),
    );
  });

  constructor() {
    this.data.listTables(this.svc).subscribe({
      next: (tables) => {
        this.tables.set([...tables].sort((a, b) => (a.label || a.name).localeCompare(b.label || b.name)));
        this.loading.set(false);
      },
      error: () => {
        this.error.set(true);
        this.loading.set(false);
      },
    });
  }
}
