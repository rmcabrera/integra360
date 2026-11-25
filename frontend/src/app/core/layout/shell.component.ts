import { ChangeDetectionStrategy, Component, inject, signal } from '@angular/core';
import { toSignal } from '@angular/core/rxjs-interop';
import { NavigationEnd, Router, RouterLink, RouterLinkActive, RouterOutlet } from '@angular/router';
import { filter, map, startWith } from 'rxjs';
import { AuthService } from '../auth/auth.service';
import { MENU } from './menu';
import { MenuNode } from './menu.model';

interface Crumb {
  label: string;
  url: string;
}

@Component({
  selector: 'app-shell',
  changeDetection: ChangeDetectionStrategy.OnPush,
  imports: [RouterOutlet, RouterLink, RouterLinkActive],
  templateUrl: './shell.component.html',
  styleUrl: './shell.component.scss',
})
export class ShellComponent {
  private readonly router = inject(Router);
  readonly auth = inject(AuthService);

  readonly menu = MENU;
  readonly sidebarOpen = signal(true);
  readonly theme = signal<'light' | 'dark'>(readInitialTheme());

  /** Breadcrumb derived from the current URL. */
  readonly crumbs = toSignal(
    this.router.events.pipe(
      filter((e): e is NavigationEnd => e instanceof NavigationEnd),
      map((e) => e.urlAfterRedirects),
      startWith(this.router.url),
      map((url) => this.buildCrumbs(url)),
    ),
    { initialValue: [] as Crumb[] },
  );

  constructor() {
    this.applyTheme(this.theme());
  }

  toggleSidebar(): void {
    this.sidebarOpen.update((v) => !v);
  }

  toggleTheme(): void {
    const next = this.theme() === 'light' ? 'dark' : 'light';
    this.theme.set(next);
    this.applyTheme(next);
  }

  logout(): void {
    this.auth.logout();
  }

  trackNode(_: number, node: MenuNode): string {
    return node.route ?? node.label;
  }

  private applyTheme(theme: 'light' | 'dark'): void {
    if (typeof document !== 'undefined') {
      document.documentElement.setAttribute('data-theme', theme);
    }
    try {
      localStorage.setItem('sige-theme', theme);
    } catch {
      /* storage may be unavailable */
    }
  }

  private buildCrumbs(url: string): Crumb[] {
    const clean = url.split('?')[0].split('#')[0];
    const segments = clean.split('/').filter(Boolean);
    const crumbs: Crumb[] = [{ label: 'Inicio', url: '/inicio' }];
    let acc = '';
    for (const seg of segments) {
      acc += '/' + seg;
      crumbs.push({ label: humanize(decodeURIComponent(seg)), url: acc });
    }
    return crumbs;
  }
}

function readInitialTheme(): 'light' | 'dark' {
  try {
    const stored = localStorage.getItem('sige-theme');
    if (stored === 'light' || stored === 'dark') return stored;
  } catch {
    /* ignore */
  }
  return 'light';
}

function humanize(segment: string): string {
  const text = segment.replace(/[_-]+/g, ' ');
  return text.charAt(0).toUpperCase() + text.slice(1);
}
