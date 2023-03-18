package online.vrscuola.services.devices;

import online.vrscuola.entities.devices.VRDeviceInitEntitie;
import online.vrscuola.repositories.devices.VRDeviceInitRepository;
import online.vrscuola.utilities.Utilities;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VRDeviceInitServiceImpl implements VRDeviceInitService {

    private static final Logger Log = LogManager.getLogger(VRDeviceInitServiceImpl.class.getName());

    @Autowired
    VRDeviceInitRepository VRDeviceInitRepository;

    @Override
    public void addInit(Utilities utilities, String macAddress, String label){
        VRDeviceInitEntitie VRDeviceInitEntitie = new VRDeviceInitEntitie();
        VRDeviceInitEntitie.setMacAddress(macAddress);
        VRDeviceInitEntitie.setInitDate(utilities.getEpoch());
        VRDeviceInitRepository.save(VRDeviceInitEntitie);
    }

    @Override
    public void updateInit(Utilities utilities, String macAddress, String label ,String oldMacAddress, String note) {
        VRDeviceInitRepository.updateByMacAddress(macAddress,oldMacAddress,note);
    }

}
