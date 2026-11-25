import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { toSignal } from '@angular/core/rxjs-interop';
import { ActivatedRoute } from '@angular/router';
import { map } from 'rxjs';
import { DataGridComponent } from '../../shared/data-grid/data-grid.component';
import { Svc } from '../../core/config/app-config';

/** Route host for /<module>/tablas/:entity. Feeds the shared grid the service
 *  (from route data) and the entity (from the route parameter). */
@Component({
  selector: 'app-entity-grid',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [DataGridComponent],
  template: `
    @if (entity(); as e) {
      <app-data-grid [svc]="svc" [entity]="e" />
    }
  `,
})
export class EntityGridComponent {
  private readonly route = inject(ActivatedRoute);

  readonly svc = this.route.snapshot.data['svc'] as Svc;
  readonly entity = toSignal(
    this.route.paramMap.pipe(map((p) => p.get('entity') ?? '')),
    { initialValue: this.route.snapshot.paramMap.get('entity') ?? '' },
  );
}
