package pe.sige.seguridad;

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-seguridad", version = "1.0.0",
        description = "Seguridad y Configuracion. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class MsSeguridadApplication extends Application {
}
