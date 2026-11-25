import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { ConfigService } from '../config/config.service';
import { Factura, FacturaDetalle, FacturaListFilters, NuevaFactura, Page } from './models';

@Injectable({ providedIn: 'root' })
export class VentasService {
  private readonly http = inject(HttpClient);
  private readonly config = inject(ConfigService);

  private get base(): string {
    return `${this.config.apiBaseUrl}/api/ventas/v1`;
  }

  listFacturas(
    filters: FacturaListFilters,
    page = 0,
    size = 50,
  ): Observable<Page<Factura>> {
    let params = new HttpParams().set('page', String(page)).set('size', String(size));
    for (const [k, v] of Object.entries(filters)) {
      if (v !== '' && v != null) params = params.set(k, v);
    }
    return this.http.get<Page<Factura>>(`${this.base}/facturas`, { params });
  }

  getFactura(codiFact: number | string): Observable<FacturaDetalle> {
    return this.http.get<FacturaDetalle>(`${this.base}/facturas/${codiFact}`);
  }

  crearFactura(body: NuevaFactura): Observable<Factura> {
    return this.http.post<Factura>(`${this.base}/facturas`, body);
  }

  anular(codiFact: number | string, motivo: string): Observable<Factura> {
    return this.http.post<Factura>(`${this.base}/facturas/${codiFact}/anular`, { motivo });
  }
}
