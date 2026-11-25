import { FieldMeta } from '../../core/api/models';
import { FieldValuePipe } from './field-value.pipe';

function field(partial: Partial<FieldMeta>): FieldMeta {
  return {
    field: 'f',
    column: 'f',
    type: 'String',
    required: false,
    id: false,
    generated: false,
    label: 'F',
    ...partial,
  };
}

describe('FieldValuePipe', () => {
  const pipe = new FieldValuePipe();

  it('renders booleans in Spanish', () => {
    expect(pipe.transform(true, field({ type: 'Boolean' }))).toBe('Sí');
    expect(pipe.transform(false, field({ type: 'Boolean' }))).toBe('No');
  });

  it('trims dates and datetimes', () => {
    expect(pipe.transform('2024-05-01T10:30:00', field({ type: 'LocalDate' }))).toBe('2024-05-01');
    expect(pipe.transform('2024-05-01T10:30:45', field({ type: 'LocalDateTime' }))).toBe(
      '2024-05-01 10:30',
    );
  });

  it('renders empty values as empty string', () => {
    expect(pipe.transform(null, field({}))).toBe('');
    expect(pipe.transform(undefined, field({}))).toBe('');
  });
});
