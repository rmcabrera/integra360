package pe.sige.finanzas;

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
