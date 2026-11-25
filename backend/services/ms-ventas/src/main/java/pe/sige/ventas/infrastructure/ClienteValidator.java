package pe.sige.ventas.infrastructure;

import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.ws.rs.WebApplicationException;
import org.eclipse.microprofile.faulttolerance.CircuitBreaker;
import org.eclipse.microprofile.faulttolerance.Retry;
import org.eclipse.microprofile.faulttolerance.Timeout;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import pe.sige.common.api.BusinessException;

/** Valida contra ms-maestros que el cliente exista, con timeout, reintentos y circuit breaker. */
@ApplicationScoped
public class ClienteValidator {

    @Inject
    @RestClient
    MaestrosClient maestros;

    @Timeout(3000)
    @Retry(maxRetries = 2, delay = 200, abortOn = BusinessException.class)
    @CircuitBreaker(requestVolumeThreshold = 10, failureRatio = 0.5, delay = 10000, skipOn = BusinessException.class)
    public Uni<Void> validar(String codiClieProv) {
        return maestros.cliente(codiClieProv)
                .onFailure(e -> e instanceof WebApplicationException w && w.getResponse().getStatus() == 404)
                .transform(e -> new BusinessException("CLIENTE_NO_EXISTE", "El cliente " + codiClieProv + " no existe"))
                .replaceWithVoid();
    }
}
