import { MenuNode } from './menu.model';

/**
 * Sidebar menu, derived from the legacy PowerBuilder main menu
 * (docs/legado/menu-powerbuilder.txt). Top-level sections map to modules:
 *   Maestros -> maestros (+ seguridad for "Maestros Internos")
 *   Personal -> rrhh, Logistica -> logistica, Operaciones/Facturacion -> ventas,
 *   Contabilidad -> contabilidad, Finanzas -> finanzas, Gerencial -> placeholder.
 *
 * Maintenance items that map obviously to a table link to the generic grid
 * (/<module>/tablas/<entity>); items with a dedicated screen link to it; the
 * long tail of legacy reports/screens still "en migracion" is reachable through
 * each module's landing page, which lists every table of the service live from
 * GET /api/<svc>/v1/data. This keeps the file maintainable instead of hard-coding
 * ~600 legacy entries. Role filtering of write actions happens in the grid, not
 * here: every menu entry is visible for read.
 */
export const MENU: MenuNode[] = [
  {
    label: 'Inicio',
    route: '/inicio',
  },
  {
    label: 'Maestros',
    svc: 'maestros',
    children: [
      { label: 'Todas las tablas', route: '/maestros', svc: 'maestros' },
      { label: 'Monedas', route: '/maestros/tablas/monedas', svc: 'maestros' },
      { label: 'Tipo de Cambio', route: '/maestros/tablas/tipo_cambio_a_dolar', svc: 'maestros' },
      { label: 'Clientes/Proveedores', route: '/maestros/tablas/cliente_proveedor', svc: 'maestros' },
      { label: 'Unidades de Medida', route: '/maestros/tablas/unidad_medida', svc: 'maestros' },
      { label: 'Feriados', route: '/maestros/tablas/feriados', svc: 'maestros' },
      {
        label: 'Maestros Internos',
        svc: 'seguridad',
        children: [
          { label: 'Usuarios', route: '/seguridad/tablas/usuarios', svc: 'seguridad' },
          { label: 'Datos de la Empresa', route: '/seguridad/tablas/empresa', svc: 'seguridad' },
          { label: 'Seguridad (todas)', route: '/seguridad', svc: 'seguridad' },
        ],
      },
    ],
  },
  {
    label: 'Logística',
    svc: 'logistica',
    children: [
      { label: 'Todas las tablas', route: '/logistica', svc: 'logistica' },
      { label: 'Registro de Productos', route: '/logistica/tablas/productos', svc: 'logistica' },
      { label: 'Almacenes', route: '/logistica/tablas/almacen', svc: 'logistica' },
      { label: 'Familia de Productos', route: '/logistica/tablas/familia_producto', svc: 'logistica' },
      { label: 'Kardex', route: '/logistica/kardex', svc: 'logistica' },
    ],
  },
  {
    label: 'Operaciones',
    svc: 'ventas',
    children: [
      { label: 'Todas las tablas', route: '/ventas', svc: 'ventas' },
      { label: 'Captación de Cliente', route: '/ventas/tablas/captacion', svc: 'ventas' },
      { label: 'Rutas', route: '/ventas/tablas/ruta', svc: 'ventas' },
    ],
  },
  {
    label: 'Facturación',
    svc: 'ventas',
    children: [
      { label: 'Registro de Facturación', route: '/ventas/facturas', svc: 'ventas' },
      { label: 'Nueva factura', route: '/ventas/facturas/nueva', svc: 'ventas' },
      { label: 'Anular Fact/Boleta/GR', route: '/ventas/facturas', svc: 'ventas' },
    ],
  },
  {
    label: 'Personal',
    svc: 'rrhh',
    children: [
      { label: 'Todas las tablas', route: '/rrhh', svc: 'rrhh' },
      { label: 'Registro de Personal', route: '/rrhh/tablas/personal', svc: 'rrhh' },
      { label: 'Cargos', route: '/rrhh/tablas/cargos', svc: 'rrhh' },
      { label: 'Áreas de Trabajo', route: '/rrhh/tablas/areas', svc: 'rrhh' },
    ],
  },
  {
    label: 'Contabilidad',
    svc: 'contabilidad',
    children: [
      { label: 'Todas las tablas', route: '/contabilidad', svc: 'contabilidad' },
      { label: 'Plan Contable', route: '/contabilidad/tablas/cuentas_contable', svc: 'contabilidad' },
      { label: 'Tipos de Documento', route: '/contabilidad/tablas/tipo_comprobante', svc: 'contabilidad' },
    ],
  },
  {
    label: 'Finanzas',
    svc: 'finanzas',
    children: [
      { label: 'Todas las tablas', route: '/finanzas', svc: 'finanzas' },
      { label: 'Bancos / Entidades Financieras', route: '/finanzas/tablas/bancos', svc: 'finanzas' },
    ],
  },
  {
    label: 'Producción',
    svc: 'produccion',
    children: [{ label: 'Todas las tablas', route: '/produccion', svc: 'produccion' }],
  },
  {
    label: 'Gerencial',
    svc: 'gerencial',
    children: [{ label: 'Reportes gerenciales', route: '/gerencial', svc: 'gerencial' }],
  },
];
