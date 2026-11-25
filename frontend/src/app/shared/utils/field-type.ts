import { JavaType } from '../../core/api/models';

/** Which HTML input a Java field type maps to. */
export type InputKind = 'text' | 'number' | 'checkbox' | 'date' | 'datetime-local' | 'time';

const NUMERIC: ReadonlySet<JavaType> = new Set<JavaType>([
  'Integer',
  'Long',
  'Short',
  'BigDecimal',
  'Double',
  'Float',
]);

export function isNumeric(type: JavaType): boolean {
  return NUMERIC.has(type);
}

export function isInteger(type: JavaType): boolean {
  return type === 'Integer' || type === 'Long' || type === 'Short';
}

/** Map a Java type to the input kind used by the generated form. */
export function inputKind(type: JavaType): InputKind {
  if (type === 'Boolean') return 'checkbox';
  if (type === 'LocalDate') return 'date';
  if (type === 'LocalDateTime' || type === 'OffsetDateTime') return 'datetime-local';
  if (type === 'LocalTime') return 'time';
  if (isNumeric(type)) return 'number';
  return 'text';
}

/** byte[] fields are skipped entirely in grid and form. */
export function isDisplayable(type: JavaType): boolean {
  return type !== 'byte[]';
}
