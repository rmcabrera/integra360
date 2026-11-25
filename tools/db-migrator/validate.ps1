# Regenera los artefactos y valida el script completo contra un PostgreSQL efimero en Docker.
param(
  [string]$Script = "..\..\..\script.sql",
  [string]$Image = "postgres:17-alpine"
)
$ErrorActionPreference = "Continue"
$root = Resolve-Path "$PSScriptRoot\..\.."
node "$PSScriptRoot\src\generate.js" $Script $root
if ($LASTEXITCODE -ne 0) { throw "generacion fallida" }

$name = "sige-pg-validate"
docker rm -f $name 2>$null | Out-Null
docker run -d --name $name -e POSTGRES_PASSWORD=validate $Image | Out-Null
for ($i = 0; $i -lt 30; $i++) { docker exec $name pg_isready -U postgres 2>$null | Out-Null; if ($LASTEXITCODE -eq 0) { break }; Start-Sleep 1 }
Start-Sleep 2
docker cp "$root\database\postgresql\sige_postgresql_completo.sql" "${name}:/tmp/full.sql"
docker exec $name psql -U postgres -v ON_ERROR_STOP=1 -q -f /tmp/full.sql
$ok = $LASTEXITCODE
docker exec $name psql -U postgres -t -c "select table_schema, count(*) from information_schema.tables where table_schema not in ('pg_catalog','information_schema') group by 1 order by 1"
docker rm -f $name | Out-Null
if ($ok -ne 0) { throw "El script PostgreSQL tiene errores" }
Write-Host "OK: script PostgreSQL valido"
