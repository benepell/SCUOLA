package online.vrscuola.services.devices;

import online.vrscuola.entities.devices.VRDeviceConnectivityEntitie;
import online.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import online.vrscuola.services.KeycloakUserService;
import online.vrscuola.utilities.Constants;
import online.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VRDeviceManageService {

    @Autowired
    VRDeviceInitRepository iRepository;

    @Autowired
    VRDeviceConnectivityRepository cRepository;

    @Autowired
    KeycloakUserService kService;

    @Autowired
    Utilities utilities;

    public boolean enableDevice(String label, String username) {
        // controlla se macAddress ha un visore associato
        String macAddress = iRepository.findMac(label);
        if (macAddress == null) {
            return false;
        }

        boolean updating = false;

        // controlla se il visore e' gia' associato
        if (cRepository.findMac(macAddress) != null) {
            updating = true;
        }

        String note = "";

        // controlla da keycloak se l'utente esiste ed e' abilitato
        if (kService.existUser(username)) {

            if (updating) {
                cRepository.updateByMacAddress(utilities.getEpoch(), username, note, macAddress, Constants.CONNECTED_IN_PENDING);
            } else {
                VRDeviceConnectivityEntitie vrDeviceConnectivityEntitie = new VRDeviceConnectivityEntitie();
                vrDeviceConnectivityEntitie.setInitDate(utilities.getEpoch());
                vrDeviceConnectivityEntitie.setMacAddress(macAddress);
                vrDeviceConnectivityEntitie.setUsername(username);
                vrDeviceConnectivityEntitie.setNote(note);
                vrDeviceConnectivityEntitie.setConnected(Constants.CONNECTED_IN_PENDING);
                cRepository.save(vrDeviceConnectivityEntitie);
            }

        }
        return true;
    }

    public boolean removeDevice(String label, String username) {
        // controlla se macAddress ha un visore associato
        String macAddress = iRepository.findMac(label);
        if (macAddress == null) {
            return false;
        }

        String note = "";

        // controlla da keycloak se l'utente esiste ed e' abilitato
        if (kService.existUser(username)) {
            cRepository.updateByMacAddress(utilities.getEpoch(), username, note, macAddress, Constants.CONNECTED_IN_DISCONNECTED);

        }
        return true;
    }

    public String[] allDevices() {
        List<String> list = iRepository.labels();
        return list != null ? list.toArray(new String[list.size()]) : null;
    }
}
