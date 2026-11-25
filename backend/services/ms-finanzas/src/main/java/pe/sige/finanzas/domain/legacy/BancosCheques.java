package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.BANCOS_CHEQUES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "BancosCheques")
@Table(name = "bancos_cheques")
@IdClass(BancosCheques.Pk.class)
public class BancosCheques extends LegacyEntity {

    /** Legado: NRO_CUEN */
    @Id
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: NRO_TALON */
    @Id
    @Column(name = "nro_talon", length = 6, nullable = false)
    public String nroTalon;

    /** Legado: NRO_INIC_CHEQ */
    @Column(name = "nro_inic_cheq", length = 8)
    public String nroInicCheq;

    /** Legado: NRO_FIN_CHEQ */
    @Column(name = "nro_fin_cheq", length = 8)
    public String nroFinCheq;

    /** Legado: CANT_CHEQ */
    @Column(name = "cant_cheq")
    public Long cantCheq;

    /** Legado: CODI_USUA */
    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    /** Legado: CANT_CHEQ_GIRA */
    @Column(name = "cant_cheq_gira")
    public Long cantCheqGira;

    /** Legado: CANT_CHEQ_ANUL */
    @Column(name = "cant_cheq_anul")
    public Long cantCheqAnul;

    /** Legado: CANT_CHEQ_SALD */
    @Column(name = "cant_cheq_sald")
    public Long cantCheqSald;

    /** Legado: FECHA */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: CHEQ_ULTI */
    @Column(name = "cheq_ulti", length = 8)
    public String cheqUlti;

    /** Legado: SITU_CHEQ */
    @Id
    @Column(name = "situ_cheq", length = 2, nullable = false)
    public String situCheq;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String nroCuen;
        public String nroTalon;
        public String situCheq;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(nroCuen, other.nroCuen)
                && Objects.equals(nroTalon, other.nroTalon)
                && Objects.equals(situCheq, other.situCheq);
        }

        @Override
        public int hashCode() {
            return Objects.hash(nroCuen, nroTalon, situCheq);
        }
    }
}
