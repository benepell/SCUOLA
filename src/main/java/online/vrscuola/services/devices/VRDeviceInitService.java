package online.vrscuola.services.devices;

import online.vrscuola.utilities.Utilities;

public interface VRDeviceInitService {
    void addInit(Utilities utilities, String macAddress, String label);

    void updateInit(Utilities utilities, String macAddress, String label , String oldMacAddress, String note);


}
