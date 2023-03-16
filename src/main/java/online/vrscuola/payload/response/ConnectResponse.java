package online.vrscuola.payload.response;

import lombok.Data;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Data
public class ConnectResponse {

    private static final Logger Log = LogManager.getLogger(MessageResponse.class.getName());

    private final String username;
    private final String note;

    public ConnectResponse(String username, String note ) {
        this.username = username;
        this.note = note;
    }
}
