package online.vrscuola.payload.response;

import lombok.Data;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Data
public class MessageResponse {
    private static final Logger Log = LogManager.getLogger(MessageResponse.class.getName());

    private String message;

    public MessageResponse(String message) {
        this.message = message;
    }

}
