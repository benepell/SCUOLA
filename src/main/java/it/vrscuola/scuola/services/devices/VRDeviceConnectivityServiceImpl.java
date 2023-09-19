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

import it.vrscuola.scuola.repositories.devices.VRDeviceConnectivityRepository;
import it.vrscuola.scuola.repositories.devices.VRDeviceInitRepository;
import it.vrscuola.scuola.utilities.Utilities;
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
    public void connect(Utilities utilities, String macAddress, String username, String note, String connected) {
            cRepository.updateByMacAddress(utilities.getEpoch(), username, note, macAddress, connected);

    }

    @Override
    public String argomento(String argomento) {
        return cRepository.argomentByMacAddress(argomento);
    }
}
