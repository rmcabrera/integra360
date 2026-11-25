import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { LoadingService } from './loading.service';

@Component({
  selector: 'app-loading-bar',
  changeDetection: ChangeDetectionStrategy.OnPush,
  template: `
    @if (loading.loading()) {
      <div class="loading-bar" role="progressbar" aria-label="Cargando" aria-busy="true">
        <div class="loading-bar-inner"></div>
      </div>
    }
  `,
  styles: [
    `
      .loading-bar {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: transparent;
        overflow: hidden;
        z-index: 300;
      }
      .loading-bar-inner {
        height: 100%;
        width: 40%;
        background: var(--c-primary);
        animation: indeterminate 1.1s infinite ease-in-out;
      }
      @keyframes indeterminate {
        0% {
          transform: translateX(-100%);
        }
        100% {
          transform: translateX(350%);
        }
      }
    `,
  ],
})
export class LoadingBarComponent {
  readonly loading = inject(LoadingService);
}
