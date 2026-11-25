import { Routes } from '@angular/router';
import { Svc } from '../../core/config/app-config';
import { ModuleLandingComponent } from './module-landing.component';
import { EntityGridComponent } from './entity-grid.component';

/** Standard routes shared by every module: a landing page and the generic grid. */
export function moduleRoutes(svc: Svc, title: string, extra: Routes = []): Routes {
  return [
    ...extra,
    { path: '', component: ModuleLandingComponent, data: { svc, title } },
    { path: 'tablas/:entity', component: EntityGridComponent, data: { svc } },
  ];
}
