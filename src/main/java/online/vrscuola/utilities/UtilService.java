package online.vrscuola.utilities;

import org.springframework.http.ResponseEntity;

public interface UtilService {
    ResponseEntity responseMsgKo(ResponseEntity.BodyBuilder bodyBuilder, String msg);

    @SuppressWarnings("rawtypes")
    ResponseEntity responseMsgOk(ResponseEntity.BodyBuilder bodyBuilder, String message);
}
