'use strict';
/** Mapeo de tipos SQL Server -> PostgreSQL -> Java */
const { pgName } = require('./naming');

function mapType(col) {
  const t = col.type, a = col.args;
  const n = i => (a[i] === 'max' ? null : parseInt(a[i], 10));
  switch (t) {
    case 'char': case 'nchar': case 'varchar': case 'nvarchar': {
      const len = n(0);
      if (len == null || len > 4000) return { pg: 'text', java: 'String' };
      return { pg: `varchar(${len || 1})`, java: 'String', length: len || 1 };
    }
    case 'text': case 'ntext': case 'xml': case 'sql_variant': case 'sysname':
      return { pg: 'text', java: 'String' };
    case 'int': return { pg: 'integer', java: 'Integer' };
    case 'smallint': case 'tinyint': return { pg: 'smallint', java: 'Short' };
    case 'bigint': return { pg: 'bigint', java: 'Long' };
    case 'bit': return { pg: 'boolean', java: 'Boolean' };
    case 'money': return { pg: 'numeric(19,4)', java: 'BigDecimal', precision: 19, scale: 4 };
    case 'smallmoney': return { pg: 'numeric(10,4)', java: 'BigDecimal', precision: 10, scale: 4 };
    case 'numeric': case 'decimal': {
      const p = n(0) || 18, s = a.length > 1 ? n(1) : 0;
      if (s === 0 && p <= 9) return { pg: 'integer', java: 'Integer' };
      if (s === 0 && p <= 18) return { pg: 'bigint', java: 'Long' };
      return { pg: `numeric(${p},${s})`, java: 'BigDecimal', precision: p, scale: s };
    }
    case 'float': return { pg: 'double precision', java: 'Double' };
    case 'real': return { pg: 'real', java: 'Float' };
    case 'datetime': case 'datetime2': return { pg: 'timestamp(3)', java: 'LocalDateTime' };
    case 'smalldatetime': return { pg: 'timestamp(0)', java: 'LocalDateTime' };
    case 'datetimeoffset': return { pg: 'timestamptz', java: 'OffsetDateTime' };
    case 'date': return { pg: 'date', java: 'LocalDate' };
    case 'time': return { pg: 'time', java: 'LocalTime' };
    case 'image': case 'varbinary': case 'binary': case 'timestamp': case 'rowversion':
      return { pg: 'bytea', java: 'byte[]' };
    case 'uniqueidentifier': return { pg: 'uuid', java: 'UUID' };
    default: return { pg: 'text', java: 'String', warn: `tipo desconocido ${t}` };
  }
}

function stripParens(s) {
  s = s.trim();
  while (s.startsWith('(') && s.endsWith(')')) {
    // solo si el parentesis exterior envuelve todo
    let d = 0, ok = true;
    for (let i = 0; i < s.length; i++) { if (s[i] === '(') d++; else if (s[i] === ')') { d--; if (d === 0 && i < s.length - 1) { ok = false; break; } } }
    if (!ok) break;
    s = s.slice(1, -1).trim();
  }
  return s;
}

/** traduce DEFAULT de T-SQL; devuelve null si no es traducible */
function mapDefault(expr, mapped) {
  if (expr == null) return null;
  let e = stripParens(expr);
  const lower = e.toLowerCase();
  if (/^(getdate|current_timestamp|sysdatetime|getutcdate)(\(\))?$/.test(lower)) {
    return mapped.pg === 'date' ? 'CURRENT_DATE' : 'CURRENT_TIMESTAMP';
  }
  if (/^convert\s*\(\s*(char|varchar)\s*\(\s*10\s*\)\s*,\s*getdate\s*\(\s*\)\s*,\s*103\s*\)$/.test(lower)) return 'CURRENT_DATE';
  if (/^(newid|newsequentialid)\(\)$/.test(lower)) return 'gen_random_uuid()';
  const dp = lower.match(/^datepart\s*\(\s*(year|month|day)\s*,\s*getdate\s*\(\s*\)\s*\)$/);
  if (dp) return `(EXTRACT(${dp[1].toUpperCase()} FROM CURRENT_DATE)::integer)`;
  if (/^(user_name|suser_sname|suser_name|user|system_user|current_user)(\(\))?$/.test(lower)) return 'CURRENT_USER';
  if (/^host_name\(\)$/.test(lower)) return null;
  const str = e.match(/^N?'((?:[^']|'')*)'$/);
  const num = e.match(/^-?\d+(\.\d+)?$/) ? e : (stripParens(e).match(/^-?\d+(\.\d+)?$/) ? stripParens(e) : null);
  if (mapped.pg === 'boolean') {
    if (num != null) return Number(num) !== 0 ? 'true' : 'false';
    if (str) return /^(1|t|true|s)$/i.test(str[1]) ? 'true' : 'false';
    return null;
  }
  if (/^(varchar|text)/.test(mapped.pg)) {
    if (str) return `'${str[1].trimEnd()}'`;
    if (num != null) return `'${num}'`;
    return null;
  }
  if (/^(integer|smallint|bigint|numeric|double|real)/.test(mapped.pg)) {
    if (num != null) return num;
    if (str && /^-?\d+(\.\d+)?$/.test(str[1].trim())) return str[1].trim();
    return null;
  }
  if (/^timestamp|^date/.test(mapped.pg)) {
    if (str) return `'${str[1]}'`;
    return null; // p.ej. DEFAULT (1) sobre datetime: no portable
  }
  if (str) return `'${str[1]}'`;
  if (num != null) return num;
  return null;
}

/** columnas calculadas -> GENERATED ALWAYS AS (...) STORED, o null */
function mapComputed(expr) {
  let e = stripParens(expr);
  let m = e.match(/^datepart\s*\(\s*(month|year|day|mm|yy|yyyy|dd)\s*,\s*\[?(\w+)\]?\s*\)$/i) ||
          e.match(/^(month|year|day)\s*\(\s*\[?(\w+)\]?\s*\)$/i);
  if (m) {
    const part = { mm: 'month', yy: 'year', yyyy: 'year', dd: 'day' }[m[1].toLowerCase()] || m[1].toLowerCase();
    return { pg: 'integer', java: 'Integer', expr: `(EXTRACT(${part.toUpperCase()} FROM ${pgName(m[2])})::integer)` };
  }
  // aritmetica simple con columnas y numeros
  const simple = e.replace(/\[(\w+)\]/g, (_, c) => pgName(c)).replace(/isnull\s*\(/gi, 'coalesce(');
  if (/^[\w\s+\-*/().,]+$/.test(simple) && !/\b(select|convert|cast|case|datepart|datediff|substring|left|right|len)\b/i.test(simple)) {
    return { pg: 'numeric(19,4)', java: 'BigDecimal', expr: `(${simple})` };
  }
  return null;
}

module.exports = { mapType, mapDefault, mapComputed };
