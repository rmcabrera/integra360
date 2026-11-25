package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.HORARIO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Horario")
@Table(name = "horario")
public class Horario extends LegacyEntity {

    @Id
    @Column(name = "codi_hora", nullable = false)
    public Short codiHora;

    @Column(name = "descripcion", length = 50)
    public String descripcion;

    @Column(name = "he1n")
    public LocalDateTime he1n;

    @Column(name = "hs1n")
    public LocalDateTime hs1n;

    @Column(name = "he2n")
    public LocalDateTime he2n;

    @Column(name = "hs2n")
    public LocalDateTime hs2n;

    @Column(name = "he1s")
    public LocalDateTime he1s;

    @Column(name = "hs1s")
    public LocalDateTime hs1s;

    @Column(name = "he2s")
    public LocalDateTime he2s;

    @Column(name = "hs2s")
    public LocalDateTime hs2s;

    @Column(name = "hora_labo_dia", precision = 9, scale = 2)
    public BigDecimal horaLaboDia;

    @Column(name = "hora_labo_dia_saba", precision = 9, scale = 2)
    public BigDecimal horaLaboDiaSaba;
}
