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

    @GetMapping("/_login")
    public RedirectView login(Authentication authentication, Principal principal, HttpSession session) {
        String redirectLogin = basename + "/_login";
        try {
            // Controlla se l'utente è autenticato con Keycloak
            String accessToken = kService.getAccessToken(authentication);

            if (accessToken != null) {

                // Controllo se l'utente appartiene al gruppo "admins"
                if (kService.hasRoleInAccessToken(accessToken,"admins")) {
                    // L'utente è autenticato e appartiene al gruppo "admins", esegui le azioni necessarie e reindirizzalo alla pagina desiderata
                    session.setAttribute("main_username", kService.getTokenAttribute(authentication,Constants.CLAIMS_PREF_USERNAME));
                    // logService.sendLog(session, Constants.EVENT_LOG_IN);
                    return new RedirectView("/abilita-classe");
                } else {
                    // L'utente è autenticato ma non appartiene al gruppo "admins", reindirizzalo alla pagina di logout
                    return new RedirectView("/_logout"); // puoi reindirizzarlo a una pagina di errore o di login a tua scelta
                }
            } else {
                // L'utente non è autenticato, reindirizzalo alla pagina di login di Keycloak
                session.removeAttribute("main_username");
                return new RedirectView("{authServerUrl}/realms/{realm}/protocol/openid-connect/auth?client_id={clientId}&redirect_uri={redirectLogin}&response_type=code");
            }
        } catch (Exception e) {
            // Si è verificato un errore, reindirizza l'utente alla pagina di login di Keycloak
            System.out.println(e.getMessage());
            return new RedirectView("{authServerUrl}/realms/{realm}/protocol/openid-connect/auth?client_id={clientId}&redirect_uri={redirectLogin}&response_type=code");
        }
    }


    @GetMapping("/_logout")
    public RedirectView logout(HttpServletRequest request, HttpServletResponse response , HttpSession session)  {

        // chiude tutti i visori prima del logout se viene richiesto dalla pagina di gestione della classe
        boolean closeVisors = session.getAttribute("isCloseVisorLogout") != null ? (Boolean) session.getAttribute("isCloseVisorLogout") : false;
        if (closeVisors) {
          // effettua la chiamata a chiudi i visori
            String[] username = session.getAttribute("username") != null ? (String[])session.getAttribute("username") : null;
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
        if (request != null){
            try {
                request.logout();
            } catch (ServletException e) {
                e.printStackTrace();
            }
        }

        return new RedirectView( uriLink + "/protocol/openid-connect/logout?redirecturi=" + basename);
    }

    @GetMapping("/test")
    public String test(HttpServletRequest request) throws ServletException {
        return "Successfully  admins";
    }

    @PostMapping("/checkRes")
    public String checkRes(@ModelAttribute("setupModel") RisorsePhpModel res, HttpSession session) {
        String param = res.getKey();
        if(session != null && param.equals("risorse")) {
            return "admins";
        }
        return "";
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
        userInfo.put("name", kService.getTokenAttribute(authentication,Constants.CLAIMS_NAME));
        userInfo.put("preferred_username", kService.getTokenAttribute(authentication,Constants.CLAIMS_PREF_USERNAME));
        userInfo.put("email", kService.getTokenAttribute(authentication,Constants.CLAIMS_EMAIL));
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