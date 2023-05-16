package online.vrscuola.services.utils;

import org.springframework.http.ResponseEntity;

import javax.servlet.http.HttpServletRequest;

public interface UtilService {
    ResponseEntity responseMsgKo(ResponseEntity.BodyBuilder bodyBuilder, String msg);

    @SuppressWarnings("rawtypes")
    ResponseEntity responseMsgOk(ResponseEntity.BodyBuilder bodyBuilder, String message);

    boolean isTablet(HttpServletRequest request);

}
