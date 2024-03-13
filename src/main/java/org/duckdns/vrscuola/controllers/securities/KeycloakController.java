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

package org.duckdns.vrscuola.controllers.securities;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.duckdns.vrscuola.models.RisorsePhpModel;
import org.duckdns.vrscuola.services.StudentService;
import org.duckdns.vrscuola.services.devices.VRDeviceManageDetailService;
import org.duckdns.vrscuola.services.log.EventLogService;
import org.duckdns.vrscuola.services.pdf.UsoVisorePdfService;
import org.duckdns.vrscuola.services.securities.KeycloakUserService;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.util.*;
import java.util.stream.Collectors;

@RestController
public class KeycloakController {


    private final String authServerUrl;
    private final String realm;
    private final String clientId;
    private final String clientSecret;
    private final String basename;
    private final String uriLink;
    private final EventLogService logService;
    private final StudentService studentService;
    private final UsoVisorePdfService vPdfService;
    private final VRDeviceManageDetailService manageDetailService;
    private final KeycloakUserService kService;

    @Autowired
    public KeycloakController(@Value("${keycloak.auth-server-url}") String authServerUrl,
                              @Value("${keycloak.realm}") String realm,
                              @Value("${keycloak.resource}") String clientId,
                              @Value("${keycloak.credentials.secret}") String clientSecret,
                              @Value("${basename}") String basename,
                              @Value("${spring.security.oauth2.client.provider.external.issuer-uri}") String uriLink,
                              EventLogService logService,
                              StudentService studentService,
                              UsoVisorePdfService vPdfService,
                              VRDeviceManageDetailService manageDetailService,
                              KeycloakUserService kService) {
        this.authServerUrl = authServerUrl;
        this.realm = realm;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.basename = basename;
        this.uriLink = uriLink;
        this.logService = logService;
        this.studentService = studentService;
        this.vPdfService = vPdfService;
        this.manageDetailService = manageDetailService;
        this.kService = kService;
    }

    @GetMapping("/_logout")
    public RedirectView logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws UnsupportedEncodingException, UnsupportedEncodingException {

        // lasciare qui perchè dopo viene invalidata
        String idTokenHint = null;
        if (session.getAttribute("idToken") != null) {
            idTokenHint = (String) session.getAttribute("idToken");
        }

        // chiude tutti i visori prima del logout se viene richiesto dalla pagina di gestione della classe
        boolean closeVisors = session.getAttribute("isCloseVisorLogout") != null ? (Boolean) session.getAttribute("isCloseVisorLogout") : false;
        if (closeVisors) {
            // effettua la chiamata a chiudi i visori
            String[] username = session.getAttribute("username") != null ? (String[]) session.getAttribute("username") : null;
            if (session != null &&
                    username != null && username.length > 0) {
                // stampa tutti gli utenti che hanno un visore per chiudere la sessione
                try {
                    vPdfService.save();
                } catch (IOException e) {
                    e.printStackTrace();
                }

                // chiude tutti i visori
                studentService.closeAllVisor(username, manageDetailService, session);

                logService.sendLog(session, Constants.EVENT_LOG_OUT);
                session.invalidate();
            }
        }
        // Invalida la sessione
        if (request.getSession(false) != null) {
            request.getSession().invalidate();
        }

        // Cancella i cookie
        Cookie cookie = new Cookie("JSESSIONID", null);
        cookie.setPath(request.getContextPath());
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        if (request != null) {
            try {
                request.logout();
            } catch (ServletException e) {
                e.printStackTrace();
            }
        }

        // Controlla se l'idTokenHint è stato recuperato correttamente
        if (idTokenHint == null || idTokenHint.isEmpty()) {
            // Gestisci l'errore: l'idTokenHint non è disponibile
            // Potresti reindirizzare l'utente a una pagina di errore o registrare l'errore.
            return new RedirectView("/error"); // Sostituire con il percorso appropriato
        }

        // Prepara l'URL per il logout di Keycloak
        String logoutUrl = uriLink + "/protocol/openid-connect/logout"
                + "?id_token_hint=" + URLEncoder.encode(idTokenHint, StandardCharsets.UTF_8.name())
                + "&post_logout_redirect_uri=" + URLEncoder.encode(basename, StandardCharsets.UTF_8.name());

        // Esegui il redirect alla richiesta di logout di Keycloak
        return new RedirectView(logoutUrl);

    }

    @GetMapping("/test")
    public String test(HttpServletRequest request) throws ServletException {
        return "Successfully  admins";
    }

    @GetMapping("/test1")
    public String test1(HttpServletRequest request) throws ServletException {
        return "Successfully  users";
    }

    // A new endpoint to get the user's information in JSON format
    @GetMapping("/userinfo")
    public Map<String, Object> getUserInfo(Authentication authentication, Principal principal, HttpSession session, HttpServletRequest request) {

        // Create a map to hold the user's information
        Map<String, Object> userInfo = new HashMap<>();
        String accessToken = null;
        List<String> listRoles = null;

        if (authentication != null) {
            accessToken = kService.getAccessToken(authentication);

            listRoles = kService.getRolesFromAccessToken(accessToken);

            userInfo.put("name", kService.getTokenAttribute(authentication, Constants.CLAIMS_NAME));
            userInfo.put("preferred_username", kService.getTokenAttribute(authentication, Constants.CLAIMS_PREF_USERNAME));
            userInfo.put("email", kService.getTokenAttribute(authentication, Constants.CLAIMS_EMAIL));

            if (listRoles != null) {
                userInfo.put("roles", listRoles);
                Map<String, Set<String>> resourceRoles = new HashMap<>();
                listRoles.forEach(role -> {
                    // Assumi che ogni ruolo corrisponda a una risorsa specifica
                    // e aggiungilo a un Set di ruoli associati a quella risorsa
                    resourceRoles.computeIfAbsent(role, k -> new HashSet<>()).add(role);
                });
                userInfo.put("resource_roles", resourceRoles);

            }

        } else {
            String authorizationHeader = request.getHeader("Authorization");

            if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
                accessToken = authorizationHeader.substring(7); // Rimuovi "Bearer " per ottenere solo il token
            }

            if (accessToken != null) {
                Map<String, Object> claims = kService.getUserInfoFromAccessToken(accessToken);

                // Ottieni informazioni base dell'utente
                String name = (String) claims.getOrDefault("name", "");
                String preferredUsername = (String) claims.getOrDefault("preferred_username", "");
                String email = (String) claims.getOrDefault("email", "");

                userInfo.put("name", name);
                userInfo.put("preferred_username", preferredUsername);
                userInfo.put("email", email);

                // Ottieni i ruoli
                Map<String, Object> realmAccess = (Map<String, Object>) claims.get("realm_access");
                List<String> roles = realmAccess != null && realmAccess.containsKey("roles")
                        ? (List<String>) realmAccess.get("roles")
                        : Collections.emptyList();

                userInfo.put("roles", roles);

                Map<String, Set<String>> resourceRoles = new HashMap<>();
                roles.forEach(role -> {
                    resourceRoles.computeIfAbsent(role, k -> new HashSet<>()).add(role);
                });
                userInfo.put("resource_roles", resourceRoles);

            }

        }

        logService.sendLog(session, Constants.EVENT_LOG_CHECK_INFO);

        return userInfo;
    }


}