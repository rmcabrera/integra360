import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { DataService } from './data.service';
import { Page, EntityRecord } from './models';

describe('DataService', () => {
  let service: DataService;
  let http: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [DataService, provideHttpClient(), provideHttpClientTesting()],
    });
    service = TestBed.inject(DataService);
    http = TestBed.inject(HttpTestingController);
  });

  afterEach(() => http.verify());

  it('lists tables of a service', () => {
    service.listTables('maestros').subscribe();
    const req = http.expectOne('/api/maestros/v1/data');
    expect(req.request.method).toBe('GET');
    req.flush([]);
  });

  it('builds paged/sorted/filtered list params including LIKE filters', () => {
    service
      .list('logistica', 'productos', {
        page: 2,
        size: 25,
        sort: 'descProd,asc',
        q: 'urea',
        filters: { descProd: '*urea*', codiProd: '' },
      })
      .subscribe();
    const req = http.expectOne((r) => r.url === '/api/logistica/v1/data/productos');
    const p = req.request.params;
    expect(p.get('page')).toBe('2');
    expect(p.get('size')).toBe('25');
    expect(p.get('sort')).toBe('descProd,asc');
    expect(p.get('q')).toBe('urea');
    expect(p.get('f.descProd')).toBe('*urea*');
    expect(p.has('f.codiProd')).toBe(false); // empty filters are dropped
    req.flush({ items: [], total: 0, page: 2, size: 25 } as Page<EntityRecord>);
  });

  it('updates via PUT including the full record', () => {
    const record = { codiMone: '01', descMone: 'Soles', rowVersion: 3 };
    service.update('maestros', 'monedas', record).subscribe();
    const req = http.expectOne('/api/maestros/v1/data/monedas');
    expect(req.request.method).toBe('PUT');
    expect(req.request.body).toEqual(record);
    req.flush(record);
  });

  it('deletes by key', () => {
    service.remove('maestros', 'monedas', { codiMone: '01' }).subscribe();
    const req = http.expectOne((r) => r.url === '/api/maestros/v1/data/monedas/key');
    expect(req.request.method).toBe('DELETE');
    expect(req.request.params.get('codiMone')).toBe('01');
    req.flush(null);
  });
});
