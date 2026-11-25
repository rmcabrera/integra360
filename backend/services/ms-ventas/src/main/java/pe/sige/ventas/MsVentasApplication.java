package pe.sige.ventas;

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-ventas", version = "1.0.0",
        description = "Facturacion, Ventas y Operaciones comerciales. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class MsVentasApplication extends Application {
}
