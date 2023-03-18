package online.vrscuola.controllers.securities;

import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.keycloak.representations.AccessToken;
import org.keycloak.representations.account.UserRepresentation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.reactive.function.client.WebClient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
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

    @GetMapping("/homepage")
    public String homepage(Principal principal) {
        KeycloakAuthenticationToken token = (KeycloakAuthenticationToken) principal;
        AccessToken accessToken = token.getAccount().getKeycloakSecurityContext().getToken();
        return  "Welcome to homepage, " + accessToken.getPreferredUsername() + " successfully logged in";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) throws ServletException {
        request.logout();
        return "Successfully logged out";
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
    public Map<String, Object> getUserInfo(Principal principal) {
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

        return userInfo;
    }


}