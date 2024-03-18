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

import org.duckdns.vrscuola.repositories.devices.VRDeviceConnectivityRepository;
import org.duckdns.vrscuola.repositories.devices.VRDeviceInitRepository;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.HashMap;
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
        responseMap.put("avatar", avatar != null ? avatar : cRepository.findAvatar(macAddress));
        return responseMap;
    }

    @Override
    public boolean valid(String macAddress) {
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
    public void connect(Utilities utilities, String macAddress, String username, String avatar, String connected) {
        cRepository.updateByMacAddress(utilities.getEpoch(), username, avatar, macAddress, connected);

    }

    @Override
    public String argomento(String argomento) {
        return cRepository.argomentByMacAddress(argomento);
    }
}
