package pe.sige.contabilidad;

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-contabilidad", version = "1.0.0",
        description = "Contabilidad, Activos y Libros SUNAT. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class MsContabilidadApplication extends Application {
}
