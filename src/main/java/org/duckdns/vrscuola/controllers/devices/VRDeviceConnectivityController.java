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

package org.duckdns.vrscuola.controllers.devices;

import jakarta.validation.Valid;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityArgRequest;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityConnectRequest;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityRequest;
import org.duckdns.vrscuola.payload.response.MessageResponse;
import org.duckdns.vrscuola.services.devices.VRDeviceConnectivityServiceImpl;
import org.duckdns.vrscuola.services.devices.VRDeviceInitServiceImpl;
import org.duckdns.vrscuola.services.securities.KeycloakUserService;
import org.duckdns.vrscuola.services.utils.MessageServiceImpl;
import org.duckdns.vrscuola.services.utils.UtilServiceImpl;
import org.duckdns.vrscuola.utilities.Constants;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;


@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/connectivity-devices")
public class VRDeviceConnectivityController {


    private final String code;
    private final VRDeviceConnectivityServiceImpl cService;
    private final VRDeviceInitServiceImpl iService;
    private final Utilities utilities;
    private final MessageServiceImpl messageServiceImpl;
    private final UtilServiceImpl uService;

    private final KeycloakUserService kService;

    @Autowired
    public VRDeviceConnectivityController(@Value("${keycloak.credentials.secret}") String code,
                                          VRDeviceConnectivityServiceImpl cService,
                                          VRDeviceInitServiceImpl iService,
                                          Utilities utilities,
                                          MessageServiceImpl messageServiceImpl,
                                          UtilServiceImpl uService,
                                          KeycloakUserService kService) {
        this.code = code;
        this.cService = cService;
        this.iService = iService;
        this.utilities = utilities;
        this.messageServiceImpl = messageServiceImpl;
        this.uService = uService;
        this.kService = kService;
    }

    @PostMapping(value = "/username")
    public ResponseEntity<?> username(@Valid VRDeviceConnectivityRequest request) {

        String mac = request.getMacAddress();
        String batteryLevel = request.getBatteryLevel();
        String avatar = request.getAvatar() != null ? request.getAvatar() : "";
        Map<String, String> responseMap = new HashMap<>();
        responseMap.put("username", "");
        responseMap.put("sec", "");
        responseMap.put("avatar", avatar);

        // richiesta visore avvenuta aggiona il valore di eraOnline
        iService.updateOnline(mac, batteryLevel);
        if (mac == null) {
            responseMap.put("state",Constants.STATE_NOT_FOUND);
            return ResponseEntity.ok(responseMap);
        }

        if (!cService. existsByMacAddress(mac)) {
            responseMap.put("state",Constants.STATE_NOT_LISTED);
            return ResponseEntity.ok(responseMap);
        }

        if (!cService.valid(mac)) {
            responseMap.put("state",Constants.STATE_NOT_USED);
            return ResponseEntity.ok(responseMap);
        }

        Map<String, String> map;

        map = cService.viewConnect(utilities, mac, request.getAvatar());
        String userMap = null;
        String avatarMap = null;

        // disabilita visore
        if (map == null) {
            responseMap.put("state",Constants.STATE_KO);
            return ResponseEntity.ok(responseMap);
        }

        userMap = map.get("username").toString();
        avatarMap = map.get("avatar") != null ? map.get("avatar").toString() : "";

        responseMap.put("avatar", avatarMap);
        responseMap.put("username", userMap);
        responseMap.put("sec", this.code);
        responseMap.put("state",Constants.STATE_OK);

        return ResponseEntity.ok(responseMap);

    }

    @PostMapping(value = "/connect")
    public ResponseEntity<?> connect(@Valid VRDeviceConnectivityConnectRequest request) {

        String username = request.getUsername();
        String macAddress = request.getMacAddress();
        String note = request.getNote();
        String code = request.getCode();
        String batteryLevel = request.getBatteryLevel();

        // dispositivo registrato
        if (!iService.valid(macAddress, code)) {
            return uService.responseMsgKo(ResponseEntity.badRequest(), messageServiceImpl.getMessage("init.add.device.not.connect"));
        }

        Map<String, String> map = cService.viewConnect(utilities, request.getMacAddress(), request.getNote());
        boolean usernameexist = map != null ? map.get("username").toString().length() > 3 : false;

        if (!usernameexist) {
            return uService.responseMsgKo(ResponseEntity.badRequest(), messageServiceImpl.getMessage("init.add.device.not.connect"));
        }

        cService.connect(utilities, macAddress, username, note, Constants.CONNECTED_IN_CONNECTED);

        // aggiorna stato batteria dispositivo
        // if (batteryLevel > 0) {
        iService.updateBatteryLevel(macAddress, batteryLevel);
        // }

        // ritorna label visore
        String visore = iService.label(macAddress);

        return ResponseEntity.ok(new MessageResponse(messageServiceImpl.getMessage("init.add.device.connect") + " [" + visore + "]"));
    }

    @PostMapping(value = "/subject")
    public ResponseEntity<?> subject(@Valid VRDeviceConnectivityArgRequest request, @RequestHeader("Authorization") String authorizationHeader) {

        String accessToken = null;
        String res = "";

        if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
            accessToken = authorizationHeader.substring(7); // Rimuovi "Bearer " per ottenere solo il token

            if (accessToken != null && kService.isAccessTokenValid(accessToken)) {

                // token valido
                String macAddress = request.getMacAddress();

                // ritorna label visore
                res = cService.argomento(macAddress);
            }
        }

        return ResponseEntity.ok(new MessageResponse(res));
    }

}
