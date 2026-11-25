# Migracion de datos SQL Server -> PostgreSQL (SIGE)

Procedimiento para cargar los datos del ERP legado (SQL Server, base `SI_AGROG`,
nivel de compatibilidad 80, `SQL_Latin1_General_CP1_CI_AS`) al modelo PostgreSQL
de SIGE. Los artefactos de esta carpeta se **generan**; no los edite a mano:

    node tools/db-migrator/src/gen-data-migration.js

## Artefactos

| Archivo | Que hace |
|---|---|
| `pgloader.load` | Carga cruda de `dbo` -> esquema `legacy_raw` (tipos minimos, char con rtrim). |
| `10-transform.sql` | `legacy_raw` -> esquemas destino (contabilidad, finanzas, logistica, maestros, produccion, rrhh, seguridad, staging, ventas). |
| `20-validar.sql` | Conteo de filas legacy vs destino y validacion de FKs NOT VALID. |
| `test/legacy_raw_vacio.sql` | DDL de `legacy_raw` como text (solo pruebas, 0 filas). |

Resumen del mapeo: **537 tablas** en 9 esquemas
(contabilidad, finanzas, logistica, maestros, produccion, rrhh, seguridad, staging, ventas); 38 columnas de identidad del legado,
43 tablas con clave sustituta y 2 columnas calculadas.

## Requisitos previos

- El esquema destino ya debe existir. Opcion A: arrancar los microservicios una
  vez (Flyway aplica V1..V5 por servicio). Opcion B: aplicar el script unificado:

      psql "$PG_URI" -f database/postgresql/sige_postgresql_completo.sql

- `pgloader` (se recomienda el contenedor `dimitri/pgloader`) y `psql`.
- Conectividad a SQL Server origen y a PostgreSQL destino.

## Procedimiento

### 1. Carga cruda con pgloader

`pgloader` renombra `dbo` a `legacy_raw`, convierte `bit`->`boolean`,
`datetime`->`timestamptz`, `money`->`numeric` y `char`->`text` con
right-trim. Defina las URIs y ejecute (ejemplo con el contenedor, montando esta
carpeta; use una red que alcance ambas bases):

```bash
export MSSQL_URI='mssql://usuario:clave@MSSQL_HOST:1433/SI_AGROG'
export PG_URI='postgresql://postgres:clave@PG_HOST:5432/sige'

# sustituye las URIs de plantilla y ejecuta pgloader
envsubst < database/migracion-datos/pgloader.load > /tmp/sige.load
docker run --rm --network host -v /tmp/sige.load:/sige.load:ro \
  dimitri/pgloader:latest pgloader /sige.load
```

> pgloader pasa los identificadores a minusculas y conserva el resto de
> caracteres. `10-transform.sql` cita siempre los nombres de `legacy_raw`.

### 2. Transformar al modelo destino

```bash
psql "$PG_URI" -v ON_ERROR_STOP=1 -f database/migracion-datos/10-transform.sql
```

Cada esquema corre en su transaccion con `session_replication_role = replica`
(difiere disparadores y FKs). Los textos se limpian con `rtrim`/`NULLIF`, las
identidades del legado se reinsertan y sus secuencias se reajustan con `setval`.
`ON CONFLICT DO NOTHING` hace el paso reejecutable.

### 3. Validar

```bash
psql "$PG_URI" -f database/migracion-datos/20-validar.sql
```

Revise que `diferencia` sea 0 por tabla. Luego, tras depurar huerfanos, valide
las FKs NOT VALID ejecutando el DDL que emite la segunda consulta.

### 4. Arrancar los servicios

Con los datos ya cargados y V1..V5 aplicadas, arranque normalmente. **No** hace
falta `FLYWAY_BASELINE`: las migraciones V1..V5 ya estan registradas. Solo use
`FLYWAY_BASELINE=true` si la BD tuviera datos pero sin la tabla de historial de
Flyway.

## Varias empresas (multi-tenant: una base por empresa)

Las bases `SI_dcvp`, `si_green`, `SIEP_AGROM`, `siep_agrog` y `SI_agrom`
contienen un subconjunto de las mismas tablas. Migre **cada empresa a su propia
base PostgreSQL** (un `sige` por empresa/tenant) repitiendo el procedimiento:

1. Cree la base destino y aplique `sige_postgresql_completo.sql`.
2. Ajuste `MSSQL_URI` (base de esa empresa) y `PG_URI` (base destino de esa empresa).
3. Ejecute pgloader + `10-transform.sql` + `20-validar.sql`.

`10-transform.sql` usa `ON CONFLICT DO NOTHING` y solo inserta las tablas
presentes; si una empresa no tiene alguna tabla, cree su `legacy_raw` solo con
las que existan o ignore el error de esa tabla.

## Pruebas (sin conexion a SQL Server)

`test/legacy_raw_vacio.sql` recrea `legacy_raw` con todas las columnas como
`text` y 0 filas. Permite comprobar que `10-transform.sql` es valido:

```bash
psql "$PG_URI" -f database/postgresql/sige_postgresql_completo.sql
psql "$PG_URI" -f database/migracion-datos/test/legacy_raw_vacio.sql
psql "$PG_URI" -v ON_ERROR_STOP=1 -f database/migracion-datos/10-transform.sql   # 0 filas, sin error
```
