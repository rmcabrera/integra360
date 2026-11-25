import { Injectable, signal } from '@angular/core';
import { AppConfig, DEFAULT_CONFIG } from './app-config';

/** Holds the runtime config. Populated once at startup (see config.providers.ts)
 *  by a plain fetch, before the app bootstraps, so it is always available. */
@Injectable({ providedIn: 'root' })
export class ConfigService {
  private readonly _config = signal<AppConfig>(DEFAULT_CONFIG);

  /** Reactive snapshot of the loaded configuration. */
  readonly config = this._config.asReadonly();

  get apiBaseUrl(): string {
    return this._config().apiBaseUrl ?? '';
  }

  get authEnabled(): boolean {
    return this._config().auth?.enabled === true;
  }

  get igvPercent(): number {
    return this._config().igvPercent ?? 18;
  }

  set(config: AppConfig): void {
    this._config.set({ ...DEFAULT_CONFIG, ...config, auth: { ...DEFAULT_CONFIG.auth, ...config.auth } });
  }
}

/** Fetches config.json with the platform fetch (no HttpClient: runs before DI
 *  interceptors exist). Falls back to defaults so the app still starts. */
export async function loadRuntimeConfig(service: ConfigService): Promise<void> {
  try {
    const res = await fetch('config.json', { cache: 'no-store' });
    if (res.ok) {
      service.set((await res.json()) as AppConfig);
    } else {
      console.warn('[SIGE] config.json not found, using defaults');
    }
  } catch (err) {
    console.warn('[SIGE] could not load config.json, using defaults', err);
  }
}
