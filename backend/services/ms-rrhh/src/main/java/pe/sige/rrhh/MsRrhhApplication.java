package pe.sige.rrhh;

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-rrhh", version = "1.0.0",
        description = "Personal, Planillas y Legal. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class MsRrhhApplication extends Application {
}
