import {
  ChangeDetectionStrategy,
  Component,
  computed,
  effect,
  inject,
  input,
  signal,
  untracked,
} from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AuthService } from '../../core/auth/auth.service';
import { DataService, ListQuery } from '../../core/api/data.service';
import { EntityMeta, EntityRecord, FieldMeta } from '../../core/api/models';
import { Svc } from '../../core/config/app-config';
import { ToastService } from '../../core/toast/toast.service';
import { toCsv, downloadCsv } from '../utils/csv';
import { isDisplayable, isNumeric } from '../utils/field-type';
import { FieldValuePipe } from '../pipes/field-value.pipe';
import { EntityFormComponent } from './entity-form.component';

type SortDir = 'asc' | 'desc';
type DialogMode = 'create' | 'edit' | null;

const PAGE_SIZES = [10, 25, 50, 100];

/** Metadata-driven grid + form. Given a service and entity it loads the field
 *  metadata and renders a server-paged, sortable, filterable table with
 *  create/edit/delete and CSV export. The PowerBuilder DataWindow replacement. */
@Component({
  selector: 'app-data-grid',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [FormsModule, FieldValuePipe, EntityFormComponent],
  templateUrl: './data-grid.component.html',
  styleUrl: './data-grid.component.scss',
})
export class DataGridComponent {
  private readonly data = inject(DataService);
  private readonly toast = inject(ToastService);
  private readonly auth = inject(AuthService);

  readonly svc = input.required<Svc>();
  readonly entity = input.required<string>();

  readonly meta = signal<EntityMeta | null>(null);
  readonly rows = signal<EntityRecord[]>([]);
  readonly total = signal(0);
  readonly pageIndex = signal(0);
  readonly pageSize = signal(50);
  readonly sortField = signal<string | null>(null);
  readonly sortDir = signal<SortDir>('asc');
  readonly q = signal('');
  readonly filters = signal<Record<string, string>>({});
  readonly loading = signal(false);

  readonly dialogMode = signal<DialogMode>(null);
  readonly editing = signal<EntityRecord>({});
  readonly saving = signal(false);
  readonly deleting = signal<EntityRecord | null>(null);

  readonly pageSizes = PAGE_SIZES;

  readonly columns = computed<FieldMeta[]>(
    () => this.meta()?.fields.filter((f) => isDisplayable(f.type)) ?? [],
  );
  readonly idFields = computed<FieldMeta[]>(
    () => this.meta()?.fields.filter((f) => f.id) ?? [],
  );
  readonly canWrite = computed(() => this.auth.canWrite(this.svc()));
  readonly totalPages = computed(() =>
    Math.max(1, Math.ceil(this.total() / this.pageSize())),
  );

  constructor() {
    // Reload metadata and first page whenever the target entity changes.
    effect(() => {
      const svc = this.svc();
      const entity = this.entity();
      untracked(() => this.initEntity(svc, entity));
    });
  }

  private initEntity(svc: Svc, entity: string): void {
    this.meta.set(null);
    this.rows.set([]);
    this.total.set(0);
    this.pageIndex.set(0);
    this.sortField.set(null);
    this.q.set('');
    this.filters.set({});
    this.loading.set(true);
    this.data.meta(svc, entity).subscribe({
      next: (m) => {
        this.meta.set(m);
        this.load();
      },
      error: () => this.loading.set(false),
    });
  }

  load(): void {
    const query: ListQuery = {
      page: this.pageIndex(),
      size: this.pageSize(),
      q: this.q() || undefined,
      filters: this.filters(),
    };
    const sf = this.sortField();
    if (sf) query.sort = `${sf},${this.sortDir()}`;
    this.loading.set(true);
    this.data.list(this.svc(), this.entity(), query).subscribe({
      next: (page) => {
        this.rows.set(page.items ?? []);
        this.total.set(page.total ?? 0);
        this.loading.set(false);
      },
      error: () => this.loading.set(false),
    });
  }

  search(): void {
    this.pageIndex.set(0);
    this.load();
  }

  sortBy(field: FieldMeta): void {
    if (this.sortField() === field.field) {
      this.sortDir.update((d) => (d === 'asc' ? 'desc' : 'asc'));
    } else {
      this.sortField.set(field.field);
      this.sortDir.set('asc');
    }
    this.load();
  }

  setFilter(field: string, value: string): void {
    this.filters.update((f) => ({ ...f, [field]: value }));
  }

  applyFilters(): void {
    this.pageIndex.set(0);
    this.load();
  }

  clearFilters(): void {
    this.filters.set({});
    this.q.set('');
    this.pageIndex.set(0);
    this.load();
  }

  goTo(index: number): void {
    const clamped = Math.min(Math.max(0, index), this.totalPages() - 1);
    this.pageIndex.set(clamped);
    this.load();
  }

  changePageSize(size: number): void {
    this.pageSize.set(Number(size));
    this.pageIndex.set(0);
    this.load();
  }

  openCreate(): void {
    this.editing.set({});
    this.dialogMode.set('create');
  }

  openEdit(row: EntityRecord): void {
    this.editing.set({ ...row });
    this.dialogMode.set('edit');
  }

  closeDialog(): void {
    this.dialogMode.set(null);
    this.saving.set(false);
  }

  onSave(record: EntityRecord): void {
    const svc = this.svc();
    const entity = this.entity();
    const mode = this.dialogMode();
    this.saving.set(true);
    const op$ =
      mode === 'create'
        ? this.data.create(svc, entity, record)
        : this.data.update(svc, entity, record);
    op$.subscribe({
      next: () => {
        this.toast.success(mode === 'create' ? 'Registro creado' : 'Registro actualizado');
        this.closeDialog();
        this.load();
      },
      error: () => this.saving.set(false),
    });
  }

  askDelete(row: EntityRecord): void {
    this.deleting.set(row);
  }

  cancelDelete(): void {
    this.deleting.set(null);
  }

  confirmDelete(): void {
    const row = this.deleting();
    if (!row) return;
    this.data.remove(this.svc(), this.entity(), this.keyOf(row)).subscribe({
      next: () => {
        this.toast.success('Registro eliminado');
        this.deleting.set(null);
        this.load();
      },
      error: () => this.deleting.set(null),
    });
  }

  exportCsv(): void {
    const cols = this.columns().map((c) => ({ field: c.field, label: c.label || c.field }));
    const csv = toCsv(this.rows(), cols);
    downloadCsv(`${this.entity()}-p${this.pageIndex() + 1}.csv`, csv);
  }

  keyOf(row: EntityRecord): Record<string, unknown> {
    const key: Record<string, unknown> = {};
    for (const f of this.idFields()) key[f.field] = row[f.field];
    return key;
  }

  isNum(f: FieldMeta): boolean {
    return isNumeric(f.type);
  }

  rowKey(index: number): number {
    return index;
  }
}
