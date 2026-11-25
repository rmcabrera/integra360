import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { ConfigService } from '../config/config.service';
import { Svc } from '../config/app-config';
import { EntityMeta, EntityRecord, Page, TableInfo } from './models';

export interface ListQuery {
  page?: number;
  size?: number;
  sort?: string; // '<field>,asc' | '<field>,desc'
  q?: string;
  filters?: Record<string, string>; // becomes f.<field>=<value>
}

/** Generic metadata-driven client for the uniform /v1/data endpoints.
 *  This is the data layer behind the DataWindow replacement (shared grid). */
@Injectable({ providedIn: 'root' })
export class DataService {
  private readonly http = inject(HttpClient);
  private readonly config = inject(ConfigService);

  private base(svc: Svc): string {
    return `${this.config.apiBaseUrl}/api/${svc}/v1/data`;
  }

  /** Tables of a service. */
  listTables(svc: Svc): Observable<TableInfo[]> {
    return this.http.get<TableInfo[]>(this.base(svc));
  }

  /** Field metadata for an entity. */
  meta(svc: Svc, entity: string): Observable<EntityMeta> {
    return this.http.get<EntityMeta>(`${this.base(svc)}/${entity}/meta`);
  }

  /** Paged, sorted, filtered list. */
  list(svc: Svc, entity: string, query: ListQuery = {}): Observable<Page<EntityRecord>> {
    let params = new HttpParams()
      .set('page', String(query.page ?? 0))
      .set('size', String(query.size ?? 50));
    if (query.sort) params = params.set('sort', query.sort);
    if (query.q) params = params.set('q', query.q);
    for (const [field, value] of Object.entries(query.filters ?? {})) {
      if (value !== '' && value != null) params = params.set(`f.${field}`, value);
    }
    return this.http.get<Page<EntityRecord>>(`${this.base(svc)}/${entity}`, { params });
  }

  /** Single record by composite key. */
  getByKey(svc: Svc, entity: string, key: Record<string, unknown>): Observable<EntityRecord> {
    return this.http.get<EntityRecord>(`${this.base(svc)}/${entity}/key`, {
      params: this.keyParams(key),
    });
  }

  create(svc: Svc, entity: string, record: EntityRecord): Observable<EntityRecord> {
    return this.http.post<EntityRecord>(`${this.base(svc)}/${entity}`, record);
  }

  /** Full-record update including rowVersion (optimistic lock). */
  update(svc: Svc, entity: string, record: EntityRecord): Observable<EntityRecord> {
    return this.http.put<EntityRecord>(`${this.base(svc)}/${entity}`, record);
  }

  remove(svc: Svc, entity: string, key: Record<string, unknown>): Observable<void> {
    return this.http.delete<void>(`${this.base(svc)}/${entity}/key`, {
      params: this.keyParams(key),
    });
  }

  private keyParams(key: Record<string, unknown>): HttpParams {
    let params = new HttpParams();
    for (const [k, v] of Object.entries(key)) {
      if (v != null) params = params.set(k, String(v));
    }
    return params;
  }
}
