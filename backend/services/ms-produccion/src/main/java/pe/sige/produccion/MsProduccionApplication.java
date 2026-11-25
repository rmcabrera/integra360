package pe.sige.produccion;

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-produccion", version = "1.0.0",
        description = "Pesca, Flota y Produccion. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class MsProduccionApplication extends Application {
}
