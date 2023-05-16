package online.vrscuola.services.devices;

import online.vrscuola.entities.devices.VRDeviceInitEntitie;
import online.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import online.vrscuola.utilities.Constants;
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
    public void addInit(Utilities utilities, String macAddress, String note, String paramCode){
        VRDeviceInitEntitie VRDeviceInitEntitie = new VRDeviceInitEntitie();
        VRDeviceInitEntitie.setMacAddress(macAddress);
        VRDeviceInitEntitie.setInitDate(utilities.getEpoch());
        String label = String.valueOf(iRepository.getCount() > 0 ? iRepository.getNextAvailableId(): 1);
        VRDeviceInitEntitie.setLabel(label);
        VRDeviceInitEntitie.setNote(note);
        VRDeviceInitEntitie.setCode(paramCode);
        // quando si aggiunge un nuovo apparato, presumo che la batteria è al 100%
        VRDeviceInitEntitie.setBatteryLevel(Constants.BATTERY_LEVEL_MAX);
        VRDeviceInitRepository.save(VRDeviceInitEntitie);
    }

    @Override
    public void updateInit(Utilities utilities, String macAddress, String oldMacAddress, String note, String paramCode){
            VRDeviceInitRepository.updateByMacAddress(macAddress,oldMacAddress,note, paramCode);
    }

    @Override
    public boolean valid(String macAddress, String code) {
        // apparato registrato
        if (iRepository.existsByMacAddress(macAddress)) {
            return true;
        }
        return false;
    }

    @Override
    public String label(String macAddress) {
        return iRepository.labelByMacAddress(macAddress);
    }


}
