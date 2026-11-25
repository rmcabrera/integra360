'use strict';
/**
 * Crea (o actualiza) el esqueleto comun de cada microservicio: pom.xml, application.properties,
 * clase de aplicacion OpenAPI y test de humo. No toca el codigo de negocio escrito a mano.
 * Uso: node src/scaffold-services.js <raiz-proyecto> [--force]
 */
const fs = require('fs');
const path = require('path');
const { SERVICES } = require('./domains');

const [, , root, flag] = process.argv;
const force = flag === '--force';
const write = (f, s, always = false) => {
  if (fs.existsSync(f) && !force && !always) return;
  fs.mkdirSync(path.dirname(f), { recursive: true });
  fs.writeFileSync(f, s.replace(/\r?\n/g, '\n'), 'utf8');
};

// suscripciones Kafka por servicio (canal -> topico)
const INCOMING = {
  logistica: { 'ventas-facturas': 'sige.ventas.factura.v1' },
  contabilidad: { 'ventas-facturas': 'sige.ventas.factura.v1' }
};
// propiedades propias de cada servicio
const EXTRA = {
  ventas: '\n# ---------------------------------------------------------------- Negocio\nsige.ventas.igv=${IGV_TASA:0.18}\n',
  contabilidad: '\n# ---------------------------------------------------------------- Negocio\n' +
    '# tipo de documento -> codigo de CONTABILIZACION usado por el asiento automatico de ventas\n' +
    'sige.contabilidad.ventas.default=${CONTA_VENTAS_DEFAULT:0001}\nsige.contabilidad.ventas.0001=${CONTA_VENTAS_FACTURA:0001}\n' +
    'sige.contabilidad.ventas.0003=${CONTA_VENTAS_BOLETA:0003}\n'
};
const REST_CLIENTS = { ventas: { maestros: 'http://localhost:8082' } };

