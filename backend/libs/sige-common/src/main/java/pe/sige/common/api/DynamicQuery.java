package pe.sige.common.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.ws.rs.core.MultivaluedMap;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.hibernate.reactive.mutiny.Mutiny;
import pe.sige.common.catalog.EntityMeta;
import pe.sige.common.catalog.FieldMeta;

/** Construye JPQL seguro a partir de filtros validados contra los metadatos. */
public record DynamicQuery(String selectJpql, String countJpql, Map<String, Object> params) {

    private static final Map<String, Class<?>> TYPES = Map.ofEntries(
            Map.entry("String", String.class), Map.entry("Integer", Integer.class), Map.entry("Long", Long.class),
            Map.entry("Short", Short.class), Map.entry("BigDecimal", BigDecimal.class), Map.entry("Boolean", Boolean.class),
            Map.entry("Double", Double.class), Map.entry("Float", Float.class), Map.entry("LocalDate", LocalDate.class),
            Map.entry("LocalDateTime", LocalDateTime.class), Map.entry("LocalTime", LocalTime.class),
            Map.entry("OffsetDateTime", OffsetDateTime.class), Map.entry("UUID", UUID.class));

    /** maximo de columnas de texto incluidas en la busqueda libre */
    private static final int MAX_TEXT_SEARCH_FIELDS = 6;

    public static Class<?> javaType(FieldMeta f) {
        Class<?> c = TYPES.get(f.type());
        if (c == null) {
            throw new IllegalArgumentException("Campo no filtrable: " + f.field());
        }
        return c;
    }

    public static DynamicQuery build(EntityMeta m, String q, Map<String, String> filters, String sort, ObjectMapper mapper) {
        List<String> where = new ArrayList<>();
        Map<String, Object> params = new LinkedHashMap<>();
        int i = 0;
        for (var e : filters.entrySet()) {
            FieldMeta f = m.field(e.getKey())
                    .orElseThrow(() -> new IllegalArgumentException("Campo desconocido: " + e.getKey()));
            String p = "p" + i++;
            String value = e.getValue();
            if (f.text() && value.contains("*")) {
                where.add("lower(e." + f.field() + ") like :" + p);
                params.put(p, value.replace('*', '%').toLowerCase());
            } else {
                where.add("e." + f.field() + " = :" + p);
                params.put(p, mapper.convertValue(value, javaType(f)));
            }
        }
        if (q != null && !q.isBlank()) {
            List<String> ors = m.fields().stream().filter(FieldMeta::text).limit(MAX_TEXT_SEARCH_FIELDS)
                    .map(f -> "lower(e." + f.field() + ") like :q").toList();
            if (!ors.isEmpty()) {
                where.add("(" + String.join(" or ", ors) + ")");
                params.put("q", "%" + q.trim().toLowerCase() + "%");
            }
        }
        String from = " from " + m.entityClass().getSimpleName() + " e" + (where.isEmpty() ? "" : " where " + String.join(" and ", where));
        String order = orderBy(m, sort);
        return new DynamicQuery("select e" + from + order, "select count(e)" + from, params);
    }

    private static String orderBy(EntityMeta m, String sort) {
        if (sort == null || sort.isBlank()) {
            return " order by " + String.join(", ", m.idFields().stream().map(f -> "e." + f.field()).toList());
        }
        String[] parts = sort.split(",");
        FieldMeta f = m.field(parts[0].trim()).orElseThrow(() -> new IllegalArgumentException("Orden invalido: " + parts[0]));
        boolean desc = parts.length > 1 && "desc".equalsIgnoreCase(parts[1].trim());
        return " order by e." + f.field() + (desc ? " desc" : " asc");
    }

    public <T> Mutiny.SelectionQuery<T> apply(Mutiny.SelectionQuery<T> query) {
        params.forEach(query::setParameter);
        return query;
    }

    /** Construye el identificador (simple o IdClass compuesta) desde los query params. */
    public static Object idOf(EntityMeta m, MultivaluedMap<String, String> qp, ObjectMapper mapper) {
        List<FieldMeta> ids = m.idFields();
        Map<String, Object> values = new HashMap<>();
        for (FieldMeta f : ids) {
            String v = qp.getFirst(f.field());
            if (v == null) {
                throw new IllegalArgumentException("Falta el campo clave: " + f.field());
            }
            values.put(f.field(), mapper.convertValue(v, javaType(f)));
        }
        if (m.compositeKey()) {
            return mapper.convertValue(values, m.idClass());
        }
        return values.get(ids.get(0).field());
    }
}
