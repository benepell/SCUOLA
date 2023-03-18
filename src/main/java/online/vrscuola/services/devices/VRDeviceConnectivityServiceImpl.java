package online.vrscuola.services.devices;

import online.vrscuola.entities.devices.VRDeviceConnectivityEntitie;
import online.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import online.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class VRDeviceConnectivityServiceImpl implements VRDeviceConnectivityService {

    @Value("${keycloak.credentials.secret}")
    private String code;

    @Autowired
    VRDeviceConnectivityRepository cRepository;

    @Autowired
    VRDeviceInitRepository iRepository;

    @Override
    public String viewConnect(Utilities utilities, String macAddress, String note) {
        return cRepository.existsUsername(macAddress);
    }

    @Override
    public boolean valid(String macAddress, String code) {
        // codice di verifica
        if (!this.code.equals(code)) {
            return false;
        }
        // apparato registrato
        if (!iRepository.existsByMacAddress(macAddress)) {
            return false;
        }
        // ultima condizione verificata allora true
        // collegamento professore aggionamento campo username in base a macaddress
        if (cRepository.existsByMacAddress(macAddress)) {
            return true;
        }
        return false;
    }

    @Override
    public void connect(boolean updating, Utilities utilities, String macAddress, String username, String note) {
        if (updating) {
            cRepository.updateByMacAddress(utilities.getEpoch(), username, note, macAddress);
        } else {
            VRDeviceConnectivityEntitie vrDeviceConnectivityEntitie = new VRDeviceConnectivityEntitie();
            vrDeviceConnectivityEntitie.setInitDate(utilities.getEpoch());
            vrDeviceConnectivityEntitie.setMacAddress(macAddress);
            vrDeviceConnectivityEntitie.setUsername(username);
            vrDeviceConnectivityEntitie.setNote(note);
            cRepository.save(vrDeviceConnectivityEntitie);
        }

    }
}
