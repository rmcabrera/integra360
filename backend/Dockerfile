# Imagen comun para todos los microservicios Quarkus (JVM).
#   docker build -f backend/Dockerfile --build-arg SERVICE=ms-ventas -t sige/ms-ventas backend
# Para imagen nativa (GraalVM/Mandrel) ver docs/despliegue.md.

ARG SERVICE=ms-maestros

FROM maven:3.9-eclipse-temurin-21 AS build
ARG SERVICE
WORKDIR /src
# cache de dependencias: primero solo los pom
COPY pom.xml .
COPY libs/sige-common/pom.xml libs/sige-common/pom.xml
COPY services/ms-seguridad/pom.xml services/ms-seguridad/pom.xml
COPY services/ms-maestros/pom.xml services/ms-maestros/pom.xml
COPY services/ms-logistica/pom.xml services/ms-logistica/pom.xml
COPY services/ms-ventas/pom.xml services/ms-ventas/pom.xml
COPY services/ms-contabilidad/pom.xml services/ms-contabilidad/pom.xml
COPY services/ms-finanzas/pom.xml services/ms-finanzas/pom.xml
COPY services/ms-rrhh/pom.xml services/ms-rrhh/pom.xml
COPY services/ms-produccion/pom.xml services/ms-produccion/pom.xml
RUN --mount=type=cache,target=/root/.m2 mvn -B -q -pl services/${SERVICE} -am dependency:go-offline -DskipTests || true
COPY libs libs
COPY services services
RUN --mount=type=cache,target=/root/.m2 mvn -B -q -pl services/${SERVICE} -am package -DskipTests

FROM registry.access.redhat.com/ubi9/openjdk-21-runtime:1.23
ARG SERVICE
ENV LANGUAGE='es_PE:es' \
    JAVA_OPTS_APPEND="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager -XX:MaxRAMPercentage=75" \
    JAVA_APP_JAR="/deployments/quarkus-run.jar"
COPY --from=build --chown=185 /src/services/${SERVICE}/target/quarkus-app/lib/ /deployments/lib/
COPY --from=build --chown=185 /src/services/${SERVICE}/target/quarkus-app/*.jar /deployments/
COPY --from=build --chown=185 /src/services/${SERVICE}/target/quarkus-app/app/ /deployments/app/
COPY --from=build --chown=185 /src/services/${SERVICE}/target/quarkus-app/quarkus/ /deployments/quarkus/
USER 185
EXPOSE 8080
ENTRYPOINT [ "/opt/jboss/container/java/run/run-java.sh" ]
