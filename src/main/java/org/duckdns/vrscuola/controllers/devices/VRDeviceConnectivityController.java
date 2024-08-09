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
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityArgRequest;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityConnectRequest;
import org.duckdns.vrscuola.payload.request.VRDeviceConnectivityRequest;
import org.duckdns.vrscuola.payload.response.MessageResponse;
import org.duckdns.vrscuola.services.config.SessionDBService;
import org.duckdns.vrscuola.services.devices.VRDeviceConnectivityServiceImpl;
import org.duckdns.vrscuola.services.devices.VRDeviceInitServiceImpl;
import org.duckdns.vrscuola.services.securities.KeycloakUserService;
import org.duckdns.vrscuola.services.utils.MessageServiceImpl;
import org.duckdns.vrscuola.services.utils.UtilServiceImpl;
import org.duckdns.vrscuola.utilities.Constants;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
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
    private final SessionDBService sService;
    private final KeycloakUserService kService;

    private static final Logger Log = LogManager.getLogger(VRDeviceConnectivityController.class.getName());

    @Autowired
    public VRDeviceConnectivityController(@Value("${keycloak.credentials.secret}") String code,
                                          VRDeviceConnectivityServiceImpl cService,
                                          VRDeviceInitServiceImpl iService,
                                          Utilities utilities,
                                          MessageServiceImpl messageServiceImpl,
                                          UtilServiceImpl uService, SessionDBService sService,
                                          KeycloakUserService kService) {
        this.code = code;
        this.cService = cService;
        this.iService = iService;
        this.utilities = utilities;
        this.messageServiceImpl = messageServiceImpl;
        this.uService = uService;
        this.sService = sService;
        this.kService = kService;
    }

    @PostMapping(value = "/username")
    public ResponseEntity<?> username(@Valid VRDeviceConnectivityRequest request) {

        String mac = request.getMacAddress();
        String batteryLevel = request.getBatteryLevel();
        String avatar = request.getAvatar() != null ? request.getAvatar() : "";
        String lab = sService.getLab();
        Map<String, String> responseMap = new HashMap<>();
        responseMap.put("username", "");
        responseMap.put("sec", "");
        responseMap.put("avatar", avatar);
        responseMap.put("lab", lab);


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

        userMap = map.get("username") != null ? map.get("username").toString() : "";
        avatarMap = map.get("avatar") != null ? map.get("avatar").toString() : "";
/*
        if (userMap == "" || userMap == null) {
            responseMap.put("state", Constants.STATE_NOT_USED);
            return ResponseEntity.ok(responseMap);
        }
*/
        responseMap.put("avatar", avatarMap);
        responseMap.put("username", userMap);
        responseMap.put("sec", this.code);
        responseMap.put("state", Constants.STATE_OK);
        responseMap.put("lab", lab);

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

        try {
            Log.info("Received request for subject endpoint");

            // Verifica che l'header di autorizzazione non sia nullo e inizi con "Bearer "
            if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
                accessToken = authorizationHeader.substring(7); // Rimuovi "Bearer " per ottenere solo il token
                Log.info("Authorization header is valid");
            } else {
                Log.error("Invalid or missing Authorization header");
                throw new InvalidAuthorizationHeaderException("Authorization header is missing or invalid");
            }

            // Verifica che l'access token non sia nullo e sia valido
            if (accessToken != null && kService.isAccessTokenValid(accessToken)) {
                Log.info("Access token is valid");
                String macAddress = request.getMacAddress();

                // Verifica che l'indirizzo MAC non sia nullo o vuoto
                if (macAddress != null && !macAddress.isEmpty()) {
                    Log.info("MAC address is valid");
                    res = cService.argomento(macAddress);
                    Log.info("Successfully retrieved argument for MAC address");
                } else {
                    Log.error("MAC address is missing or empty");
                    throw new InvalidMacAddressException("MAC address is missing or empty");
                }
            } else {
                Log.error("Invalid or expired access token");
                throw new InvalidAccessTokenException("Access token is invalid or expired");
            }

            return ResponseEntity.ok(new MessageResponse(res));
        } catch (InvalidAuthorizationHeaderException | InvalidAccessTokenException | InvalidMacAddressException e) {
            Log.warn("Client error: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ErrorResponse(e.getMessage()));
        } catch (Exception e) {
            Log.error("An unexpected error occurred", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ErrorResponse("An unexpected error occurred"));
        }
    }

    // Eccezioni personalizzate
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    class InvalidAuthorizationHeaderException extends RuntimeException {
        public InvalidAuthorizationHeaderException(String message) {
            super(message);
        }
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    class InvalidAccessTokenException extends RuntimeException {
        public InvalidAccessTokenException(String message) {
            super(message);
        }
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    class InvalidMacAddressException extends RuntimeException {
        public InvalidMacAddressException(String message) {
            super(message);
        }
    }

    // Classi di risposta
    class MessageResponse {
        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        private String message;

        public MessageResponse(String message) {
            this.message = message;
        }

    }

    class ErrorResponse {
        public String getError() {
            return error;
        }

        public void setError(String error) {
            this.error = error;
        }

        private String error;

        public ErrorResponse(String error) {
            this.error = error;
        }
    }


}
