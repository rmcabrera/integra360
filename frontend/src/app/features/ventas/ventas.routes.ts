import { Routes } from '@angular/router';
import { moduleRoutes } from '../common/module-routes';
import { FacturasListComponent } from './facturas/facturas-list.component';
import { FacturaFormComponent } from './facturas/factura-form.component';
import { FacturaDetailComponent } from './facturas/factura-detail.component';

// Hand-written facturas screens first; 'nueva' before ':id' so it is not
// captured as a factura code. Then the generic landing + grid for ventas.
const routes: Routes = moduleRoutes('ventas', 'Ventas', [
  { path: 'facturas', component: FacturasListComponent },
  { path: 'facturas/nueva', component: FacturaFormComponent },
  { path: 'facturas/:id', component: FacturaDetailComponent },
]);

export default routes;
