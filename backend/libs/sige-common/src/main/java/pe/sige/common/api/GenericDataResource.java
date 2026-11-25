package pe.sige.common.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.smallrye.mutiny.Uni;
import jakarta.inject.Inject;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.Context;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriInfo;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;
import org.hibernate.reactive.mutiny.Mutiny;
import pe.sige.common.catalog.EntityCatalog;
import pe.sige.common.catalog.EntityMeta;

/**
 * API generica de mantenimiento (equivalente a las ventanas "w_mant_*" con DataWindow de PowerBuilder
 * y a los procedimientos sp_insert_* / sp_update_* / sp_delete_*).
 * <p>
 * Los nombres de entidad y de campo se validan contra el catalogo generado, por lo que el JPQL
 * dinamico no admite inyeccion: solo los valores viajan como parametros.
 */
@Path("/v1/data")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "Mantenimiento generico")
public class GenericDataResource {

    private static final int MAX_PAGE = 500;

    @Inject
    EntityCatalog catalog;

    @Inject
    Mutiny.SessionFactory sf;

    @Inject
    ObjectMapper mapper;

    @GET
    @Operation(summary = "Lista las tablas mantenibles del servicio")
    public List<Map<String, Object>> entities() {
        return catalog.all().stream()
                .map(m -> Map.<String, Object>of("name", m.name(), "label", m.label(), "legacyName", m.legacyName(),
                        "fields", m.fields().size()))
                .toList();
    }

    @GET
    @Path("/{entity}/meta")
    @Operation(summary = "Metadatos de columnas (para grillas/formularios dinamicos)")
    public EntityMeta meta(@PathParam("entity") String entity) {
        return meta0(entity);
    }

    @GET
    @Path("/{entity}")
    @Operation(summary = "Lista paginada. Filtros: q=texto libre, f.<campo>=valor (igualdad), sort=campo,asc|desc")
    public Uni<PageResponse<Object>> list(@PathParam("entity") String entity,
            @QueryParam("page") @DefaultValue("0") int page,
            @QueryParam("size") @DefaultValue("50") int size,
            @QueryParam("sort") String sort,
            @QueryParam("q") String q,
            @Context UriInfo uri) {
        EntityMeta m = meta0(entity);
        int pageSize = Math.max(1, Math.min(size, MAX_PAGE));
        Map<String, String> filters = new HashMap<>();
        uri.getQueryParameters().forEach((k, v) -> {
            if (k.startsWith("f.") && !v.isEmpty()) {
                filters.put(k.substring(2), v.get(0));
            }
        });
        DynamicQuery dq = DynamicQuery.build(m, q, filters, sort, mapper);
        return sf.withSession(s -> dq.apply(s.createSelectionQuery(dq.countJpql(), Long.class))
                .getSingleResult()
                .flatMap(total -> dq.apply(s.createSelectionQuery(dq.selectJpql(), Object.class))
                        .setFirstResult(Math.max(page, 0) * pageSize)
                        .setMaxResults(pageSize)
                        .getResultList()
                        .map(items -> new PageResponse<>(items, total, page, pageSize))));
    }

    @GET
    @Path("/{entity}/key")
    @Operation(summary = "Obtiene un registro por su clave (los campos clave van como query params)")
    public Uni<Object> get(@PathParam("entity") String entity, @Context UriInfo uri) {
        EntityMeta m = meta0(entity);
        Object id = DynamicQuery.idOf(m, uri.getQueryParameters(), mapper);
        return sf.withSession(s -> s.find(m.entityClass(), id))
                .onItem().ifNull().failWith(() -> new NotFoundException(m.name() + " no encontrado"))
                .map(o -> (Object) o);
    }

    @POST
    @Path("/{entity}")
    @Operation(summary = "Crea un registro")
    public Uni<Response> create(@PathParam("entity") String entity, Map<String, Object> body) {
        EntityMeta m = meta0(entity);
        Object e = toEntity(m, body);
        return sf.withTransaction(s -> s.persist(e)).replaceWith(() -> Response.status(201).entity(e).build());
    }

    @PUT
    @Path("/{entity}")
    @Operation(summary = "Actualiza un registro (requiere rowVersion para bloqueo optimista)")
    public Uni<Object> update(@PathParam("entity") String entity, Map<String, Object> body) {
        EntityMeta m = meta0(entity);
        if (body.get("rowVersion") == null) {
            throw new IllegalArgumentException("rowVersion es obligatorio para actualizar");
        }
        Object e = toEntity(m, body);
        return sf.withTransaction(s -> s.merge(e)).map(o -> (Object) o);
    }

    @DELETE
    @Path("/{entity}/key")
    @Operation(summary = "Elimina un registro por su clave")
    public Uni<Response> delete(@PathParam("entity") String entity, @Context UriInfo uri) {
        EntityMeta m = meta0(entity);
        Object id = DynamicQuery.idOf(m, uri.getQueryParameters(), mapper);
        return sf.withTransaction(s -> s.find(m.entityClass(), id)
                .onItem().ifNull().failWith(() -> new NotFoundException(m.name() + " no encontrado"))
                .flatMap(s::remove))
                .replaceWith(Response.noContent().build());
    }

    private EntityMeta meta0(String entity) {
        return catalog.find(entity).orElseThrow(() -> new NotFoundException("Entidad desconocida: " + entity));
    }

    private Object toEntity(EntityMeta m, Map<String, Object> body) {
        Map<String, Object> clean = new HashMap<>(body);
        // los campos de auditoria los gestiona el servidor
        clean.remove("auditCreatedAt");
        clean.remove("auditUpdatedAt");
        clean.remove("auditUser");
        clean.keySet().removeIf(k -> !"rowVersion".equals(k) && m.field(k).isEmpty());
        return mapper.convertValue(clean, m.entityClass());
    }
}
