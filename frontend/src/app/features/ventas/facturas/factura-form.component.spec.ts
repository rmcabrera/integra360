import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { provideHttpClientTesting } from '@angular/common/http/testing';
import { provideRouter } from '@angular/router';
import { FacturaFormComponent } from './factura-form.component';

/** Totals are computed on the component class; the template (which uses the
 *  es-PE currency pipe) is not rendered here, so no change detection runs. */
describe('FacturaFormComponent totals', () => {
  function create(): FacturaFormComponent {
    TestBed.configureTestingModule({
      imports: [FacturaFormComponent],
      providers: [provideHttpClient(), provideHttpClientTesting(), provideRouter([])],
    });
    return TestBed.createComponent(FacturaFormComponent).componentInstance;
  }

  const item = {
    codiProd: 'P1',
    descripcion: 'Producto',
    codiUnidMedi: 'UN',
    cantidad: 2,
    precioUnitario: 100,
    descuento: 0,
    oferta: false,
  };

  it('adds IGV when prices do not include it', () => {
    const c = create();
    c.items.set([item]);
    const t = c.totals();
    expect(t.valor).toBeCloseTo(200);
    expect(t.igv).toBeCloseTo(36);
    expect(t.total).toBeCloseTo(236);
  });

  it('extracts IGV when prices already include it', () => {
    const c = create();
    c.items.set([item]);
    c.setHeader('preciosIncluyenIgv', true);
    const t = c.totals();
    expect(t.total).toBeCloseTo(200);
    expect(t.valor).toBeCloseTo(169.49, 1);
    expect(t.igv).toBeCloseTo(30.51, 1);
  });

  it('applies no IGV when aplicaIgv is false', () => {
    const c = create();
    c.items.set([item]);
    c.setHeader('aplicaIgv', false);
    const t = c.totals();
    expect(t).toEqual({ valor: 200, igv: 0, total: 200 });
  });

  it('subtracts the per-line discount', () => {
    const c = create();
    c.items.set([{ ...item, descuento: 50 }]);
    c.setHeader('aplicaIgv', false);
    expect(c.totals().total).toBeCloseTo(150);
  });
});
