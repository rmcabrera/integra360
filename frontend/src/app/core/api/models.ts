/** Typed models mirroring the Quarkus backend contract. */

/** Java type names the backend reports in field metadata. */
export type JavaType =
  | 'String'
  | 'Integer'
  | 'Long'
  | 'Short'
  | 'BigDecimal'
  | 'Boolean'
  | 'Double'
  | 'Float'
  | 'LocalDate'
  | 'LocalDateTime'
  | 'LocalTime'
  | 'OffsetDateTime'
  | 'UUID'
  | 'byte[]';

/** One entry of GET /api/<svc>/v1/data */
export interface TableInfo {
  name: string;
  label: string;
  legacyName: string;
  fields: number;
}

/** GET /api/<svc>/v1/data/<entity>/meta */
export interface EntityMeta {
  name: string;
  legacyName: string;
  label: string;
  fields: FieldMeta[];
}

export interface FieldMeta {
  field: string;
  column: string;
  type: JavaType;
  length?: number;
  required: boolean;
  id: boolean;
  generated: boolean;
  label: string;
}

/** Arbitrary entity record plus audit fields. */
export interface EntityRecord {
  [key: string]: unknown;
  auditCreatedAt?: string;
  auditUpdatedAt?: string;
  auditUser?: string;
  rowVersion?: number;
}

/** GET /api/<svc>/v1/data/<entity> paged result. */
export interface Page<T> {
  items: T[];
  total: number;
  page: number;
  size: number;
}

/** RFC 9457 problem+json. */
export interface ProblemDetail {
  title?: string;
  status?: number;
  detail?: string;
  code?: string;
  [key: string]: unknown;
}

/* ---- Ventas ---- */
export interface Factura {
  codiFact: number | string;
  serFact?: string;
  nroFact?: string;
  fechFact?: string;
  codiClieProv?: string;
  codiMone?: string;
  valoFact?: number;
  igvFact?: number;
  totaFact?: number;
  estado?: 'E' | 'A';
  [key: string]: unknown;
}

export interface FacturaDetalleRow {
  codiFact: number | string;
  codiDeta: number | string;
  codiProd?: string;
  descItem?: string;
  codiUnidMedi?: string;
  cantItem?: number;
  precItem?: number;
  impoItem?: number;
  igv?: number;
  [key: string]: unknown;
}

export interface FacturaDetalle {
  cabecera: Factura;
  detalle: FacturaDetalleRow[];
}

export interface FacturaListFilters {
  desde?: string;
  hasta?: string;
  cliente?: string;
  almacen?: string;
  serie?: string;
  estado?: string;
}

export interface NuevaFacturaItem {
  codiProd: string;
  descripcion: string;
  codiUnidMedi: string;
  cantidad: number;
  precioUnitario: number;
  descuento?: number;
  oferta: boolean;
}

export interface NuevaFactura {
  codiAlma: string;
  codiTipoDocu: string;
  serie: string;
  codiClieProv: string;
  fecha: string;
  vencimiento?: string;
  codiMone: string;
  tipoCambio?: number;
  codiTipoPago?: string;
  aplicaIgv: boolean;
  preciosIncluyenIgv: boolean;
  ordenCompra?: string;
  vendedor?: string;
  items: NuevaFacturaItem[];
}

/* ---- Logistica ---- */
export interface Producto {
  codiProd: string;
  descProd?: string;
  codiUnidMedi?: string;
  stock?: number;
  precProm?: number;
  [key: string]: unknown;
}

export interface StockAlmacen {
  codiAlma: string;
  codiProd: string;
  stockAlma?: number;
  precPromAlma?: number;
  [key: string]: unknown;
}

export interface KardexRow {
  codiKard: number | string;
  fechTran?: string;
  iO?: string;
  cantIngr?: number;
  cantSali?: number;
  cantSaldo?: number;
  precProm?: number;
  valoIngr?: number;
  valoSali?: number;
  valoSaldo?: number;
  codiAlma?: string;
  concepto?: string;
  nroSeri?: string;
  nroDocu?: string;
  [key: string]: unknown;
}
