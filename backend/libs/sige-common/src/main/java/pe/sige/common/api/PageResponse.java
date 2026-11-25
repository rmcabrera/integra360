package pe.sige.common.api;

import java.util.List;

/** Respuesta paginada estandar. */
public record PageResponse<T>(List<T> items, long total, int page, int size) {
}
