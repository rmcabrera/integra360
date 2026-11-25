# Arranca microservicios (jar ya compilado) contra la infraestructura de infra/docker (perfil infra),
# SIN seguridad (solo pruebas locales). Logs en tools/smoke/logs.
param([string[]]$Services = @("maestros", "logistica", "ventas", "contabilidad"))
$root = Resolve-Path "$PSScriptRoot\..\.."
$envFile = Get-Content "$root\infra\docker\.env" | ConvertFrom-StringData
$ports = @{ seguridad = 8081; maestros = 8082; logistica = 8083; ventas = 8084; contabilidad = 8085; finanzas = 8086; rrhh = 8087; produccion = 8088 }
New-Item -ItemType Directory -Force "$PSScriptRoot\logs" | Out-Null
foreach ($s in $Services) {
  $env:DB_USER = "sige_$s"
  $env:DB_PASSWORD = $envFile.SIGE_DB_SERVICE_PASSWORD
  $env:KAFKA_BOOTSTRAP = "localhost:29092"
  $env:QUARKUS_OIDC_ENABLED = "false"
  $env:QUARKUS_HTTP_AUTH_PERMISSION_READ_POLICY = "permit"
  $env:QUARKUS_HTTP_AUTH_PERMISSION_WRITE_POLICY = "permit"
  $env:LOG_JSON = "false"
  $env:OUTBOX_INTERVAL = "1s"
  $env:MS_MAESTROS_URL = "http://localhost:8082"
  $env:PORT = $ports[$s]
  $jar = "$root\backend\services\ms-$s\target\quarkus-app\quarkus-run.jar"
  Start-Process -FilePath java -ArgumentList "-jar", $jar -RedirectStandardOutput "$PSScriptRoot\logs\ms-$s.log" -RedirectStandardError "$PSScriptRoot\logs\ms-$s.err" -WindowStyle Hidden -PassThru | % { "ms-$s pid $($_.Id) puerto $($ports[$s])" }
}
