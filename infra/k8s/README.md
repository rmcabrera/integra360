# SIGE en Kubernetes (Kustomize)

Despliegue de SIGE (8 microservicios Quarkus + frontend Angular) sobre Kubernetes.
La infraestructura con estado (PostgreSQL, Kafka, Keycloak) se gestiona con
operadores. Equivale al `infra/docker/docker-compose.yml` del entorno local.

## Estructura

```
infra/k8s/
  base/                      # Namespace, ConfigMap, 8 microservicios, frontend,
                             # Ingress, NetworkPolicies (Deployment+Service+HPA+PDB)
    services/ms-<svc>.yaml
    secret-sige-db.example.yaml   # PLANTILLA (no se aplica ni se referencia)
  components/servicemonitor/ # ServiceMonitor de Prometheus (opcional)
  overlays/
    dev/                     # 1 replica, recursos pequenos, tag :develop
    prod/                    # 3 replicas, recursos mayores, :v1.0.0, ServiceMonitor
  platform/                  # CRs de operadores: CloudNativePG, Strimzi, Keycloak
```

Los microservicios leen su configuracion de la ConfigMap `sige-config` (valores no
secretos) y del Secret `sige-db` (`DB_PASSWORD`). Cada uno fija su `DB_USER`
(`sige_<servicio>`) en su Deployment. El Ingress enruta `/api/<servicio>` a cada
`ms-<servicio>`, `/realms` y `/resources` a Keycloak y el resto al frontend.

> El `frontend/Dockerfile` (imagen nginx unprivileged en 8080) lo provee el
> repositorio; aqui solo se referencia la imagen `ghcr.io/OWNER/sige-frontend`.

## Requisitos previos: operadores

Instale (una vez por cluster) los operadores. Sustituya versiones por las vigentes.

```bash
# Ingress (ingress-nginx)
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx \
  -n ingress-nginx --create-namespace

# TLS automatico (cert-manager) para el Secret sige-tls del Ingress
helm upgrade --install cert-manager jetstack/cert-manager \
  -n cert-manager --create-namespace --set crds.enabled=true

# PostgreSQL (CloudNativePG) -> namespace cnpg-system
helm upgrade --install cnpg cnpg/cloudnative-pg \
  -n cnpg-system --create-namespace

# Kafka (Strimzi) -> namespace strimzi, observando todos los namespaces
helm upgrade --install strimzi strimzi/strimzi-kafka-operator \
  -n strimzi --create-namespace --set watchAnyNamespace=true

# Keycloak operator (CRDs + operador) -> ajuste KC_VER
KC_VER=26.4.0
kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/${KC_VER}/kubernetes/keycloaks.k8s.keycloak.org-v1.yml
kubectl apply -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/${KC_VER}/kubernetes/keycloakrealmimports.k8s.keycloak.org-v1.yml
kubectl apply -n sige -f https://raw.githubusercontent.com/keycloak/keycloak-k8s-resources/${KC_VER}/kubernetes/kubernetes.yml

# (Opcional) ServiceMonitor del overlay prod: Prometheus Operator
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -n monitoring --create-namespace
```

Los nombres de namespace de los operadores (`ingress-nginx`, `cnpg-system`,
`strimzi`) deben coincidir con los `namespaceSelector` de
`base/networkpolicy.yaml`. En Kubernetes >= 1.21 la etiqueta
`kubernetes.io/metadata.name` la pone el propio cluster en cada namespace.

## Orden de aplicacion

```bash
# 1) Namespace
kubectl create namespace sige

# 2) Secretos (NO van en git)
kubectl -n sige create secret generic sige-db \
  --from-literal=DB_PASSWORD='<clave-compartida-de-los-roles-sige_*>'
kubectl -n sige create secret generic sige-keycloak-db \
  --from-literal=username='keycloak' --from-literal=password='<clave-bd-keycloak>'
# sige-tls: lo genera cert-manager (Certificate) o se crea a mano:
kubectl -n sige create secret tls sige-tls --cert=tls.crt --key=tls.key
# (si usa backups de CNPG) credenciales del object storage:
kubectl -n sige create secret generic sige-backup-s3 \
  --from-literal=ACCESS_KEY_ID='...' --from-literal=ACCESS_SECRET_KEY='...'

# 3) Plataforma (BD, Kafka, Keycloak) y espere a que este lista
kubectl apply -k infra/k8s/platform
kubectl -n sige wait --for=condition=Ready cluster/sige-db-cluster --timeout=600s
kubectl -n sige wait --for=condition=Ready kafka/sige-kafka --timeout=600s

# 4) Aplicacion (elija overlay). Reemplace antes 'OWNER' por su organizacion GHCR.
kubectl apply -k infra/k8s/overlays/dev     # o .../prod
```

