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

package org.duckdns.vrscuola.controllers.devices;

import jakarta.validation.Valid;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityArgRequest;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityConnectRequest;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityRequest;
import org.duckdns.vrscuola.payload.response.MessageResponse;
import org.duckdns.vrscuola.services.devices.VRDeviceConnectivityServiceImpl;
import org.duckdns.vrscuola.services.devices.VRDeviceInitServiceImpl;
import org.duckdns.vrscuola.services.utils.MessageServiceImpl;
import org.duckdns.vrscuola.services.utils.UtilServiceImpl;
import org.duckdns.vrscuola.utilities.Constants;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/connectivity-devices")
public class VRDeviceConnectivityController {

    @Value("${keycloak.credentials.secret}")
    private String code;

    @Autowired
    VRDeviceConnectivityServiceImpl cService;

    @Autowired
    VRDeviceInitServiceImpl iService;

    @Autowired
    Utilities utilities;

    @SuppressWarnings("unused")
    @Autowired
    private MessageServiceImpl messageServiceImpl;

    @Autowired
    UtilServiceImpl uService;

    @PostMapping(value = "/username")
    public ResponseEntity<?> username(@Valid VRDeviceConnectivityRequest request) {

        String mac = request.getMacAddress();

        // richiesta visore avvenuta aggiona il valore di eraOnline
        iService.updateOnline(mac);

        if (!cService.valid(request.getMacAddress(), request.getCode())) {
            return uService.responseMsgKo(ResponseEntity.badRequest(), messageServiceImpl.getMessage("connect.user.not.found"));
        }

        String username = cService.viewConnect(utilities, mac, request.getNote());

        return ResponseEntity.ok(new MessageResponse(username));

    }

    @PostMapping(value = "/connect")
    public ResponseEntity<?> connect(@Valid VRDeviceConnectivityConnectRequest request) {

        String username = request.getUsername();
        String macAddress = request.getMacAddress();
        String note = request.getNote();
        String code = request.getCode();
        int batteryLevel = request.getBatteryLevel();

        // dispositivo registrato
        if (!iService.valid(macAddress, code)) {
            return uService.responseMsgKo(ResponseEntity.badRequest(), messageServiceImpl.getMessage("init.add.device.not.connect"));
        }

        String usernameexist = cService.viewConnect(utilities, request.getMacAddress(), request.getNote());
        cService.connect(utilities, macAddress, username, note, Constants.CONNECTED_IN_CONNECTED);

        // aggiorna stato batteria dispositivo
        if (batteryLevel > 0) {
            iService.updateBatteryLevel(macAddress, batteryLevel);
        }

        // ritorna label visore
        String visore = iService.label(macAddress);

        return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.connect") + " [" + visore + "]"));
    }

    @PostMapping(value = "/subject")
    public ResponseEntity<?> subject(@Valid VRDeviceConnectivityArgRequest request) {

        String macAddress = request.getMacAddress();
        String code = request.getCode();
        int batteryLevel = request.getBatteryLevel();

        // dispositivo registrato
        if (!iService.valid(macAddress, code)) {
            return uService.responseMsgKo(ResponseEntity.badRequest(), messageServiceImpl.getMessage("init.add.device.not.connect"));
        }

        // aggiorna stato batteria dispositivo
        if (batteryLevel > 0) {
            iService.updateBatteryLevel(macAddress, batteryLevel);
        }

        // ritorna label visore
        String argoment = cService.argomento(macAddress);

        return ResponseEntity.ok(new MessageResponse(argoment));
    }

}
