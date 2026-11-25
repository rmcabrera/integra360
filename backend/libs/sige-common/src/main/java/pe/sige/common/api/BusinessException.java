package pe.sige.common.api;

/** Regla de negocio violada: se devuelve como HTTP 422 (problem+json). */
public class BusinessException extends RuntimeException {

    private final String code;

    public BusinessException(String code, String message) {
        super(message);
        this.code = code;
    }

    public String code() {
        return code;
    }
}
