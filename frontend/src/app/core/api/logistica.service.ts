import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { ConfigService } from '../config/config.service';
import { KardexRow, Page, Producto, StockAlmacen } from './models';

export interface KardexQuery {
  producto: string;
  periodo: string | number;
  almacen?: string;
}

@Injectable({ providedIn: 'root' })
export class LogisticaService {
  private readonly http = inject(HttpClient);
  private readonly config = inject(ConfigService);

  private get base(): string {
    return `${this.config.apiBaseUrl}/api/logistica/v1`;
  }

  buscarProductos(q: string, page = 0, size = 20): Observable<Page<Producto>> {
    const params = new HttpParams()
      .set('q', q ?? '')
      .set('page', String(page))
      .set('size', String(size));
    return this.http.get<Page<Producto>>(`${this.base}/productos`, { params });
  }

  stock(codiProd: string): Observable<StockAlmacen[]> {
    return this.http.get<StockAlmacen[]>(`${this.base}/productos/${codiProd}/stock`);
  }

  kardex(query: KardexQuery): Observable<KardexRow[]> {
    let params = new HttpParams()
      .set('producto', query.producto)
      .set('periodo', String(query.periodo));
    if (query.almacen) params = params.set('almacen', query.almacen);
    return this.http.get<KardexRow[]>(`${this.base}/kardex`, { params });
  }
}
