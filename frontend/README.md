# SIGE — Frontend

Interfaz web de **SIGE - Sistema Integrado**, el ERP migrado desde PowerBuilder 10.5.
Aplicación Angular 21 (standalone + signals + zoneless), sin frameworks de UI externos:
un pequeño sistema de diseño propio en SCSS con variables CSS (tema claro/oscuro).

Idioma de la interfaz: español, locale **es-PE** (moneda **PEN**, símbolo `S/`).

## Requisitos

- Node.js 22.17 (el CLI de Angular 22 no soporta este Node; use Angular CLI 21).
- Los servicios backend (Quarkus) corriendo si desea datos reales.

> Nota de instalación: por un error de resolución de *peers* en npm 11 con el grafo
> de Vitest, las dependencias se instalan con `--legacy-peer-deps`:
>
> ```
> npm install --legacy-peer-deps
> ```

## Estructura

```
src/app/
  core/                 infraestructura transversal
    config/             carga de configuración en runtime (/config.json) y tipos
    api/                modelos tipados + servicios HTTP (data genérico, ventas, logística)
    auth/               OIDC Keycloak (config, servicio, guard, interceptor bearer)
    http/               interceptor de errores (problem+json RFC 9457 -> toast)
    toast/              servicio y componente de notificaciones
    loading/            barra de carga global + interceptor
    layout/             shell (barra superior, sidebar colapsable, breadcrumb) + menu.ts
  shared/               reutilizable
    data-grid/          grilla + formulario dirigidos por metadatos (reemplazo del DataWindow)
    pipes/ utils/       pipe de formato, utilidades CSV y de tipos de campo
  features/<modulo>/    una ruta lazy por servicio backend
    common/             landing de módulo + host de grilla genérico + fábrica de rutas
    ventas/facturas/    lista, detalle (con Anular) y "Nueva factura"
    logistica/kardex/   consulta de kardex y stock por almacén
    home/ gerencial/    inicio y placeholder gerencial
```

Módulos (rutas lazy): `seguridad`, `maestros`, `logistica`, `ventas`, `contabilidad`,
`finanzas`, `rrhh`, `produccion`, más `gerencial` (reportes en migración).

### Grilla dirigida por metadatos

El componente `app-data-grid` recibe un servicio y una entidad, consulta
`GET /api/<svc>/v1/data/<entity>/meta` y arma:

- tabla paginada en servidor (paginación/orden/`q`/filtros por columna `f.<campo>`),
- formulario de alta/edición generado desde la metadata (tipos Java -> inputs;
  campos `id` solo lectura al editar, `generated` ocultos al crear, `byte[]` omitidos),
- eliminación con confirmación y exportación de la página actual a CSV.

Las páginas de módulo (`/<modulo>`) listan todas las tablas del servicio (vivas desde
`GET /api/<svc>/v1/data`) y enlazan a `/<modulo>/tablas/<entity>`.

### Menú

El sidebar se arma desde `src/app/core/layout/menu.ts`, derivado del menú legado de
PowerBuilder (`docs/legado/menu-powerbuilder.txt`). Las secciones de nivel superior se
mapean a módulos; los ítems de mantenimiento con tabla evidente enlazan a la grilla
genérica y las pantallas dedicadas a su vista. El resto del catálogo legado se alcanza
por la landing de cada módulo (evita codificar ~600 entradas). Los botones de escritura
(nuevo/editar/eliminar/anular) se muestran solo con rol realm `admin` o `<svc>-editor`;
con autenticación deshabilitada se permite todo.

## Configuración en runtime (`config.json`)

La app carga `/config.json` al iniciar, de modo que **una misma imagen** sirve para todos
los entornos (el archivo se monta/sobre-escribe al desplegar):

```json
{
  "apiBaseUrl": "",
  "auth": { "enabled": false, "authority": "http://localhost:8180/realms/sige", "clientId": "sige-frontend" }
}
```

- `apiBaseUrl`: vacío = mismo origen (el gateway enruta `/api/*`).
- `auth.enabled`: `false` desactiva por completo OIDC (se permite todo).
- `public/config.json` trae auth desactivado; `config.docker.json` es el ejemplo con
  Keycloak activo (authority `http://localhost:8080/realms/sige` detrás del gateway).

Autenticación: Keycloak realm `sige`, cliente público `sige-frontend`, flujo de código
con **PKCE S256** (`angular-auth-oidc-client`, única dependencia extra permitida).

## Desarrollo

```
npm start
```

Levanta `ng serve` con `proxy.conf.json`, que redirige a los servicios locales:

| Ruta | Puerto | Ruta | Puerto |
|------|--------|------|--------|
| `/api/seguridad` | 8081 | `/api/contabilidad` | 8085 |
| `/api/maestros` | 8082 | `/api/finanzas` | 8086 |
| `/api/logistica` | 8083 | `/api/rrhh` | 8087 |
| `/api/ventas` | 8084 | `/api/produccion` | 8088 |

`/realms` se redirige a `8180` (Keycloak dev, opcional).

Para datos reales, levante los servicios con `tools/smoke/run-services.ps1` o
`quarkus dev` en cada servicio antes de `npm start`.

## Build

```
npm run build
```

Genera `dist/frontend/browser`. El bundle inicial se mantiene holgadamente por debajo de
500 kB (≈ 420 kB *raw* / ≈ 108 kB transferidos). Los *budgets* pueden advertir pero no
deben fallar.

## Pruebas

```
npm test
```

Ejecuta Vitest (jsdom, headless) en una sola corrida (`ng test --watch=false`). Cubre los
servicios HTTP, la lógica de roles, el cálculo de totales de factura, utilidades y el pipe.

## Docker

`Dockerfile` multi-etapa: build con `node:22-alpine` y servido estático con
`nginxinc/nginx-unprivileged:1.27-alpine` en el puerto **8080**:

- fallback SPA a `index.html`,
- cache larga para assets con hash, `no-cache` para `index.html` y `config.json`,
- gzip y cabeceras de seguridad.

```
docker build -t sige-frontend .
```

En `docker-compose`, Traefik enruta `/api/*` a los servicios y `/` a
`http://frontend:8080`; nginx solo sirve estáticos y `config.json` se monta/sobre-escribe
en runtime (p. ej. con `config.docker.json`).
