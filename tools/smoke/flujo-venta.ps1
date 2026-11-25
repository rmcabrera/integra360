# Prueba de humo end-to-end: maestros -> logistica -> ventas -> (Kafka) -> kardex + asiento contable
$ErrorActionPreference = "Stop"
function Call($method, $url, $body) {
  $json = if ($body) { $body | ConvertTo-Json -Depth 6 } else { $null }
  try { Invoke-RestMethod -Method $method -Uri $url -ContentType "application/json" -Body $json }
  catch { Write-Host "ERROR $method $url : $($_.ErrorDetails.Message)"; throw }
}
$M = "http://localhost:8082/api/maestros/v1/data"; $L = "http://localhost:8083/api/logistica/v1"
$V = "http://localhost:8084/api/ventas/v1"; $C = "http://localhost:8085/api/contabilidad/v1/data"
$cli = "C" + (Get-Random -Maximum 9999).ToString("0000")
$prod = (Get-Random -Minimum 10000000 -Maximum 99999999).ToString()

Call POST "$M/cliente_proveedor" @{ codiClieProv = $cli; razoSoci = "CLIENTE DEMO SAC"; ruc = "20123456789"; denominacion = "CLIENTE DEMO" } | Out-Null
Call POST "$L/data/productos" @{ codiProd = $prod; descProd = "FERTILIZANTE DEMO 50KG"; stock = 0; codiUnidMedi = "01" } | Out-Null
try { Call POST "$L/data/almacen" @{ codiAlma = "01"; descAlma = "ALMACEN PRINCIPAL"; nemoAlma = "PRINCIPAL" } | Out-Null } catch {}
try { Call POST "$V/data/almacen_documentos" @{ codiAlma = "01"; codiTipoDocu = "0001"; serieAlma = "F001"; nroDocuEmpieza = 1; nroActual = 0; estado = "1" } | Out-Null } catch {}
try { Call POST "$C/contabilizacion" @{ codigo = "0001"; descrip = "VENTAS FACTURA"; cuenta1 = "1212101"; ca1 = "C"; cuenta2 = "4011101"; ca2 = "A"; cuenta4 = "7011101"; ca4 = "A"; subdiario = "5" } | Out-Null } catch {}

Call POST "$L/kardex/movimientos" @{ codiProd = $prod; codiAlma = "01"; fecha = (Get-Date).AddDays(-1).ToString("yyyy-MM-ddT08:00:00"); io = "I"; cantidad = 100; precioUnitario = 10; codiDocuOrigen = "NI000001"; concepto = "INVENTARIO INICIAL" } | Out-Null
Call POST "$L/kardex/movimientos" @{ codiProd = $prod; codiAlma = "01"; fecha = (Get-Date).AddDays(-1).ToString("yyyy-MM-ddT09:00:00"); io = "I"; cantidad = 100; precioUnitario = 20; codiDocuOrigen = "NI000002"; concepto = "COMPRA" } | Out-Null

$f = Call POST "$V/facturas" @{ codiAlma = "01"; codiTipoDocu = "0001"; serie = "F001"; codiClieProv = $cli; fecha = (Get-Date).ToString("yyyy-MM-dd"); codiMone = "01"; aplicaIgv = $true; preciosIncluyenIgv = $false
  items = @(@{ codiProd = $prod; descripcion = "FERTILIZANTE DEMO 50KG"; codiUnidMedi = "01"; cantidad = 30; precioUnitario = 25 }) }
Write-Host "Factura $($f.codiFact) $($f.serFact)-$($f.nroFact) valor=$($f.valoFact) igv=$($f.igvFact) total=$($f.totaFact)"

Start-Sleep 6
$k = Call GET "$L/kardex?producto=$prod&periodo=$((Get-Date).Year)"
$k | % { Write-Host ("kardex {0} {1,6} {2,6} saldo={3} prom={4} valorSaldo={5}" -f $_.iO, $_.cantIngr, $_.cantSali, $_.cantSaldo, $_.precProm, $_.valoSaldo) }
$a = Call GET "$C/movi_contables?f.registro=$($f.codiFact)"
$a.items | % { Write-Host ("asiento {0} cta={1} {2} {3}" -f $_.compr, $_.nroCuen, $_.cargoAbono, $_.importe) }
$stock = Call GET "$L/productos/$prod/stock"
Write-Host "stock almacen 01 = $($stock[0].stockAlma) prom=$($stock[0].precPromAlma)"

Call POST "$V/facturas/$($f.codiFact)/anular" @{ motivo = "PRUEBA DE ANULACION" } | Out-Null
Start-Sleep 6
$k2 = Call GET "$L/kardex?producto=$prod&periodo=$((Get-Date).Year)"
$a2 = Call GET "$C/movi_contables?f.registro=$($f.codiFact)"
Write-Host "Tras anular: filas kardex=$($k2.Count) saldo=$($k2[-1].cantSaldo); asiento glosa=$($a2.items[0].glosa) importe=$($a2.items[0].importe)"
