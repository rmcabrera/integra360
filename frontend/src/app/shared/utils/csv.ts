/** Minimal CSV export helpers (no dependency). */

function escapeCell(value: unknown): string {
  if (value === null || value === undefined) return '';
  const text = String(value);
  if (/[";,\n\r]/.test(text)) {
    return `"${text.replace(/"/g, '""')}"`;
  }
  return text;
}

/** Build a CSV string from rows and an ordered list of columns. */
export function toCsv(
  rows: ReadonlyArray<Record<string, unknown>>,
  columns: ReadonlyArray<{ field: string; label: string }>,
): string {
  const header = columns.map((c) => escapeCell(c.label)).join(';');
  const body = rows.map((row) =>
    columns.map((c) => escapeCell(row[c.field])).join(';'),
  );
  return [header, ...body].join('\r\n');
}

/** Trigger a browser download of CSV content (UTF-8 BOM for Excel). */
export function downloadCsv(filename: string, csv: string): void {
  const blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8;' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = filename;
  a.click();
  URL.revokeObjectURL(url);
}
