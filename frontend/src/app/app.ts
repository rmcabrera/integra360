import { ChangeDetectionStrategy, Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { ToastsComponent } from './core/toast/toast.component';
import { LoadingBarComponent } from './core/loading/loading-bar.component';

@Component({
  selector: 'app-root',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [RouterOutlet, ToastsComponent, LoadingBarComponent],
  template: `
    <app-loading-bar />
    <router-outlet />
    <app-toasts />
  `,
})
export class App {}
