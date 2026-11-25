import { Pipe, PipeTransform } from '@angular/core';
import { FieldMeta } from '../../core/api/models';

/** Formats a raw record value for read-only table display, by field type. */
@Pipe({ name: 'fieldValue' })
export class FieldValuePipe implements PipeTransform {
  transform(value: unknown, field: FieldMeta): string {
    if (value === null || value === undefined || value === '') return '';
    switch (field.type) {
      case 'Boolean':
        return value ? 'Sí' : 'No';
      case 'LocalDate':
        return String(value).slice(0, 10);
      case 'LocalDateTime':
      case 'OffsetDateTime':
        return String(value).replace('T', ' ').slice(0, 16);
      default:
        return String(value);
    }
  }
}
