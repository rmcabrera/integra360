'use strict';
/**
 * Generador de la migracion de DATOS SQL Server -> PostgreSQL.
 *
 * Lee database/catalogo/mapeo-columnas.json (tabla/columna legado -> destino PG)
 * y escribe en database/migracion-datos/:
 *   - pgloader.load                 carga cruda dbo -> esquema legacy_raw (pgloader)
 *   - 10-transform.sql              legacy_raw -> esquemas destino (rtrim, cast, ON CONFLICT)
 *   - 20-validar.sql               conteo de filas legacy_raw vs destino + validacion de FKs NOT VALID
 *   - README.md                     procedimiento completo (ES)
 *   - test/legacy_raw_vacio.sql     DDL de legacy_raw con todas las columnas como text (solo pruebas)
 *
 * Sin dependencias externas. Uso: node tools/db-migrator/src/gen-data-migration.js
 */
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..', '..', '..');
const MAP_FILE = path.join(ROOT, 'database', 'catalogo', 'mapeo-columnas.json');
const OUT_DIR = path.join(ROOT, 'database', 'migracion-datos');

const RAW_SCHEMA = 'legacy_raw';
const map = JSON.parse(fs.readFileSync(MAP_FILE, 'utf8'));

const write = (f, s) => {
  fs.mkdirSync(path.dirname(f), { recursive: true });
  fs.writeFileSync(f, s.replace(/\r?\n/g, '\n'), 'utf8');
};
// comilla doble de identificador PG (duplica comillas internas)
const dq = s => '"' + String(s).replace(/"/g, '""') + '"';
// literal de cadena SQL
const lit = s => "'" + String(s).replace(/'/g, "''") + "'";

const HEADER = '-- Generado por tools/db-migrator/src/gen-data-migration.js a partir de\n' +
  '-- database/catalogo/mapeo-columnas.json. No editar a mano: regenerar con el script.\n';

// nombre de la columna/tabla tal como la deja pgloader en legacy_raw:
// pgloader (downcase identifiers, por defecto en MS SQL) pasa a minusculas y conserva
// el resto de caracteres (espacios, '#', '/', ...), por eso se citan siempre.
const rawName = legacy => String(legacy).toLowerCase();

// expresion de conversion desde la columna text de legacy_raw al tipo destino
function castExpr(srcIdent, pgType) {
  const t = pgType.trim();
  const isText = /^(varchar|char|text|bpchar)/i.test(t);
  // char(n) del legado viene con relleno de espacios -> rtrim; el resto btrim
  const trim = isText ? 'rtrim' : 'btrim';
  return `NULLIF(${trim}(${srcIdent}::text), '')::${t}`;
}

// -------------------------------------------------------------- agrupar por esquema
const bySchema = new Map();
for (const [legacy, t] of Object.entries(map)) {
  if (!bySchema.has(t.schema)) bySchema.set(t.schema, []);
  bySchema.get(t.schema).push({ legacy, ...t });
}
const schemas = [...bySchema.keys()].sort();
for (const s of schemas) bySchema.get(s).sort((a, b) => a.table.localeCompare(b.table));

const totalTables = Object.keys(map).length;
let totalIdentity = 0, totalGenerated = 0, totalSurrogate = 0;
for (const t of Object.values(map)) {
  if (t.surrogateKey) totalSurrogate++;
  for (const c of Object.values(t.columns)) { if (c.identity) totalIdentity++; if (c.generated) totalGenerated++; }
}

// ================================================================ (a) pgloader.load
function genPgloader() {
  const names = Object.keys(map).sort().map(lit);
  // una linea por tabla para que el diff sea legible
  const list = names.join(',\n                            ');
  return `/*
 * Carga CRUDA SQL Server (dbo) -> PostgreSQL (esquema ${RAW_SCHEMA}).
 * Genera tablas y datos tal cual, aplicando solo conversiones de tipo seguras.
 * La normalizacion al modelo destino la hace 10-transform.sql.
 *
 * Las URIs son plantillas: sustituyalas (p.ej. con envsubst) antes de ejecutar.
 *   export MSSQL_URI='mssql://usuario:clave@HOST:1433/SI_AGROG'
 *   export PG_URI='postgresql://postgres:clave@HOST:5432/sige'
 *   envsubst < pgloader.load > /tmp/sige.load && pgloader /tmp/sige.load
 * Vea README.md para la version en contenedor (dimitri/pgloader).
 */
LOAD DATABASE
     FROM      \${MSSQL_URI}
     INTO      \${PG_URI}

 WITH include drop,
      create tables,
      create no indexes,
      reset sequences,
      data only = false,
      preserve index names,
      workers = 4, concurrency = 1,
      batch rows = 2500,
      prefetch rows = 10000

  SET PostgreSQL PARAMETERS
      maintenance_work_mem to '256MB',
      work_mem to '64MB'

 CAST type bit             to boolean    drop typemod using bits-to-boolean,
      type tinyint         to smallint   drop typemod,
      type datetime        to timestamptz drop default drop not null using zero-dates-to-null,
      type smalldatetime   to timestamptz drop default drop not null using zero-dates-to-null,
      type datetime2       to timestamptz drop default drop not null using zero-dates-to-null,
      type money           to numeric    drop typemod,
      type smallmoney      to numeric    drop typemod,
      type char            to text       drop typemod using right-trim,
      type nchar           to text       drop typemod using right-trim,
      type varchar         to text       drop typemod,
      type nvarchar        to text       drop typemod,
      type ntext           to text       drop typemod,
      type xml             to text       drop typemod

 INCLUDING ONLY TABLE NAMES MATCHING ${list}
     IN SCHEMA 'dbo'

 ALTER SCHEMA 'dbo' RENAME TO '${RAW_SCHEMA}'
;
`;
}

// ================================================================ (b) 10-transform.sql
function genTransform() {
  const out = [HEADER,
    '-- legacy_raw (carga cruda de pgloader) -> esquemas destino del modelo SIGE.',
    '-- Reglas: rtrim a textos (char(n) venia con relleno), NULLIF(...,'+"''"+') -> NULL,',
    "-- cast al tipo destino, se omiten columnas GENERATED ALWAYS, las claves sustitutas",
    '-- se dejan a su valor por defecto y las identidades del legado se reinsertan y luego',
    '-- se reajusta su secuencia con setval. Cada esquema va en su propia transaccion con',
    '-- session_replication_role = replica para diferir disparadores y chequeos de FK.',
    "\\set ON_ERROR_STOP on", ''];

  for (const schema of schemas) {
    const tables = bySchema.get(schema);
    out.push('-- =====================================================================');
    out.push(`-- ESQUEMA ${schema}  (${tables.length} tablas)`);
    out.push('-- =====================================================================');
    out.push('BEGIN;');
    out.push('SET LOCAL session_replication_role = replica;');
    out.push('');

    const setvals = [];
    for (const t of tables) {
      const cols = Object.entries(t.columns).filter(([, c]) => !c.generated);
      if (!cols.length) { out.push(`-- ${t.legacy}: sin columnas insertables (todas GENERATED), se omite`, ''); continue; }
      const dst = `${dq(t.schema)}.${dq(t.table)}`;
      const src = `${dq(RAW_SCHEMA)}.${dq(rawName(t.legacy))}`;
      const targetCols = cols.map(([, c]) => dq(c.column)).join(', ');
      const exprs = cols.map(([lk, c]) => '       ' + castExpr(dq(rawName(lk)), c.type) + ' AS ' + dq(c.column)).join(',\n');
      out.push(`-- ${t.legacy} -> ${t.schema}.${t.table}  (${cols.length} col)`);
      out.push(`INSERT INTO ${dst} (${targetCols})`);
      out.push('SELECT');
      out.push(exprs);
      out.push(`FROM ${src}`);
      out.push('ON CONFLICT DO NOTHING;');
      out.push('');

      for (const [, c] of Object.entries(t.columns)) {
        if (!c.identity) continue;
        const qualified = lit(`${dq(t.schema)}.${dq(t.table)}`);
        setvals.push(`SELECT setval(pg_get_serial_sequence(${qualified}, ${lit(c.column)}),\n` +
          `              (SELECT COALESCE(MAX(${dq(c.column)}), 1) FROM ${dst}),\n` +
          `              (SELECT COUNT(*) > 0 FROM ${dst}));`);
      }
    }
    if (setvals.length) {
      out.push('-- reajuste de secuencias de identidad del legado');
      out.push(...setvals, '');
    }
    out.push('COMMIT;', '');
  }
  return out.join('\n');
}

// ================================================================ (c) 20-validar.sql
function genValidar() {
  const branches = [];
  for (const schema of schemas) {
    for (const t of bySchema.get(schema)) {
      const dst = `${dq(t.schema)}.${dq(t.table)}`;
      const src = `${dq(RAW_SCHEMA)}.${dq(rawName(t.legacy))}`;
      branches.push(
        `SELECT ${lit(t.schema + '.' + t.table)} AS tabla,\n` +
        `       (SELECT count(*) FROM ${src}) AS filas_legacy,\n` +
        `       (SELECT count(*) FROM ${dst}) AS filas_destino,\n` +
        `       (SELECT count(*) FROM ${dst}) - (SELECT count(*) FROM ${src}) AS diferencia`);
    }
  }
  return HEADER +
`-- =====================================================================
-- 1) Comparacion de conteo de filas legacy_raw vs destino.
--    'diferencia' = destino - legacy. 0 = carga completa (si no hay duplicados
--    descartados por ON CONFLICT). Un valor negativo indica filas no migradas.
-- =====================================================================
${branches.join('\nUNION ALL\n')}
ORDER BY diferencia, tabla;

-- =====================================================================
-- 2) Claves foraneas NOT VALID pendientes de validar.
--    En SQL Server estaban WITH NOCHECK; en PG se crearon NOT VALID. Tras
--    depurar los datos huerfanos, valide cada una.
-- =====================================================================
SELECT n.nspname AS esquema, rel.relname AS tabla, c.conname AS constraint
FROM pg_constraint c
JOIN pg_class rel     ON rel.oid = c.conrelid
JOIN pg_namespace n   ON n.oid  = rel.relnamespace
WHERE c.contype = 'f'
  AND NOT c.convalidated
ORDER BY n.nspname, rel.relname, c.conname;

-- Genera las sentencias ALTER ... VALIDATE CONSTRAINT (ejecute la salida):
SELECT format('ALTER TABLE %I.%I VALIDATE CONSTRAINT %I;', n.nspname, rel.relname, c.conname) AS ddl
FROM pg_constraint c
JOIN pg_class rel     ON rel.oid = c.conrelid
JOIN pg_namespace n   ON n.oid  = rel.relnamespace
WHERE c.contype = 'f'
  AND NOT c.convalidated
ORDER BY n.nspname, rel.relname, c.conname;
`;
}

// ================================================================ (e) test/legacy_raw_vacio.sql
function genRawVacio() {
  const out = ['-- Solo para pruebas: recrea el esquema legacy_raw con TODAS las columnas del',
    '-- legado como text y 0 filas, para verificar que 10-transform.sql es valido.',
    '-- NO usar en produccion (ahi las tablas las crea pgloader con sus tipos reales).',
    `DROP SCHEMA IF EXISTS ${RAW_SCHEMA} CASCADE;`,
    `CREATE SCHEMA ${RAW_SCHEMA};`, ''];
  for (const schema of schemas) {
    for (const t of bySchema.get(schema)) {
      const cols = Object.keys(t.columns).map(lk => `    ${dq(rawName(lk))} text`);
      out.push(`CREATE TABLE ${dq(RAW_SCHEMA)}.${dq(rawName(t.legacy))} (\n${cols.join(',\n')}\n);`);
    }
  }
  out.push('');
  return out.join('\n');
}

// ================================================================ (d) README.md
function genReadme() {
  return `# Migracion de datos SQL Server -> PostgreSQL (SIGE)

Procedimiento para cargar los datos del ERP legado (SQL Server, base \`SI_AGROG\`,
nivel de compatibilidad 80, \`SQL_Latin1_General_CP1_CI_AS\`) al modelo PostgreSQL
de SIGE. Los artefactos de esta carpeta se **generan**; no los edite a mano:

    node tools/db-migrator/src/gen-data-migration.js

## Artefactos

| Archivo | Que hace |
|---|---|
| \`pgloader.load\` | Carga cruda de \`dbo\` -> esquema \`${RAW_SCHEMA}\` (tipos minimos, char con rtrim). |
| \`10-transform.sql\` | \`${RAW_SCHEMA}\` -> esquemas destino (${schemas.join(', ')}). |
| \`20-validar.sql\` | Conteo de filas legacy vs destino y validacion de FKs NOT VALID. |
| \`test/legacy_raw_vacio.sql\` | DDL de \`${RAW_SCHEMA}\` como text (solo pruebas, 0 filas). |

Resumen del mapeo: **${totalTables} tablas** en ${schemas.length} esquemas
(${schemas.join(', ')}); ${totalIdentity} columnas de identidad del legado,
${totalSurrogate} tablas con clave sustituta y ${totalGenerated} columnas calculadas.

## Requisitos previos

- El esquema destino ya debe existir. Opcion A: arrancar los microservicios una
  vez (Flyway aplica V1..V5 por servicio). Opcion B: aplicar el script unificado:

      psql "$PG_URI" -f database/postgresql/sige_postgresql_completo.sql

- \`pgloader\` (se recomienda el contenedor \`dimitri/pgloader\`) y \`psql\`.
- Conectividad a SQL Server origen y a PostgreSQL destino.

## Procedimiento

### 1. Carga cruda con pgloader

\`pgloader\` renombra \`dbo\` a \`${RAW_SCHEMA}\`, convierte \`bit\`->\`boolean\`,
\`datetime\`->\`timestamptz\`, \`money\`->\`numeric\` y \`char\`->\`text\` con
right-trim. Defina las URIs y ejecute (ejemplo con el contenedor, montando esta
carpeta; use una red que alcance ambas bases):

\`\`\`bash
export MSSQL_URI='mssql://usuario:clave@MSSQL_HOST:1433/SI_AGROG'
export PG_URI='postgresql://postgres:clave@PG_HOST:5432/sige'

# sustituye las URIs de plantilla y ejecuta pgloader
envsubst < database/migracion-datos/pgloader.load > /tmp/sige.load
docker run --rm --network host -v /tmp/sige.load:/sige.load:ro \\
  dimitri/pgloader:latest pgloader /sige.load
\`\`\`

> pgloader pasa los identificadores a minusculas y conserva el resto de
> caracteres. \`10-transform.sql\` cita siempre los nombres de \`${RAW_SCHEMA}\`.

### 2. Transformar al modelo destino

\`\`\`bash
psql "$PG_URI" -v ON_ERROR_STOP=1 -f database/migracion-datos/10-transform.sql
\`\`\`

Cada esquema corre en su transaccion con \`session_replication_role = replica\`
(difiere disparadores y FKs). Los textos se limpian con \`rtrim\`/\`NULLIF\`, las
identidades del legado se reinsertan y sus secuencias se reajustan con \`setval\`.
\`ON CONFLICT DO NOTHING\` hace el paso reejecutable.

### 3. Validar

\`\`\`bash
psql "$PG_URI" -f database/migracion-datos/20-validar.sql
\`\`\`

Revise que \`diferencia\` sea 0 por tabla. Luego, tras depurar huerfanos, valide
las FKs NOT VALID ejecutando el DDL que emite la segunda consulta.

### 4. Arrancar los servicios

Con los datos ya cargados y V1..V5 aplicadas, arranque normalmente. **No** hace
falta \`FLYWAY_BASELINE\`: las migraciones V1..V5 ya estan registradas. Solo use
\`FLYWAY_BASELINE=true\` si la BD tuviera datos pero sin la tabla de historial de
Flyway.

## Varias empresas (multi-tenant: una base por empresa)

Las bases \`SI_dcvp\`, \`si_green\`, \`SIEP_AGROM\`, \`siep_agrog\` y \`SI_agrom\`
contienen un subconjunto de las mismas tablas. Migre **cada empresa a su propia
base PostgreSQL** (un \`sige\` por empresa/tenant) repitiendo el procedimiento:

1. Cree la base destino y aplique \`sige_postgresql_completo.sql\`.
2. Ajuste \`MSSQL_URI\` (base de esa empresa) y \`PG_URI\` (base destino de esa empresa).
3. Ejecute pgloader + \`10-transform.sql\` + \`20-validar.sql\`.

\`10-transform.sql\` usa \`ON CONFLICT DO NOTHING\` y solo inserta las tablas
presentes; si una empresa no tiene alguna tabla, cree su \`${RAW_SCHEMA}\` solo con
las que existan o ignore el error de esa tabla.

## Pruebas (sin conexion a SQL Server)

\`test/legacy_raw_vacio.sql\` recrea \`${RAW_SCHEMA}\` con todas las columnas como
\`text\` y 0 filas. Permite comprobar que \`10-transform.sql\` es valido:

\`\`\`bash
psql "$PG_URI" -f database/postgresql/sige_postgresql_completo.sql
psql "$PG_URI" -f database/migracion-datos/test/legacy_raw_vacio.sql
psql "$PG_URI" -v ON_ERROR_STOP=1 -f database/migracion-datos/10-transform.sql   # 0 filas, sin error
\`\`\`
`;
}

// -------------------------------------------------------------- escritura
write(path.join(OUT_DIR, 'pgloader.load'), genPgloader());
write(path.join(OUT_DIR, '10-transform.sql'), genTransform());
write(path.join(OUT_DIR, '20-validar.sql'), genValidar());
write(path.join(OUT_DIR, 'test', 'legacy_raw_vacio.sql'), genRawVacio());
write(path.join(OUT_DIR, 'README.md'), genReadme());

console.log('Migracion de datos generada en', path.relative(ROOT, OUT_DIR));
console.log(`  tablas=${totalTables} esquemas=${schemas.length} identidad=${totalIdentity} sustitutas=${totalSurrogate} generadas=${totalGenerated}`);
