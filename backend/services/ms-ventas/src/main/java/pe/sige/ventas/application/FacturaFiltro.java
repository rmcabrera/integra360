package pe.sige.ventas.application;

import io.quarkus.panache.common.Parameters;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/** Filtros de busqueda de comprobantes (antes argumentos de retrieve() del DataWindow d_siep_facturas). */
public record FacturaFiltro(LocalDate desde, LocalDate hasta, String codiClieProv, String codiAlma, String serie,
        String estado) {

    public record Query(String jpql, Parameters params) {
    }

    public Query toQuery() {
        List<String> w = new ArrayList<>();
        Parameters p = new Parameters();
        if (desde != null) {
            w.add("fechFact >= :desde");
            p.and("desde", desde.atStartOfDay());
        }
        if (hasta != null) {
            w.add("fechFact < :hasta");
            p.and("hasta", hasta.plusDays(1).atStartOfDay());
        }
        if (codiClieProv != null && !codiClieProv.isBlank()) {
            w.add("codiClieProv = :cli");
            p.and("cli", codiClieProv);
        }
        if (codiAlma != null && !codiAlma.isBlank()) {
            w.add("codiAlma = :alma");
            p.and("alma", codiAlma);
        }
        if (serie != null && !serie.isBlank()) {
            w.add("serFact = :serie");
            p.and("serie", serie);
        }
        if (estado != null && !estado.isBlank()) {
            w.add("estado = :estado");
            p.and("estado", estado);
        }
        return new Query(w.isEmpty() ? "1 = 1" : String.join(" and ", w), p);
    }
}
