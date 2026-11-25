import { inputKind, isDisplayable, isInteger, isNumeric } from './field-type';

describe('field-type mapping', () => {
  it('maps Java types to the right input kind', () => {
    expect(inputKind('Boolean')).toBe('checkbox');
    expect(inputKind('LocalDate')).toBe('date');
    expect(inputKind('LocalDateTime')).toBe('datetime-local');
    expect(inputKind('OffsetDateTime')).toBe('datetime-local');
    expect(inputKind('LocalTime')).toBe('time');
    expect(inputKind('BigDecimal')).toBe('number');
    expect(inputKind('Integer')).toBe('number');
    expect(inputKind('String')).toBe('text');
    expect(inputKind('UUID')).toBe('text');
  });

  it('classifies numeric and integer types', () => {
    expect(isNumeric('Long')).toBe(true);
    expect(isNumeric('Double')).toBe(true);
    expect(isNumeric('String')).toBe(false);
    expect(isInteger('Short')).toBe(true);
    expect(isInteger('BigDecimal')).toBe(false);
  });

  it('skips byte[] fields', () => {
    expect(isDisplayable('byte[]')).toBe(false);
    expect(isDisplayable('String')).toBe(true);
  });
});
