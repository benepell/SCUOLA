package online.vrscuola.services.connect;

import online.vrscuola.payload.response.ConnectResponse;
import online.vrscuola.utilities.Utilities;

public interface ConnectService {

    String viewConnect(Utilities utilities, String macAddress, String note);

    boolean valid(String macAddress, String code);
}
