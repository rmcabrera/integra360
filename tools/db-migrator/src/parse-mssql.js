'use strict';
/**
 * Parser del script T-SQL (SQL Server) generado por SSMS.
 * Extrae tablas, columnas, PK, UK, FK, defaults, indices, descripciones
 * y el catalogo de procedimientos/funciones/vistas/triggers de la BD principal.
 */
const fs = require('fs');

function readScript(file) {
  const buf = fs.readFileSync(file);
  if (buf[0] === 0xff && buf[1] === 0xfe) return buf.slice(2).toString('utf16le');
  if (buf[0] === 0xef && buf[1] === 0xbb && buf[2] === 0xbf) return buf.slice(3).toString('utf8');
  return buf.toString('latin1');
}

const unq = s => s.replace(/^\[|\]$/g, '').trim();

/** separa por comas de primer nivel (respeta parentesis y comillas) */
function splitTop(s) {
  const out = []; let depth = 0, cur = '', q = false;
  for (let i = 0; i < s.length; i++) {
    const c = s[i];
    if (c === "'") q = !q;
    if (!q) {
      if (c === '(') depth++;
      else if (c === ')') depth--;
      else if (c === ',' && depth === 0) { out.push(cur); cur = ''; continue; }
    }
    cur += c;
  }
  if (cur.trim()) out.push(cur);
  return out.map(x => x.trim()).filter(Boolean);
}

/** devuelve el contenido entre el parentesis que abre en idx y su cierre */
function balanced(s, idx) {
  let depth = 0, q = false;
  for (let i = idx; i < s.length; i++) {
    const c = s[i];
    if (c === "'") q = !q;
    if (q) continue;
    if (c === '(') depth++;
    else if (c === ')') { depth--; if (depth === 0) return { body: s.substring(idx + 1, i), end: i }; }
  }
  return { body: s.substring(idx + 1), end: s.length };
}

const colList = s => s.split(',').map(x => unq(x.trim().replace(/\s+(ASC|DESC)$/i, ''))).filter(Boolean);

function parseColumn(def) {
  // computed column:  [mes]  AS (datepart(month,[fech_fact]))
  let m = def.match(/^\[([^\]]+)\]\s+AS\s+(.*)$/is);
  if (m) return { name: m[1], computed: m[2].trim(), nullable: true };
  m = def.match(/^\[([^\]]+)\]\s+(?:\[(\w+)\]\.)?\[?(\w+)\]?\s*(\(([^)]*)\))?(.*)$/is);
  if (!m) return null;
  const rest = m[6] || '';
  const col = {
    name: m[1],
    type: m[3].toLowerCase(),
    args: m[5] ? m[5].split(',').map(x => x.trim().toLowerCase()) : [],
    nullable: !/NOT\s+NULL/i.test(rest),
    identity: /IDENTITY/i.test(rest),
    rowguid: /ROWGUIDCOL/i.test(rest)
  };
  const d = rest.match(/DEFAULT\s+(\(.*\))/i);
  if (d) col.default = d[1];
  return col;
}

