/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.services.devices;

import org.duckdns.vrscuola.models.DeviceInfo;
import org.duckdns.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import org.duckdns.vrscuola.repositories.devices.VRDeviceInitRepository;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class VRDeviceConnectivityServiceImpl implements VRDeviceConnectivityService {

    @Value("${keycloak.credentials.secret}")
    private String code;

    @Autowired
    VRDeviceConnectivityRepository cRepository;

    @Autowired
    VRDeviceInitRepository iRepository;

    @Override
    public Map<String, String> viewConnect(Utilities utilities, String macAddress, String avatar) {
        Map<String, String> responseMap = new HashMap<>();
        responseMap.put("username", cRepository.existsUsername(macAddress));

        String strAvatar;
        if (avatar != null) {
            strAvatar = avatar;
            cRepository.updateAvatar(strAvatar, macAddress);
        } else {
            strAvatar = cRepository.findAvatar(macAddress);
        }

        String lab = iRepository.findLab(macAddress);

        responseMap.put("avatar", strAvatar);
        responseMap.put("lab", lab);

        return responseMap;
    }

    @Override
    public boolean valid(String macAddress) {
        // ultima condizione verificata allora true
        // collegamento professore aggionamento campo username in base a macaddress
        return cRepository.existsByMacAddress(macAddress);
    }


    @Override
    public boolean existsByMacAddress(String macAddress) {
        // apparato registrato
        return iRepository.existsByMacAddress(macAddress);

    }

    @Override
    public void connect(Utilities utilities, String macAddress, String username, String avatar, String connected) {
        cRepository.updateByMacAddress(utilities.getEpoch(), username, avatar, macAddress, connected);

    }

    @Override
    public String argomento(String argomento) {
        return cRepository.argomentByMacAddress(argomento);
    }

    @Override
    public List<DeviceInfo> getInfo(String mac) {
        List<Object[]> results = cRepository.findInfo(mac);
        DeviceInfo deviceInfo = new DeviceInfo();
        List<DeviceInfo> deviceInfos = new ArrayList<>();

        results.stream().forEach(result -> {
            String classroom = String.valueOf(result[0]);
            String username = String.valueOf(result[1]);
            String arg = result[2] != null ? String.valueOf(result[2]) : "";
            String lab = "lab" + classroom;

            String[] str = username.split("-");
            String classe = str[0];
            String sezione = str[1];

            deviceInfo.setLab(lab);
            deviceInfo.setUsername(username);
            deviceInfo.setClasse(classe);
            deviceInfo.setSezione(sezione);
            deviceInfo.setArg(arg);
        });

        return deviceInfos;
    }

}
