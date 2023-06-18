package it.vrscuola.scuola.services.devices;

import it.vrscuola.scuola.utilities.Utilities;

public interface VRDeviceConnectivityService {

    String viewConnect(Utilities utilities, String macAddress, String note);

    boolean valid(String macAddress, String code);

    void connect(Utilities utilities, String macAddress, String username, String note, String connected);

    String argomento(String argomento);
}
