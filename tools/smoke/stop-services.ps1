# Detiene los microservicios lanzados con run-services.ps1 (por puerto, ya que java.exe de Oracle es un lanzador)
foreach ($p in 8081..8088) {
  Get-NetTCPConnection -LocalPort $p -State Listen -ErrorAction SilentlyContinue | ForEach-Object {
    Stop-Process -Id $_.OwningProcess -Force -ErrorAction SilentlyContinue
    "detenido puerto $p (pid $($_.OwningProcess))"
  }
}
