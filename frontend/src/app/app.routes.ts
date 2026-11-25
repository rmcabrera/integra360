import { Routes } from '@angular/router';
import { ShellComponent } from './core/layout/shell.component';
import { authGuard } from './core/auth/auth.guard';

export const routes: Routes = [
  {
    path: '',
    component: ShellComponent,
    canActivate: [authGuard],
    children: [
      { path: '', pathMatch: 'full', redirectTo: 'inicio' },
      {
        path: 'inicio',
        loadComponent: () => import('./features/home/home.component').then((m) => m.HomeComponent),
      },
      {
        path: 'seguridad',
        loadChildren: () => import('./features/seguridad/seguridad.routes'),
      },
      {
        path: 'maestros',
        loadChildren: () => import('./features/maestros/maestros.routes'),
      },
      {
        path: 'logistica',
        loadChildren: () => import('./features/logistica/logistica.routes'),
      },
      {
        path: 'ventas',
        loadChildren: () => import('./features/ventas/ventas.routes'),
      },
      {
        path: 'contabilidad',
        loadChildren: () => import('./features/contabilidad/contabilidad.routes'),
      },
      {
        path: 'finanzas',
        loadChildren: () => import('./features/finanzas/finanzas.routes'),
      },
      {
        path: 'rrhh',
        loadChildren: () => import('./features/rrhh/rrhh.routes'),
      },
      {
        path: 'produccion',
        loadChildren: () => import('./features/produccion/produccion.routes'),
      },
      {
        path: 'gerencial',
        loadComponent: () =>
          import('./features/gerencial/gerencial.component').then((m) => m.GerencialComponent),
      },
      { path: '**', redirectTo: 'inicio' },
    ],
  },
];
