package pe.sige.common.catalog;

/**
 * Metadatos de una columna.
 *
 * @param field     nombre del atributo Java / JSON
 * @param column    nombre de la columna PostgreSQL
 * @param type      tipo Java simple (String, Integer, BigDecimal, LocalDateTime...)
 * @param length    longitud maxima para texto (0 = sin limite)
 * @param required  NOT NULL
 * @param id        forma parte de la clave primaria
 * @param generated valor generado por la BD (identity o columna calculada)
 * @param label     etiqueta para la interfaz
 */
public record FieldMeta(String field, String column, String type, int length, boolean required, boolean id,
        boolean generated, String label) {

    public boolean text() {
        return "String".equals(type);
    }
}
