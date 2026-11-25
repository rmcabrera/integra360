import { Routes } from '@angular/router';
import { moduleRoutes } from '../common/module-routes';
import { KardexComponent } from './kardex/kardex.component';

const routes: Routes = moduleRoutes('logistica', 'Logística', [
  { path: 'kardex', component: KardexComponent },
]);

export default routes;
