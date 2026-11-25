/** Runtime configuration, loaded from /config.json so a single image works in
 *  every environment. The file is mounted/overridden at container runtime. */
export interface AppConfig {
  /** Base URL for the API. Empty string = same origin (gateway routes /api/*). */
  apiBaseUrl: string;
  auth: AuthConfig;
  /** Optional IGV percentage for client-side invoice totals (display only). */
  igvPercent?: number;
}

export interface AuthConfig {
  /** When false the app skips OIDC entirely and allows every action. */
  enabled: boolean;
  /** Keycloak realm authority, e.g. http://localhost:8180/realms/sige */
  authority: string;
  clientId: string;
}

/** Backend services. One lazy feature module maps to each. */
export type Svc =
  | 'seguridad'
  | 'maestros'
  | 'logistica'
  | 'ventas'
  | 'contabilidad'
  | 'finanzas'
  | 'rrhh'
  | 'produccion';

export const DEFAULT_CONFIG: AppConfig = {
  apiBaseUrl: '',
  auth: { enabled: false, authority: '', clientId: 'sige-frontend' },
  igvPercent: 18,
};
