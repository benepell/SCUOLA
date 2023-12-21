/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
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

package org.duckdns.vrscuola.services.devices;

import org.duckdns.vrscuola.entities.devices.VRDeviceInitEntitie;
import org.duckdns.vrscuola.repositories.devices.VRDeviceInitRepository;
import org.duckdns.vrscuola.utilities.Utilities;
import org.duckdns.vrscuola.utilities.Constants;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Service
public class VRDeviceInitServiceImpl implements VRDeviceInitService {

    private static final Logger Log = LogManager.getLogger(VRDeviceInitServiceImpl.class.getName());


    @Value("${keycloak.credentials.secret}")
    private String code;

    @Autowired
    VRDeviceInitRepository iRepository;

    @Autowired
    VRDeviceInitRepository VRDeviceInitRepository;

    @Autowired
    Utilities utilities;

    @Override
    public void addInit(Utilities utilities, String macAddress, String note, String paramCode, String classroom){
        VRDeviceInitEntitie VRDeviceInitEntitie = new VRDeviceInitEntitie();
        VRDeviceInitEntitie.setMacAddress(macAddress);
        VRDeviceInitEntitie.setInitDate(utilities.getEpoch());
        String label = String.valueOf(iRepository.getCount() > 0 ? iRepository.getNextAvailableId(): 1);
        VRDeviceInitEntitie.setLabel(label);
        VRDeviceInitEntitie.setNote(note);
        VRDeviceInitEntitie.setCode(paramCode);
        VRDeviceInitEntitie.setClassroom(classroom);
        // quando si aggiunge un nuovo apparato, presumo che la batteria è al 100%
        VRDeviceInitEntitie.setBatteryLevel(Constants.BATTERY_LEVEL_MAX);
        VRDeviceInitRepository.save(VRDeviceInitEntitie);
    }

    @Override
    public void updateInit(Utilities utilities, String macAddress, String oldMacAddress, String note, String paramCode, String classroom){
        VRDeviceInitRepository.updateByMacAddress(macAddress,oldMacAddress,note, paramCode, classroom);
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

    @Override
    public void updateOnline(String macAddress) {
        Instant eraOnline = utilities.getEpoch();
        iRepository.updateEraOnline(macAddress, eraOnline);
    }
    @Override
    public List<Boolean> isOnline(String macAddresses) {
        String[] addresses = macAddresses.split(",");
        List<Boolean> results = new ArrayList<>();

        for (String macAddress : addresses) {
            Instant timestamp = iRepository.findEraOnlineByMacAddress(macAddress.trim());
            boolean isOnline = (timestamp != null) ? utilities.isExpired(timestamp, Constants.MIN_ONLINE_ERA) : false;
            results.add(isOnline);
        }

        return results;
    }

    @Override
    public List<String> strOnline(List<String> labels, String classroom) {
        List<String> results = new ArrayList<>();

        for (String label : labels) {
            String macAddress = iRepository.findMac(label);
            Instant timestamp = iRepository.findEraOnlineByMacAddress(macAddress.trim());
            boolean isOnline = (timestamp != null) ? utilities.isExpired(timestamp, Constants.MIN_ONLINE_ERA) : false;
            if (isOnline) {
                results.add(label);
            }
        }

        return results;
    }

}
