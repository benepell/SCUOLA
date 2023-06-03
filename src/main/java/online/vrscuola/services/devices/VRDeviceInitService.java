package online.vrscuola.services.devices;

import online.vrscuola.utilities.Utilities;

public interface VRDeviceInitService {
    void addInit(Utilities utilities, String macAddress,  String note, String paramCode);

    void updateInit(Utilities utilities, String macAddress, String oldMacAddress, String note, String paramCode);

    boolean valid(String macAddress, String code);

    String label(String macAddress);

    void updateBatteryLevel(String macAddress, int batteryLevel);

}
