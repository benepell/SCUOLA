package online.vrscuola.controllers.securities;

import online.vrscuola.models.RisorsePhpModel;
import online.vrscuola.models.SetupModel;
import online.vrscuola.services.log.EventLogService;
import online.vrscuola.utilities.Constants;
import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.keycloak.representations.AccessToken;
import org.keycloak.representations.account.UserRepresentation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
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

    @Autowired
    EventLogService logService;

    @GetMapping("/sso/login")
    public RedirectView ssoLogin() {
        return new RedirectView("/abilita-classe");
    }

    @GetMapping("/login")
    public RedirectView login(Principal principal, HttpSession session) {
        try{
            KeycloakAuthenticationToken token = (KeycloakAuthenticationToken) principal;
            AccessToken accessToken = token.getAccount().getKeycloakSecurityContext().getToken();
            if (accessToken != null) {
                session.setAttribute("main_username", accessToken.getPreferredUsername());
                logService.sendLog(session, Constants.EVENT_LOG_IN);
                return new RedirectView("/abilita-classe");
            } else {
                session.removeAttribute("main_username");
                return new RedirectView("/logout");
            }
        } catch (Exception e) {
            return new RedirectView("/login");
        }

    }

    @GetMapping("/logout")
    public RedirectView logout(HttpServletRequest request, HttpSession session) throws ServletException {
        logService.sendLog(session, Constants.EVENT_LOG_OUT);
        if (session != null){
            session.invalidate();
        }
        request.logout();
        return new RedirectView("/");
    }

    @GetMapping("/test")
    public String test(HttpServletRequest request) throws ServletException {
        return "Successfully  admins";
    }

    @PostMapping("/checkRes")
    public String checkRes(@ModelAttribute("setupModel") RisorsePhpModel res, HttpSession session) {
        String param = res.getKey();
        if(param.equals("risorse")) {
            logService.sendLog(session, Constants.EVENT_LOG_CHECK_RES);
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