La clave de `sige-db` debe ser la misma que la de los roles `sige_*` creados por
`postInitSQL` del `Cluster` CloudNativePG (marcador `CHANGE-ME`). En produccion
gestionela sin texto plano (ver `platform/cloudnativepg-cluster.yaml`,
`managed.roles` + `passwordSecret`, o External Secrets).

Keycloak necesita su propia base `keycloak` en el cluster PostgreSQL (distinta de
`sige`) y la importacion del realm inline (ver `platform/keycloak.yaml`; pegue
`infra/docker/keycloak/sige-realm.json` convertido a YAML).

## Secretos

Ningun secreto se versiona. `base/secret-sige-db.example.yaml` es solo plantilla y
**no** esta en `kustomization.yaml`. Opciones:

- `kubectl create secret ...` (arriba).
- **External Secrets Operator** (recomendado en la nube): el `ExternalSecret`
  sincroniza `sige-db` desde AWS Secrets Manager / Azure Key Vault / GCP Secret
  Manager / Vault (ejemplo comentado en el archivo de plantilla).

## Notas

- **Sondas del kubelet y NetworkPolicy**: con un `default-deny-ingress` algunos CNI
  bloquean las sondas HTTP que vienen del nodo. Calico y Cilium suelen permitirlas;
  si sus pods fallan readiness, agregue una excepcion para el rango del host.
- **dev vs prod en plataforma**: `platform/` viene dimensionado para prod (3
  instancias PG, 3 nodos Kafka, factores de replicacion 3). Para un cluster de
  desarrollo baje `instances`/`replicas` a 1 y los factores de replicacion y
  `min.insync.replicas` a 1.

## Validacion local

```bash
kubectl kustomize infra/k8s/overlays/dev   > /dev/null
kubectl kustomize infra/k8s/overlays/prod  > /dev/null
kubectl kustomize infra/k8s/platform       > /dev/null
```

El workflow `.github/workflows/ci.yml` (job `k8s-manifiestos`) ejecuta esto en CI.

## Promocion a una nube gestionada

La idea: **sustituir los operadores con estado por servicios gestionados** y dejar
solo los microservicios + frontend + Ingress en el cluster. En la practica:

1. No aplique `platform/` (o quite CNPG/Strimzi/Keycloak).
2. Repunte `base/configmap.yaml` (`DB_*`, `KAFKA_BOOTSTRAP`, `OIDC_URL`) al
   endpoint gestionado y cargue los secretos con External Secrets.
3. Ejecute la migracion de datos (`database/migracion-datos/`) contra la BD gestionada.

| Nube | Cluster | PostgreSQL | Kafka | Secretos |
|---|---|---|---|---|
| **AWS** | EKS (ALB o ingress-nginx) | RDS/Aurora PostgreSQL (`DB_*` al endpoint RDS) | MSK (`KAFKA_BOOTSTRAP` al bootstrap MSK; IAM o SASL) | Secrets Manager + External Secrets (IRSA) |
| **Azure** | AKS (Application Gateway o ingress-nginx) | Azure Database for PostgreSQL Flexible Server | Event Hubs con endpoint Kafka (`KAFKA_BOOTSTRAP` al namespace Event Hubs, SASL) | Key Vault + External Secrets (Workload Identity) |
| **GCP** | GKE (Gateway o ingress-nginx) | Cloud SQL para PostgreSQL (Auth Proxy o IP privada) | Managed Service for Apache Kafka | Secret Manager + External Secrets (Workload Identity) |

Keycloak gestionado: mantenga el operador en el cluster, o use un IdP gestionado
compatible OIDC y apunte `OIDC_URL` a su emisor. Ajuste el `host` del Ingress
(`sige.example.com`) y el `CORS_ORIGINS` de `sige-config` al dominio real.
