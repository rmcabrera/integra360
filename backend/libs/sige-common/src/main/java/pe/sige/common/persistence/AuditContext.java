package pe.sige.common.persistence;

import io.vertx.core.Context;
import io.vertx.core.Vertx;

/**
 * Usuario actual para auditoria, guardado en el contexto Vert.x (duplicado por peticion),
 * de modo que funciona en codigo reactivo sin ThreadLocal.
 */
public final class AuditContext {

    private static final String KEY = "sige.audit.user";

    private AuditContext() {
    }

    public static void setUser(String user) {
        Context ctx = Vertx.currentContext();
        if (ctx != null) {
            ctx.putLocal(KEY, user);
        }
    }

    public static String currentUser() {
        Context ctx = Vertx.currentContext();
        Object u = ctx == null ? null : ctx.getLocal(KEY);
        return u == null ? "system" : u.toString();
    }
}
