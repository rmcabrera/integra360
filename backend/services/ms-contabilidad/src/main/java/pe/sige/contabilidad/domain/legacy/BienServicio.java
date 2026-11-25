package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.bien_servicio</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "BienServicio")
@Table(name = "bien_servicio")
public class BienServicio extends LegacyEntity {

    @Id
    @Column(name = "codi_bien_serv", length = 3, nullable = false)
    public String codiBienServ;

    @Column(name = "desc_bien_serv", length = 250)
    public String descBienServ;

    @Column(name = "nemo_bien_serv", length = 50)
    public String nemoBienServ;

    @Column(name = "porc_bien_serv", precision = 18, scale = 3)
    public BigDecimal porcBienServ;

    @Column(name = "inicio")
    public LocalDateTime inicio;

    @Column(name = "fin")
    public LocalDateTime fin;
}
