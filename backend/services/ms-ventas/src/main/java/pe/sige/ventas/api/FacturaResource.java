package pe.sige.ventas.api;

import io.quarkus.security.identity.SecurityIdentity;
import io.smallrye.mutiny.Uni;
import jakarta.inject.Inject;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DefaultValue;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.net.URI;
import java.time.LocalDate;
import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;
import pe.sige.common.api.PageResponse;
import pe.sige.ventas.application.EmitirFacturaRequest;
import pe.sige.ventas.application.FacturaFiltro;
import pe.sige.ventas.application.FacturaService;
import pe.sige.ventas.application.FacturaService.FacturaConDetalle;
import pe.sige.ventas.domain.legacy.Factura;

@Path("/v1/facturas")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Tag(name = "Facturacion")
public class FacturaResource {

    @Inject
    FacturaService service;

    @Inject
    SecurityIdentity identity;

    public record AnularRequest(@NotBlank @Size(max = 100) String motivo) {
    }

    @GET
    @Operation(summary = "Busca comprobantes por rango de fechas, cliente, almacen, serie o estado")
    public Uni<PageResponse<Factura>> buscar(@QueryParam("desde") LocalDate desde, @QueryParam("hasta") LocalDate hasta,
            @QueryParam("cliente") String cliente, @QueryParam("almacen") String almacen,
            @QueryParam("serie") String serie, @QueryParam("estado") String estado,
            @QueryParam("page") @DefaultValue("0") int page, @QueryParam("size") @DefaultValue("50") int size) {
        return service.buscar(new FacturaFiltro(desde, hasta, cliente, almacen, serie, estado), Math.max(page, 0),
                Math.min(Math.max(size, 1), 500));
    }

    @GET
    @Path("/{codiFact}")
    @Operation(summary = "Comprobante con su detalle")
    public Uni<FacturaConDetalle> obtener(@PathParam("codiFact") String codiFact) {
        return service.obtener(codiFact);
    }

    @POST
    @Operation(summary = "Emite un comprobante: numera la serie, calcula IGV, registra y publica ventas.factura.emitida")
    public Uni<Response> emitir(@Valid EmitirFacturaRequest req) {
        return service.emitir(req, usuario())
                .map(f -> Response.created(URI.create("/api/ventas/v1/facturas/" + f.codiFact)).entity(f).build());
    }

    @POST
    @Path("/{codiFact}/anular")
    @Operation(summary = "Anula un comprobante y publica ventas.factura.anulada (revierte stock y asiento)")
    public Uni<Factura> anular(@PathParam("codiFact") String codiFact, @Valid AnularRequest req) {
        return service.anular(codiFact, req.motivo(), usuario());
    }

    private String usuario() {
        return identity.isAnonymous() ? "anonymous" : identity.getPrincipal().getName();
    }
}