function parse(file, mainDb) {
  const sql = readScript(file);
  const batches = sql.split(/\r?\n\s*GO\s*\r?\n/i);
  let db = null;
  const tables = new Map();
  const routines = [];
  const T = name => tables.get(name.toLowerCase());
  for (const raw of batches) {
    const b = raw.replace(/\/\*{6}[\s\S]*?\*{6}\//g, '').trim();
    const use = b.match(/^USE\s+\[(\w+)\]/i);
    if (use) { db = use[1].toLowerCase(); continue; }
    if (db !== mainDb.toLowerCase()) continue;

    let m = b.match(/^CREATE\s+TABLE\s+\[(\w+)\]\.\[([^\]]+)\]\s*\(/i);
    if (m) {
      const open = b.indexOf('(', m.index + m[0].length - 1);
      const { body } = balanced(b, open);
      const t = { name: m[2], schema: m[1], columns: [], pk: null, uniques: [], fks: [], indexes: [], comment: null };
      for (const item of splitTop(body)) {
        const c = item.match(/^(?:CONSTRAINT\s+\[([^\]]+)\]\s+)?(PRIMARY\s+KEY|UNIQUE)[^(]*\(([^)]*)\)/is);
        if (c) {
          const cols = colList(c[3]);
          const cname = c[1] || (/PRIMARY/i.test(c[2]) ? 'PK_' + m[2] : 'UQ_' + m[2] + '_' + t.uniques.length);
          if (/PRIMARY/i.test(c[2])) t.pk = { name: cname, columns: cols };
          else t.uniques.push({ name: cname, columns: cols });
          continue;
        }
        if (/^(PRIMARY\s+KEY|UNIQUE|CHECK|FOREIGN)/i.test(item)) continue;
        const col = parseColumn(item);
        if (col) { t.columns.push(col); if (/PRIMARY\s+KEY/i.test(item) && !col.computed) t.pk = { name: 'PK_' + m[2], columns: [col.name] }; }
      }
      tables.set(t.name.toLowerCase(), t);
      continue;
    }

    m = b.match(/^ALTER\s+TABLE\s+\[\w+\]\.\[([^\]]+)\]\s+(?:WITH\s+(?:NO)?CHECK\s+)?ADD\s+CONSTRAINT\s+\[([^\]]+)\]\s+FOREIGN\s+KEY\s*\(([^)]*)\)\s*REFERENCES\s+\[\w+\]\.\[([^\]]+)\]\s*\(([^)]*)\)(.*)$/is);
    if (m) {
      const t = T(m[1]);
      if (t) t.fks.push({ name: m[2], columns: colList(m[3]), refTable: m[4], refColumns: colList(m[5]),
        onDelete: /ON\s+DELETE\s+CASCADE/i.test(m[6]) ? 'CASCADE' : null, onUpdate: /ON\s+UPDATE\s+CASCADE/i.test(m[6]) ? 'CASCADE' : null });
      continue;
    }
    m = b.match(/^ALTER\s+TABLE\s+\[\w+\]\.\[([^\]]+)\]\s+ADD\s+CONSTRAINT\s+\[([^\]]+)\]\s+DEFAULT\s+([\s\S]*?)\s+FOR\s+\[([^\]]+)\]/i);
    if (m) {
      const t = T(m[1]);
      const col = t && t.columns.find(c => c.name.toLowerCase() === m[4].toLowerCase());
      if (col) col.default = m[3].trim();
      continue;
    }
    m = b.match(/^ALTER\s+TABLE\s+\[\w+\]\.\[([^\]]+)\]\s+ADD\s+CONSTRAINT\s+\[([^\]]+)\]\s+(PRIMARY\s+KEY|UNIQUE)[^(]*\(([^)]*)\)/i);
    if (m) {
      const t = T(m[1]);
      if (t) { if (/PRIMARY/i.test(m[3])) t.pk = { name: m[2], columns: colList(m[4]) }; else t.uniques.push({ name: m[2], columns: colList(m[4]) }); }
      continue;
    }
    // indices (puede haber varios CREATE INDEX por lote)
    const idxRe = /CREATE\s+(UNIQUE\s+)?(?:NON)?CLUSTERED\s+INDEX\s+\[([^\]]+)\]\s+ON\s+\[\w+\]\.\[([^\]]+)\]\s*\(([^)]*)\)(\s*INCLUDE\s*\(([^)]*)\))?/gi;
    let im, any = false;
    while ((im = idxRe.exec(b))) {
      any = true;
      const t = T(im[3]);
      if (t) t.indexes.push({ name: im[2], unique: !!im[1], columns: colList(im[4]), include: im[6] ? colList(im[6]) : [] });
    }
    if (any) continue;

    m = b.match(/sp_addextendedproperty\s+@name\s*=\s*N'MS_Description'\s*,\s*@value\s*=\s*N'((?:[^']|'')*)'[\s\S]*?@level1name\s*=\s*N'([^']+)'(?:[\s\S]*?@level2name\s*=\s*N'([^']+)')?/i);
    if (m) {
      const t = T(m[2]);
      if (t) {
        const txt = m[1].replace(/''/g, "'");
        if (m[3]) { const col = t.columns.find(c => c.name.toLowerCase() === m[3].toLowerCase()); if (col) col.comment = txt; }
        else t.comment = txt;
      }
      continue;
    }

    m = b.match(/^CREATE\s+(PROC(?:EDURE)?|VIEW|FUNCTION|TRIGGER)\s+\[?(\w+)\]?\.\[?([^\]\s(]+)\]?/i);
    if (m) {
      const kind = m[1].toUpperCase().startsWith('PROC') ? 'PROCEDURE' : m[1].toUpperCase();
      const refs = new Set();
      const lower = b.toLowerCase();
      for (const name of tables.keys()) {
        if (new RegExp('[\\s\\[.,(]' + name.replace(/[$]/g, '\\$') + '[\\]\\s,(;)]').test(lower)) refs.add(name);
      }
      const writes = /\b(insert|update|delete)\b/i.test(b.replace(/--.*$/gm, ''));
      routines.push({ kind, name: m[3], lines: b.split('\n').length, writes, tables: [...refs], body: b });
    }
  }
  return { tables: [...tables.values()], routines };
}

module.exports = { parse, readScript };
