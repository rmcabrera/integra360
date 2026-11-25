import { toCsv } from './csv';

describe('toCsv', () => {
  const cols = [
    { field: 'codi', label: 'Código' },
    { field: 'desc', label: 'Descripción' },
  ];

  it('builds a semicolon-separated CSV with a header row', () => {
    const csv = toCsv([{ codi: '01', desc: 'Soles' }], cols);
    const lines = csv.split('\r\n');
    expect(lines[0]).toBe('Código;Descripción');
    expect(lines[1]).toBe('01;Soles');
  });

  it('escapes values containing separators or quotes', () => {
    const csv = toCsv([{ codi: 'a;b', desc: 'say "hi"' }], cols);
    expect(csv).toContain('"a;b"');
    expect(csv).toContain('"say ""hi"""');
  });

  it('renders null and undefined as empty cells', () => {
    const csv = toCsv([{ codi: null, desc: undefined }], cols);
    expect(csv.split('\r\n')[1]).toBe(';');
  });
});
