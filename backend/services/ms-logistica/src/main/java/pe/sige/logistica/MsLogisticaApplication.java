package pe.sige.logistica;

import jakarta.ws.rs.core.Application;
import org.eclipse.microprofile.openapi.annotations.OpenAPIDefinition;
import org.eclipse.microprofile.openapi.annotations.info.Info;

@OpenAPIDefinition(info = @Info(title = "SIGE ms-logistica", version = "1.0.0",
        description = "Logistica, Almacen y Compras. Incluye la API generica /v1/data para las tablas migradas del sistema PowerBuilder."))
public class MsLogisticaApplication extends Application {
}
