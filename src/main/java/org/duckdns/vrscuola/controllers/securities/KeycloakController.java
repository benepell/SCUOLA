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

    @Value("${keycloak.auth-server-url}")
    private String authServerUrl;

    @Value("${keycloak.realm}")
    private String realm;

    @Value("${keycloak.resource}")
    private String clientId;

    @Value("${keycloak.credentials.secret}")
    private String clientSecret;

    @Value("${basename}")
    private String basename;

    @Value("${spring.security.oauth2.client.provider.external.issuer-uri}")
    private String uriLink;

    @Autowired
    EventLogService logService;

    @Autowired
    StudentService studentService;

    @Autowired
    UsoVisorePdfService vPdfService;

    @Autowired
    VRDeviceManageDetailService manageDetailService;

    @Autowired
    KeycloakUserService kService;


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
    public Map<String, Object> getUserInfo(Authentication authentication, Principal principal, HttpSession session) {
        String accessToken = kService.getAccessToken(authentication);

        // Create a map to hold the user's information
        Map<String, Object> userInfo = new HashMap<>();

        List<String> listRoles = kService.getRolesFromAccessToken(accessToken);
        userInfo.put("name", kService.getTokenAttribute(authentication, Constants.CLAIMS_NAME));
        userInfo.put("preferred_username", kService.getTokenAttribute(authentication, Constants.CLAIMS_PREF_USERNAME));
        userInfo.put("email", kService.getTokenAttribute(authentication, Constants.CLAIMS_EMAIL));
        userInfo.put("roles", listRoles);


        // Get the user's resource roles
        // Get the user's resource roles
        Map<String, Set<String>> resourceRoles = new HashMap<>();
        listRoles.forEach(role -> {
            // Assumi che ogni ruolo corrisponda a una risorsa specifica
            // e aggiungilo a un Set di ruoli associati a quella risorsa
            resourceRoles.computeIfAbsent(role, k -> new HashSet<>()).add(role);
        });
        userInfo.put("resource_roles", resourceRoles);

        logService.sendLog(session, Constants.EVENT_LOG_CHECK_INFO);

        return userInfo;
    }


}