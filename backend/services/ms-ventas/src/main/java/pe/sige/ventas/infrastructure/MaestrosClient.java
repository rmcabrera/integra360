package pe.sige.ventas.infrastructure;

import io.smallrye.mutiny.Uni;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.QueryParam;
import java.util.Map;
import org.eclipse.microprofile.rest.client.annotation.RegisterClientHeaders;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

/** Cliente REST reactivo hacia ms-maestros (propaga el token del usuario). */
@RegisterRestClient(configKey = "maestros")
@RegisterClientHeaders
@Path("/api/maestros/v1/data")
public interface MaestrosClient {

    @GET
    @Path("/cliente_proveedor/key")
    Uni<Map<String, Object>> cliente(@QueryParam("codiClieProv") String codiClieProv);
}
