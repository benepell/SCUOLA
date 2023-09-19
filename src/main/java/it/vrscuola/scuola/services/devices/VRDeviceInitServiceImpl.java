/**
 * Copyright (c) 2023, Benedetto Pellerito
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package it.vrscuola.scuola.services.devices;

import it.vrscuola.scuola.entities.devices.VRDeviceInitEntitie;
import it.vrscuola.scuola.repositories.devices.VRDeviceInitRepository;
import it.vrscuola.scuola.utilities.Utilities;
import it.vrscuola.scuola.utilities.Constants;
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
    it.vrscuola.scuola.repositories.devices.VRDeviceInitRepository iRepository;

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
    public void updateBatteryLevel(String macAddress, int batteryLevel) {
        try{
            iRepository.updateBatteryLevel(macAddress, batteryLevel);
        } catch (Exception e){
            Log.error("Error updating battery level for device with mac address: " + macAddress + " and battery level: " + batteryLevel);
        }

    }

    @Override
    public String label(String macAddress) {
        return iRepository.labelByMacAddress(macAddress, Constants.BATTERY_LEVEL);
    }


}
