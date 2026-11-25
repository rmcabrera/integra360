package pe.sige.common.api;

import io.vertx.pgclient.PgException;
import jakarta.persistence.OptimisticLockException;
import jakarta.validation.ConstraintViolationException;
import jakarta.ws.rs.WebApplicationException;
import jakarta.ws.rs.core.Response;
import java.util.LinkedHashMap;
import java.util.Map;
import org.hibernate.StaleStateException;
import org.jboss.logging.Logger;
import org.jboss.resteasy.reactive.server.ServerExceptionMapper;

/** Traduce excepciones a respuestas RFC 9457 (application/problem+json). */
public class ProblemMappers {

    private static final Logger LOG = Logger.getLogger(ProblemMappers.class);

    static Response problem(int status, String title, String detail, String code) {
        Map<String, Object> body = new LinkedHashMap<>();
        body.put("type", "about:blank");
        body.put("title", title);
        body.put("status", status);
        body.put("detail", detail);
        if (code != null) {
            body.put("code", code);
        }
        return Response.status(status).type("application/problem+json").entity(body).build();
    }

    @ServerExceptionMapper
    public Response business(BusinessException e) {
        return problem(422, "Regla de negocio", e.getMessage(), e.code());
    }

    @ServerExceptionMapper
    public Response validation(ConstraintViolationException e) {
        String detail = e.getConstraintViolations().stream()
                .map(v -> v.getPropertyPath() + ": " + v.getMessage())
                .reduce((a, b) -> a + "; " + b).orElse("datos invalidos");
        return problem(400, "Datos invalidos", detail, "VALIDATION");
    }

    @ServerExceptionMapper
    public Response illegalArgument(IllegalArgumentException e) {
        return problem(400, "Peticion invalida", e.getMessage(), "BAD_REQUEST");
    }

    @ServerExceptionMapper({ OptimisticLockException.class, StaleStateException.class })
    public Response optimistic(Exception e) {
        return problem(409, "Conflicto de concurrencia",
                "El registro fue modificado por otro usuario. Recargue e intente de nuevo.", "OPTIMISTIC_LOCK");
    }

    @ServerExceptionMapper
    public Response pg(PgException e) {
        return switch (e.getSqlState()) {
            case "23505" -> problem(409, "Registro duplicado", e.getErrorMessage(), "DUPLICATE");
            case "23503" -> problem(409, "Registro relacionado", e.getErrorMessage(), "FOREIGN_KEY");
            case "23502", "22001", "22P02" -> problem(400, "Datos invalidos", e.getErrorMessage(), "DATA");
            default -> {
                LOG.error("Error de base de datos", e);
                yield problem(500, "Error de base de datos", e.getSqlState(), "DB");
            }
        };
    }

    @ServerExceptionMapper
    public Response persistence(jakarta.persistence.PersistenceException e) {
        for (Throwable t = e; t != null; t = t.getCause()) {
            if (t instanceof PgException pg) {
                return pg(pg);
            }
            if (t instanceof org.hibernate.JDBCException j && j.getSQLState() != null) {
                return bySqlState(j.getSQLState(), "Restriccion de datos violada");
            }
        }
        LOG.error("Error de persistencia", e);
        return problem(500, "Error de persistencia", "Consulte el log del servicio", "DB");
    }

    private static Response bySqlState(String state, String detail) {
        return switch (state) {
            case "23505" -> problem(409, "Registro duplicado", "Ya existe un registro con esa clave", "DUPLICATE");
            case "23503" -> problem(409, "Registro relacionado", "El registro esta relacionado con otros datos", "FOREIGN_KEY");
            case "23502", "22001", "22P02", "23514" -> problem(400, "Datos invalidos", detail, "DATA");
            default -> problem(500, "Error de base de datos", "SQLSTATE " + state, "DB");
        };
    }

    @ServerExceptionMapper
    public Response webApp(WebApplicationException e) {
        int status = e.getResponse().getStatus();
        return problem(status, e.getResponse().getStatusInfo().getReasonPhrase(), e.getMessage(), null);
    }
}
