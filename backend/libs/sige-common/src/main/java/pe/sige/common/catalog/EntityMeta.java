package pe.sige.common.catalog;

import com.fasterxml.jackson.annotation.JsonIgnore;
import java.util.List;
import java.util.Optional;

/**
 * Metadatos de una tabla: lo que antes describia el DataWindow (columnas, tipos, etiquetas, clave).
 * El frontend los usa para pintar grillas y formularios de mantenimiento sin codigo especifico.
 */
public record EntityMeta(
        String name,
        String legacyName,
        String label,
        @JsonIgnore Class<?> entityClass,
        @JsonIgnore Class<?> idClass,
        List<FieldMeta> fields) {

    public List<FieldMeta> idFields() {
        return fields.stream().filter(FieldMeta::id).toList();
    }

    public Optional<FieldMeta> field(String name) {
        return fields.stream().filter(f -> f.field().equals(name)).findFirst();
    }

    public boolean compositeKey() {
        return idClass != null;
    }
}
