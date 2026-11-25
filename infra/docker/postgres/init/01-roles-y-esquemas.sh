#!/bin/sh
# Crea un rol y un esquema por microservicio (principio de minimo privilegio:
# cada servicio solo puede escribir en su propio esquema). Se ejecuta una sola vez
# al inicializar el volumen de PostgreSQL.
set -eu

SERVICES="seguridad maestros logistica ventas contabilidad finanzas rrhh produccion"
PASS="${SIGE_DB_SERVICE_PASSWORD:?Defina SIGE_DB_SERVICE_PASSWORD}"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
  CREATE EXTENSION IF NOT EXISTS pgcrypto;
  REVOKE CREATE ON SCHEMA public FROM PUBLIC;
  CREATE ROLE sige_reportes LOGIN PASSWORD '${PASS}';
EOSQL

for s in $SERVICES; do
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE sige_${s} LOGIN PASSWORD '${PASS}';
    CREATE SCHEMA ${s} AUTHORIZATION sige_${s};
    ALTER ROLE sige_${s} SET search_path = ${s};
    GRANT USAGE ON SCHEMA ${s} TO sige_reportes;
    ALTER DEFAULT PRIVILEGES FOR ROLE sige_${s} IN SCHEMA ${s} GRANT SELECT ON TABLES TO sige_reportes;
EOSQL
done
echo "Roles y esquemas SIGE creados"
