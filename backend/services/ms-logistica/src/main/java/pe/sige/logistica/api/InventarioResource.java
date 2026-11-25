package pe.sige.logistica.api;

import io.quarkus.hibernate.reactive.panache.common.WithSession;
import io.quarkus.hibernate.reactive.panache.common.WithTransaction;
import io.quarkus.panache.common.Parameters;
import io.smallrye.mutiny.Uni;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import java.util.List;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;
import pe.sige.common.api.PageResponse;
import pe.sige.logistica.application.KardexService;
import pe.sige.logistica.application.MovimientoKardex;
import pe.sige.logistica.domain.legacy.AlmacenProducto;
import pe.sige.logistica.domain.legacy.Kardex;
import pe.sige.logistica.domain.legacy.Productos;

@Path("/v1")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "Inventario")
public class InventarioResource {

    @Inject
    KardexService kardex;

    @GET
    @Path("/productos")
    @WithSession
    @Operation(summary = "Busqueda de productos por codigo o descripcion (antes w_siep_busca_productos)")
    public Uni<PageResponse<Productos>> productos(@QueryParam("q") @DefaultValue("") String q,
            @QueryParam("page") @DefaultValue("0") int page, @QueryParam("size") @DefaultValue("30") int size) {
        var query = Productos.<Productos>find("(codiProd like :q or lower(descProd) like :q) and (estaActi is null or estaActi <> '0') order by descProd",
                Parameters.with("q", "%" + q.trim().toLowerCase() + "%"));
        int s = Math.min(Math.max(size, 1), 200);
        return query.count().flatMap(total -> query.page(page, s).list().map(l -> new PageResponse<>(l, total, page, s)));
    }

    @GET
    @Path("/productos/{codiProd}/stock")
    @WithSession
    @Operation(summary = "Stock y precio promedio por almacen")
    public Uni<List<AlmacenProducto>> stock(@PathParam("codiProd") String codiProd) {
        return AlmacenProducto.list("codiProd = ?1 order by codiAlma", codiProd);
    }

    @GET
    @Path("/kardex")
    @WithSession
    @Operation(summary = "Kardex valorizado de un producto en un periodo (opcionalmente por almacen)")
    public Uni<List<Kardex>> kardex(@QueryParam("producto") String codiProd, @QueryParam("periodo") int periodo,
            @QueryParam("almacen") String codiAlma) {
        if (codiAlma == null || codiAlma.isBlank()) {
            return Kardex.list("codiProd = ?1 and periodo = ?2 order by fechTran, codiKard", codiProd, periodo);
        }
        return Kardex.list("codiProd = ?1 and periodo = ?2 and codiAlma = ?3 order by fechTran, codiKard", codiProd, periodo, codiAlma);
    }

    @POST
    @Path("/kardex/movimientos")
    @WithTransaction
    @Operation(summary = "Registra un movimiento de inventario (ingreso/salida) y recalcula saldos")
    public Uni<Kardex> movimiento(@Valid MovimientoKardex m) {
        return kardex.registrar(m);
    }

    @POST
    @Path("/kardex/reproceso")
    @WithTransaction
    @Operation(summary = "Reprocesa el kardex de un producto en un periodo")
    public Uni<Void> reproceso(@QueryParam("producto") String codiProd, @QueryParam("periodo") int periodo) {
        return kardex.recalcular(codiProd, periodo);
    }
}
