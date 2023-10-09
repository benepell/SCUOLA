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

package it.vrscuola.scuola.controllers.securities;

import it.vrscuola.scuola.models.RisorsePhpModel;
import it.vrscuola.scuola.services.StudentService;
import it.vrscuola.scuola.services.devices.VRDeviceManageDetailService;
import it.vrscuola.scuola.services.log.EventLogService;
import it.vrscuola.scuola.services.pdf.UsoVisorePdfService;
import it.vrscuola.scuola.utilities.Constants;
import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.keycloak.representations.AccessToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
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

    @Autowired
    EventLogService logService;

    @Autowired
    StudentService studentService;

    @Autowired
    UsoVisorePdfService vPdfService;

    @Autowired
    VRDeviceManageDetailService manageDetailService;

    @RequestMapping("/sso/login")
    public RedirectView ssoLogin() {
        // Esegui il redirect alla abilita-classe se si verifica l'errore 401
        return new RedirectView("/login");
    }

    @GetMapping("/login")
    public RedirectView login(Principal principal, HttpSession session) {
        String redirectLogin = basename + "/login";
        try {
            // Controlla se l'utente è autenticato con Keycloak
            KeycloakAuthenticationToken token = (KeycloakAuthenticationToken) principal;
            AccessToken accessToken = token.getAccount().getKeycloakSecurityContext().getToken();

            if (accessToken != null) {

                // Controllo se l'utente appartiene al gruppo "admins"
                if (accessToken.getRealmAccess().isUserInRole("admins")) {
                    // L'utente è autenticato e appartiene al gruppo "admins", esegui le azioni necessarie e reindirizzalo alla pagina desiderata
                    session.setAttribute("main_username", accessToken.getPreferredUsername());
                    logService.sendLog(session, Constants.EVENT_LOG_IN);
                    return new RedirectView("/abilita-classe");
                } else {
                    // L'utente è autenticato ma non appartiene al gruppo "admins", reindirizzalo alla pagina di logout
                    return new RedirectView("/logout"); // puoi reindirizzarlo a una pagina di errore o di login a tua scelta
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


    @GetMapping("/logout")
    public RedirectView logout(HttpServletRequest request, HttpSession session)  {

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
        if (request != null){
            try {
                request.logout();
            } catch (ServletException e) {
                e.printStackTrace();
            }
        }

        return new RedirectView("/");
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
    public Map<String, Object> getUserInfo(Principal principal, HttpSession session) {
        KeycloakAuthenticationToken token = (KeycloakAuthenticationToken) principal;
        AccessToken accessToken = token.getAccount().getKeycloakSecurityContext().getToken();

        // Create a map to hold the user's information
        Map<String, Object> userInfo = new HashMap<>();
        userInfo.put("name", accessToken.getName());
        userInfo.put("preferred_username", accessToken.getPreferredUsername());
        userInfo.put("email", accessToken.getEmail());
        userInfo.put("roles", accessToken.getRealmAccess().getRoles().stream().collect(Collectors.toList()));

        // Get the user's resource roles
        Map<String, Set<String>> resourceRoles = new HashMap<>();
        accessToken.getResourceAccess().forEach((k, v) -> {
            if (v != null) {
                resourceRoles.put(k, v.getRoles());
            }
        });
        userInfo.put("resource_roles", resourceRoles);

        logService.sendLog(session, Constants.EVENT_LOG_CHECK_INFO);

        return userInfo;
    }


}