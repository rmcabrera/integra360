package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Nota_ingreso_Aceite</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "NotaIngresoAceite")
@Table(name = "nota_ingreso_aceite")
@IdClass(NotaIngresoAceite.Pk.class)
public class NotaIngresoAceite extends LegacyEntity {

    @Id
    @Column(name = "codi_ingr", nullable = false)
    public Long codiIngr;

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Column(name = "nro_ingr")
    public Long nroIngr;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "serie", length = 3)
    public String serie;

    @Column(name = "numero", length = 10)
    public String numero;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_moti_tras", length = 2)
    public String codiMotiTras;

    @Column(name = "tpc", precision = 18, scale = 4)
    public BigDecimal tpc;

    @Column(name = "observacion", length = 250)
    public String observacion;

    @Column(name = "codi_orde")
    public Long codiOrde;

    @Column(name = "rela_vale")
    public Long relaVale;

    @Column(name = "anulado", length = 1)
    public String anulado;

    @Column(name = "subt", precision = 18, scale = 2)
    public BigDecimal subt;

    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    @Column(name = "orden_compra")
    public Long ordenCompra;

    /** Legado: Productor */
    @Column(name = "productor", length = 5)
    public String productor;

    @Column(name = "transporte", length = 5)
    public String transporte;

    @Column(name = "placa", length = 10)
    public String placa;

    @Column(name = "codi_doc", length = 4)
    public String codiDoc;

    @Column(name = "serfact", length = 5)
    public String serfact;

    @Column(name = "nrofact", length = 10)
    public String nrofact;

    /** Legado: Fecha_Fact */
    @Column(name = "fecha_fact")
    public LocalDateTime fechaFact;

    @Column(name = "codi_sali")
    public Long codiSali;

    @Column(name = "chofer", length = 4)
    public String chofer;

    @Column(name = "periodo", length = 4)
    public String periodo;

    @Column(name = "indice_rela")
    public Long indiceRela;

    @Column(name = "procedencia", length = 3)
    public String procedencia;

    /** Legado: Contabilizado */
    @Column(name = "contabilizado", nullable = false)
    public Boolean contabilizado;

    /** Legado: Codi_unid_Oper_Prod */
    @Column(name = "codi_unid_oper_prod", length = 5)
    public String codiUnidOperProd;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiIngr;
        public String codiAlma;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiIngr, other.codiIngr)
                && Objects.equals(codiAlma, other.codiAlma);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiIngr, codiAlma);
        }
    }
}
