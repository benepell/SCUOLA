package online.vrscuola.services.devices;

import online.vrscuola.entities.devices.VRDeviceInitEntitie;
import online.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import online.vrscuola.utilities.Utilities;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class VRDeviceInitServiceImpl implements VRDeviceInitService {

    private static final Logger Log = LogManager.getLogger(VRDeviceInitServiceImpl.class.getName());


    @Value("${keycloak.credentials.secret}")
    private String code;

    @Autowired
    VRDeviceInitRepository iRepository;

    @Autowired
    VRDeviceInitRepository VRDeviceInitRepository;

    @Override
    public void addInit(Utilities utilities, String macAddress, String label, String note){
        VRDeviceInitEntitie VRDeviceInitEntitie = new VRDeviceInitEntitie();
        VRDeviceInitEntitie.setMacAddress(macAddress);
        VRDeviceInitEntitie.setInitDate(utilities.getEpoch());
        VRDeviceInitRepository.save(VRDeviceInitEntitie);
    }

    @Override
    public void updateInit(Utilities utilities, String macAddress, String label ,String oldMacAddress, String note) {
        VRDeviceInitRepository.updateByMacAddress(macAddress,oldMacAddress,note);
    }

    @Override
    public boolean valid(String macAddress, String code) {
        // codice di verifica
        if (!this.code.equals(code)) {
            return false;
        }
        // apparato registrato
        if (iRepository.existsByMacAddress(macAddress)) {
            return true;
        }
        return false;
    }


}
