package pe.sige.common.catalog;

import java.util.List;
import java.util.Optional;

/** Catalogo de entidades que un microservicio expone por la API generica de mantenimiento. */
public interface EntityCatalog {

    String service();

    Optional<EntityMeta> find(String name);

    List<EntityMeta> all();
}
