package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.HOJA_VIDA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "HojaVida")
@Table(name = "hoja_vida")
public class HojaVida extends LegacyEntity {

    @Id
    @Column(name = "codi_hoja", nullable = false)
    public Long codiHoja;

    @Column(name = "grupo", length = 250)
    public String grupo;

    @Column(name = "razon", length = 250)
    public String razon;

    @Column(name = "ruc", length = 11)
    public String ruc;

    @Column(name = "email_emp", length = 100)
    public String emailEmp;

    @Column(name = "email_logi", length = 100)
    public String emailLogi;

    @Column(name = "email_ventas", length = 100)
    public String emailVentas;

    @Column(name = "email_tecni", length = 100)
    public String emailTecni;

    @Column(name = "direccion", length = 100)
    public String direccion;

    @Column(name = "localidad", length = 100)
    public String localidad;

    @Column(name = "provincia", length = 100)
    public String provincia;

    @Column(name = "departamento", length = 100)
    public String departamento;

    @Column(name = "telef", length = 15)
    public String telef;

    @Column(name = "celular", length = 15)
    public String celular;

    @Column(name = "cobertura", length = 150)
    public String cobertura;

    @Column(name = "ape_1", length = 100)
    public String ape1;

    @Column(name = "ape_2", length = 100)
    public String ape2;

    @Column(name = "nombres", length = 150)
    public String nombres;

    @Column(name = "codigo", length = 20)
    public String codigo;

    @Column(name = "cargo", length = 100)
    public String cargo;

    @Column(name = "propietario", length = 100)
    public String propietario;

    @Column(name = "arrendatario", length = 100)
    public String arrendatario;

    @Column(name = "jefe_campo", length = 100)
    public String jefeCampo;

    @Column(name = "logistica", length = 100)
    public String logistica;

    @Column(name = "zona_pers", length = 100)
    public String zonaPers;

    @Column(name = "prov_pers", length = 100)
    public String provPers;

    @Column(name = "dist_pers", length = 100)
    public String distPers;

    @Column(name = "depa_pers", length = 100)
    public String depaPers;

    @Column(name = "email", length = 100)
    public String email;

    @Column(name = "fech_nac")
    public LocalDateTime fechNac;

    @Column(name = "dni", length = 8)
    public String dni;

    @Column(name = "telef_pers", length = 15)
    public String telefPers;

    @Column(name = "estado_civ", length = 20)
    public String estadoCiv;

    @Column(name = "celular_pers", length = 15)
    public String celularPers;

    @Column(name = "grado", length = 100)
    public String grado;

    @Column(name = "familia", length = 100)
    public String familia;

    @Column(name = "especie", length = 100)
    public String especie;

    @Column(name = "variedad", length = 100)
    public String variedad;

    @Column(name = "siembra", length = 100)
    public String siembra;

    @Column(name = "surco", precision = 18, scale = 3)
    public BigDecimal surco;

    @Column(name = "golpe", precision = 18, scale = 3)
    public BigDecimal golpe;

    @Column(name = "surco_2", precision = 18, scale = 3)
    public BigDecimal surco2;

    @Column(name = "area", precision = 18, scale = 3)
    public BigDecimal area;

    @Column(name = "semilla", length = 50)
    public String semilla;

    @Column(name = "nro_semilla", precision = 18, scale = 3)
    public BigDecimal nroSemilla;

    @Column(name = "densidad", precision = 18, scale = 3)
    public BigDecimal densidad;
}
