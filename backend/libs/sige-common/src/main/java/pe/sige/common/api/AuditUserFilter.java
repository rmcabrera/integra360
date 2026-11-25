package pe.sige.common.api;

import io.quarkus.security.identity.SecurityIdentity;
import jakarta.inject.Inject;
import jakarta.ws.rs.container.ContainerRequestContext;
import org.jboss.resteasy.reactive.server.ServerRequestFilter;
import pe.sige.common.persistence.AuditContext;

/** Propaga el usuario autenticado (JWT de Keycloak) al contexto de auditoria. */
public class AuditUserFilter {

    @Inject
    SecurityIdentity identity;

    @ServerRequestFilter
    public void setAuditUser(ContainerRequestContext ctx) {
        String user = identity == null || identity.isAnonymous() ? "anonymous" : identity.getPrincipal().getName();
        AuditContext.setUser(user);
    }
}
