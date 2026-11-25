import {
  ChangeDetectionStrategy,
  Component,
  computed,
  effect,
  inject,
  input,
  output,
  signal,
} from '@angular/core';
import {
  FormControl,
  FormGroup,
  ReactiveFormsModule,
  Validators,
} from '@angular/forms';
import { EntityMeta, EntityRecord, FieldMeta } from '../../core/api/models';
import { inputKind, isDisplayable, isInteger, isNumeric } from '../utils/field-type';

type Mode = 'create' | 'edit';

/** Create/edit form generated from entity field metadata. The DataWindow form half. */
@Component({
  selector: 'app-entity-form',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [ReactiveFormsModule],
  template: `
    <form [formGroup]="form()" (ngSubmit)="submit()" novalidate>
      <div class="dialog-body">
        <div class="form-grid">
          @for (f of visibleFields(); track f.field) {
            <div class="field" [class.span-2]="kind(f) === 'text' && (f.length ?? 0) > 60">
              <label [attr.for]="'f_' + f.field">
                {{ f.label || f.field }}
                @if (f.required && !isReadonly(f)) {
                  <span class="req" aria-hidden="true">*</span>
                }
                @if (isReadonly(f)) {
                  <span class="badge">solo lectura</span>
                }
              </label>

              @switch (kind(f)) {
                @case ('checkbox') {
                  <input
                    [id]="'f_' + f.field"
                    type="checkbox"
                    [formControlName]="f.field"
                  />
                }
                @case ('number') {
                  <input
                    [id]="'f_' + f.field"
                    type="number"
                    [step]="isInt(f) ? '1' : 'any'"
                    [formControlName]="f.field"
                    [class.invalid]="invalid(f)"
                    [attr.aria-invalid]="invalid(f)"
                  />
                }
                @case ('date') {
                  <input
                    [id]="'f_' + f.field"
                    type="date"
                    [formControlName]="f.field"
                    [class.invalid]="invalid(f)"
                  />
                }
                @case ('datetime-local') {
                  <input
                    [id]="'f_' + f.field"
                    type="datetime-local"
                    [formControlName]="f.field"
                    [class.invalid]="invalid(f)"
                  />
                }
                @case ('time') {
                  <input
                    [id]="'f_' + f.field"
                    type="time"
                    [formControlName]="f.field"
                    [class.invalid]="invalid(f)"
                  />
                }
                @default {
                  <input
                    [id]="'f_' + f.field"
                    type="text"
                    [formControlName]="f.field"
                    [attr.maxlength]="f.length || null"
                    [class.invalid]="invalid(f)"
                    [attr.aria-invalid]="invalid(f)"
                  />
                }
              }

              @if (invalid(f)) {
                <span class="error">Campo obligatorio</span>
              }
            </div>
          }
        </div>
      </div>
      <div class="dialog-footer">
        <button type="button" class="btn" (click)="cancel.emit()" [disabled]="saving()">
          Cancelar
        </button>
        <button type="submit" class="btn btn-primary" [disabled]="saving()">
          {{ saving() ? 'Guardando…' : 'Guardar' }}
        </button>
      </div>
    </form>
  `,
  styles: [
    `
      .form-grid {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 0 1rem;
      }
      .span-2 {
        grid-column: 1 / -1;
      }
      .req {
        color: var(--c-danger);
      }
      .badge {
        margin-left: 0.4rem;
      }
      @media (max-width: 560px) {
        .form-grid {
          grid-template-columns: 1fr;
        }
      }
    `,
  ],
})
export class EntityFormComponent {
  readonly meta = input.required<EntityMeta>();
  readonly mode = input.required<Mode>();
  readonly record = input<EntityRecord>({});
  readonly saving = input(false);

  readonly save = output<EntityRecord>();
  readonly cancel = output<void>();

  /** Fields to render: byte[] always skipped; generated hidden on create. */
  readonly visibleFields = computed<FieldMeta[]>(() => {
    const creating = this.mode() === 'create';
    return this.meta().fields.filter(
      (f) => isDisplayable(f.type) && !(creating && f.generated),
    );
  });

  readonly form = signal<FormGroup>(new FormGroup({}));

  constructor() {
    effect(() => {
      this.form.set(this.buildForm());
    });
  }

  kind(f: FieldMeta) {
    return inputKind(f.type);
  }

  isInt(f: FieldMeta): boolean {
    return isInteger(f.type);
  }

  /** Id fields are read-only on edit; generated fields are always read-only here. */
  isReadonly(f: FieldMeta): boolean {
    return (f.id && this.mode() === 'edit') || f.generated;
  }

  invalid(f: FieldMeta): boolean {
    const c = this.form().get(f.field);
    return !!c && c.invalid && (c.dirty || c.touched);
  }

  submit(): void {
    const form = this.form();
    if (form.invalid) {
      form.markAllAsTouched();
      return;
    }
    // Start from the original record (keeps audit fields + rowVersion on edit),
    // then overlay the edited values with proper types.
    const base: EntityRecord = this.mode() === 'edit' ? { ...this.record() } : {};
    const result: EntityRecord = { ...base };
    for (const f of this.meta().fields) {
      if (!isDisplayable(f.type)) continue;
      const control = form.get(f.field);
      if (!control) continue; // generated on create: leave server to fill
      result[f.field] = coerce(control.value, f);
    }
    this.save.emit(result);
  }

  private buildForm(): FormGroup {
    const group: Record<string, FormControl> = {};
    const creating = this.mode() === 'create';
    const rec = this.record();
    for (const f of this.meta().fields) {
      if (!isDisplayable(f.type)) continue;
      if (creating && f.generated) continue;
      const disabled = this.isReadonly(f);
      const initial = normalize(rec[f.field], f);
      const validators = f.required && !disabled && !f.generated ? [Validators.required] : [];
      group[f.field] = new FormControl({ value: initial, disabled }, { validators });
    }
    return new FormGroup(group);
  }
}

/** Convert a stored value to the shape an <input> expects. */
function normalize(value: unknown, f: FieldMeta): unknown {
  if (value === null || value === undefined) {
    return f.type === 'Boolean' ? false : '';
  }
  if (f.type === 'LocalDate') return String(value).slice(0, 10);
  if (f.type === 'LocalDateTime' || f.type === 'OffsetDateTime') {
    return String(value).replace(' ', 'T').slice(0, 16);
  }
  if (f.type === 'Boolean') return value === true || value === 'true';
  return value;
}

/** Convert an <input> value back to the type the API expects. */
function coerce(value: unknown, f: FieldMeta): unknown {
  if (f.type === 'Boolean') return value === true;
  if (value === '' || value === null || value === undefined) return null;
  if (isNumeric(f.type)) {
    const n = Number(value);
    return Number.isNaN(n) ? null : n;
  }
  return value;
}