for (const [svc, cfg] of Object.entries(SERVICES)) {
  if (!cfg.port) continue;
  const dir = path.join(root, 'backend', 'services', 'ms-' + svc);
  const pkgPath = path.join(dir, 'src', 'main', 'java', 'pe', 'sige', cfg.pkg);
  const hasClients = !!REST_CLIENTS[svc];

  write(path.join(dir, 'pom.xml'), `<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
        <groupId>pe.sige</groupId>
        <artifactId>sige-backend</artifactId>
        <version>1.0.0-SNAPSHOT</version>
        <relativePath>../../pom.xml</relativePath>
    </parent>

    <artifactId>ms-${svc}</artifactId>
    <name>SIGE - ms-${svc} (${cfg.title})</name>

    <dependencies>
        <dependency>
            <groupId>pe.sige</groupId>
            <artifactId>sige-common</artifactId>
        </dependency>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-flyway</artifactId>
        </dependency>
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-database-postgresql</artifactId>
        </dependency>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-jdbc-postgresql</artifactId>
        </dependency>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-oidc</artifactId>
        </dependency>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-smallrye-health</artifactId>
        </dependency>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-micrometer-registry-prometheus</artifactId>
        </dependency>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-opentelemetry</artifactId>
        </dependency>
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-smallrye-fault-tolerance</artifactId>
        </dependency>${hasClients ? `
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-rest-client-jackson</artifactId>
        </dependency>
` : ''}
        <dependency>
            <groupId>io.quarkus</groupId>
            <artifactId>quarkus-junit5</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>io.rest-assured</groupId>
            <artifactId>rest-assured</artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>\${quarkus.platform.group-id}</groupId>
                <artifactId>quarkus-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
            </plugin>
            <plugin>
                <artifactId>maven-surefire-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
`);

  const incoming = Object.entries(INCOMING[svc] || {}).map(([ch, topic]) => `
mp.messaging.incoming.${ch}.connector=smallrye-kafka
mp.messaging.incoming.${ch}.topic=${topic}
mp.messaging.incoming.${ch}.group.id=ms-${svc}
mp.messaging.incoming.${ch}.value.deserializer=org.apache.kafka.common.serialization.StringDeserializer
mp.messaging.incoming.${ch}.auto.offset.reset=earliest
mp.messaging.incoming.${ch}.failure-strategy=dead-letter-queue
mp.messaging.incoming.${ch}.dead-letter-queue.topic=${topic}.dlq.ms-${svc}`).join('\n');
  const clients = Object.entries(REST_CLIENTS[svc] || {}).map(([name, url]) => `
quarkus.rest-client.${name}.url=\${MS_${name.toUpperCase()}_URL:${url}}
quarkus.rest-client.${name}.connect-timeout=2000
quarkus.rest-client.${name}.read-timeout=5000`).join('\n') + (REST_CLIENTS[svc] ? '\norg.eclipse.microprofile.rest.client.propagateHeaders=Authorization' : '');

  write(path.join(dir, 'src', 'main', 'resources', 'application.properties'), `# ============================================================================
# ms-${svc} - ${cfg.title}
# Generado por tools/db-migrator/src/scaffold-services.js (se puede editar)
# Perfiles: dev (Dev Services: PostgreSQL y Kafka automaticos con Docker), test, prod (variables de entorno)
# ============================================================================
quarkus.application.name=ms-${svc}
quarkus.http.port=\${PORT:${cfg.port}}
quarkus.rest.path=/api/${svc}
quarkus.http.cors.enabled=true
quarkus.http.cors.origins=\${CORS_ORIGINS:http://localhost:4200}

# ---------------------------------------------------------------- Base de datos
quarkus.datasource.db-kind=postgresql
%prod.quarkus.datasource.username=\${DB_USER:sige_${svc}}
%prod.quarkus.datasource.password=\${DB_PASSWORD}
%prod.quarkus.datasource.reactive.url=\${DB_REACTIVE_URL:postgresql://localhost:5432/sige}
%prod.quarkus.datasource.jdbc.url=\${DB_JDBC_URL:jdbc:postgresql://localhost:5432/sige}
quarkus.datasource.reactive.max-size=\${DB_POOL_SIZE:20}
# el SQL nativo (secuencias, outbox) resuelve en el esquema del servicio
quarkus.datasource.reactive.additional-properties.search_path=${svc}
# JDBC solo se usa para Flyway; el acceso a datos es 100% reactivo (Vert.x pg client)
quarkus.datasource.jdbc.max-size=2
quarkus.datasource.devservices.image-name=postgres:17-alpine
quarkus.datasource.devservices.reuse=true

quarkus.hibernate-orm.database.default-schema=${svc}
quarkus.hibernate-orm.schema-management.strategy=none
quarkus.hibernate-orm.quote-identifiers.strategy=only-keywords
quarkus.hibernate-orm.jdbc.statement-batch-size=50
%dev.quarkus.hibernate-orm.log.sql=false

quarkus.flyway.migrate-at-start=true
quarkus.flyway.schemas=${svc}
quarkus.flyway.default-schema=${svc}
# Para una BD ya cargada con datos del legado (pgloader) usar FLYWAY_BASELINE=true
quarkus.flyway.baseline-on-migrate=\${FLYWAY_BASELINE:false}
quarkus.flyway.baseline-version=5

# ---------------------------------------------------------------- Kafka
%prod.kafka.bootstrap.servers=\${KAFKA_BOOTSTRAP:localhost:9092}
quarkus.kafka.devservices.provider=kafka-native
mp.messaging.outgoing.outbox.connector=smallrye-kafka
mp.messaging.outgoing.outbox.topic=sige.${svc}.eventos
mp.messaging.outgoing.outbox.value.serializer=org.apache.kafka.common.serialization.StringSerializer
mp.messaging.outgoing.outbox.acks=all
mp.messaging.outgoing.outbox.enable.idempotence=true
sige.outbox.interval=\${OUTBOX_INTERVAL:2s}
${incoming}
${clients}

# ---------------------------------------------------------------- Seguridad (Keycloak / OIDC)
%prod.quarkus.oidc.auth-server-url=\${OIDC_URL:http://localhost:8180/realms/sige}
quarkus.oidc.client-id=sige-backend
quarkus.oidc.application-type=service
quarkus.oidc.roles.role-claim-path=realm_access/roles
%dev.quarkus.oidc.enabled=false
%test.quarkus.oidc.enabled=false
quarkus.keycloak.devservices.enabled=false

quarkus.http.auth.permission.public.paths=/q/*
quarkus.http.auth.permission.public.policy=permit
quarkus.http.auth.permission.read.paths=/api/*
quarkus.http.auth.permission.read.methods=GET,HEAD,OPTIONS
quarkus.http.auth.permission.read.policy=authenticated
quarkus.http.auth.permission.write.paths=/api/*
quarkus.http.auth.permission.write.methods=POST,PUT,PATCH,DELETE
quarkus.http.auth.permission.write.policy=editor
quarkus.http.auth.policy.editor.roles-allowed=admin,${svc}-editor
%dev.quarkus.http.auth.permission.read.policy=permit
%dev.quarkus.http.auth.permission.write.policy=permit
%test.quarkus.http.auth.permission.read.policy=permit
%test.quarkus.http.auth.permission.write.policy=permit

# ---------------------------------------------------------------- Observabilidad
quarkus.smallrye-openapi.info-title=SIGE ms-${svc}
quarkus.smallrye-openapi.info-version=1.0.0
quarkus.swagger-ui.always-include=true
quarkus.otel.enabled=\${OTEL_ENABLED:false}
quarkus.otel.exporter.otlp.endpoint=\${OTEL_ENDPOINT:http://localhost:4317}
quarkus.log.console.json=false
%prod.quarkus.log.console.json=\${LOG_JSON:true}
${EXTRA[svc] || ''}`, true);

  write(path.join(pkgPath, 'Ms' + cfg.pkg.charAt(0).toUpperCase() + cfg.pkg.slice(1) + 'Application.java'), `package pe.sige.${cfg.pkg};

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-${svc}", version = "1.0.0",
        description = "${cfg.title}. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class Ms${cfg.pkg.charAt(0).toUpperCase() + cfg.pkg.slice(1)}Application extends Application {
}
`);

  write(path.join(dir, 'src', 'test', 'java', 'pe', 'sige', cfg.pkg, 'CatalogTest.java'), `package pe.sige.${cfg.pkg};

import static org.junit.jupiter.api.Assertions.assertFalse;

import io.quarkus.test.junit.QuarkusTest;
import jakarta.inject.Inject;
import org.junit.jupiter.api.Test;
import pe.sige.common.catalog.EntityCatalog;

/** Arranca el servicio (Dev Services: PostgreSQL + Kafka), aplica Flyway y valida el catalogo. */
@QuarkusTest
class CatalogTest {

    @Inject
    EntityCatalog catalog;

    @Test
    void catalogoTieneEntidades() {
        assertFalse(catalog.all().isEmpty());
    }
}
`);
}
console.log('scaffold listo');
