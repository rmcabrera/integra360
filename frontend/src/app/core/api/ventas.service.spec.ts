import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { VentasService } from './ventas.service';
import { NuevaFactura } from './models';

describe('VentasService', () => {
  let service: VentasService;
  let http: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [VentasService, provideHttpClient(), provideHttpClientTesting()],
    });
    service = TestBed.inject(VentasService);
    http = TestBed.inject(HttpTestingController);
  });

  afterEach(() => http.verify());

  it('lists facturas with the given filters', () => {
    service.listFacturas({ desde: '2026-01-01', estado: 'E' }, 0, 50).subscribe();
    const req = http.expectOne((r) => r.url === '/api/ventas/v1/facturas');
    expect(req.request.params.get('desde')).toBe('2026-01-01');
    expect(req.request.params.get('estado')).toBe('E');
    req.flush({ items: [], total: 0, page: 0, size: 50 });
  });

  it('posts a new factura', () => {
    const body: NuevaFactura = {
      codiAlma: '01',
      codiTipoDocu: 'FAC',
      serie: 'F001',
      codiClieProv: 'C1',
      fecha: '2026-11-25',
      codiMone: 'S/',
      aplicaIgv: true,
      preciosIncluyenIgv: false,
      items: [],
    };
    service.crearFactura(body).subscribe();
    const req = http.expectOne('/api/ventas/v1/facturas');
    expect(req.request.method).toBe('POST');
    expect(req.request.body).toEqual(body);
    req.flush({ codiFact: 10 });
  });

  it('anula a factura with a motivo', () => {
    service.anular(10, 'error de digitación').subscribe();
    const req = http.expectOne('/api/ventas/v1/facturas/10/anular');
    expect(req.request.method).toBe('POST');
    expect(req.request.body).toEqual({ motivo: 'error de digitación' });
    req.flush({ codiFact: 10, estado: 'A' });
  });
});
