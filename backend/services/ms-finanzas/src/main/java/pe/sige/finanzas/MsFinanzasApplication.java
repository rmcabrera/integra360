package pe.sige.finanzas;

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-finanzas", version = "1.0.0",
        description = "Finanzas: Caja, Bancos y Letras. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class MsFinanzasApplication extends Application {
}
