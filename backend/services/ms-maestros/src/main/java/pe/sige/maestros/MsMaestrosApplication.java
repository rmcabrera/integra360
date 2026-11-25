package pe.sige.maestros;

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-maestros", version = "1.0.0",
        description = "Maestros generales. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class MsMaestrosApplication extends Application {
}
