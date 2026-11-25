'use strict';

const PG_RESERVED = new Set(('all analyse analyze and any array as asc asymmetric authorization binary both case cast check collate collation ' +
  'column concurrently constraint create cross current_catalog current_date current_role current_schema current_time current_timestamp ' +
  'current_user default deferrable desc distinct do else end except false fetch for foreign freeze from full grant group having ilike in ' +
  'initially inner intersect into is isnull join lateral leading left like limit localtime localtimestamp natural not notnull null offset on ' +
  'only or order outer overlaps placing primary references returning right select session_user similar some symmetric table tablesample then ' +
  'to trailing true union unique user using variadic verbose when where window with').split(' '));

const JAVA_KEYWORDS = new Set(('abstract assert boolean break byte case catch char class const continue default do double else enum extends ' +
  'final finally float for goto if implements import instanceof int interface long native new package private protected public return short ' +
  'static strictfp super switch synchronized this throw throws transient try void volatile while true false null var record yield sealed permits').split(' '));

/** Campos reservados por LegacyEntity (no deben colisionar con columnas legado) */
const RESERVED_FIELDS = new Set(['auditcreatedat', 'auditupdatedat', 'audituser', 'rowversion']);

function stripAccents(s) { return s.normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/ñ/gi, 'n'); }

/** identificador PostgreSQL en minusculas y snake_case */
function pgName(name) {
  let n = stripAccents(name).toLowerCase().replace(/[^a-z0-9_]+/g, '_').replace(/_+/g, '_').replace(/^_|_$/g, '');
  if (!n) n = 'col';
  if (/^[0-9]/.test(n)) n = 'c_' + n;
  return n;
}
const q = n => (PG_RESERVED.has(n) ? `"${n}"` : n);

function words(name) { return pgName(name).split('_').filter(Boolean); }
const cap = w => w.charAt(0).toUpperCase() + w.slice(1);

function javaClass(table) {
  let n = words(table).map(cap).join('');
  if (/^[0-9]/.test(n)) n = 'T' + n;
  return n;
}
function javaField(col) {
  const w = words(col);
  let n = w[0] + w.slice(1).map(cap).join('');
  if (/^[0-9]/.test(n)) n = 'c' + n;
  if (JAVA_KEYWORDS.has(n)) n = n + '_';
  if (RESERVED_FIELDS.has(n.toLowerCase())) n = 'legacy' + cap(n);
  return n;
}
function label(col) {
  return words(col).map(cap).join(' ');
}
function truncate63(n) { return n.length <= 63 ? n : n.substring(0, 55) + '_' + hash(n).substring(0, 7); }
function hash(s) { let h = 0; for (const c of s) h = (h * 31 + c.charCodeAt(0)) >>> 0; return h.toString(16).padStart(8, '0'); }

module.exports = { pgName, q, javaClass, javaField, label, truncate63, PG_RESERVED };
