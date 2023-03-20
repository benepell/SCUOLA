package online.vrscuola.controllers.securities;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import online.vrscuola.services.securities.KeycloakCredentialService;
import online.vrscuola.services.securities.KeycloakServiceBridge;
import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.keycloak.representations.AccessToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
public class KeycloakUserController {

    @Value("${keycloak.resource}")
    private String resource;

    @Autowired
    private KeycloakServiceBridge keycloakService;

    @Autowired
    KeycloakCredentialService kService;

    @GetMapping("/keycloak-users")
    @Cacheable(value = "keycloakUserInfos", key = "#username")
    public ResponseEntity<Object> getKeycloakUsers(Principal principal) {

        KeycloakAuthenticationToken token = (KeycloakAuthenticationToken) principal;
        AccessToken accessToken = token.getAccount().getKeycloakSecurityContext().getToken();
        String username = accessToken.getPreferredUsername();

        String otp = kService.generateKeycloakBridgeCredentials(resource,username);

        String userInfos = keycloakService.getKeycloakUserInfos(username,otp).toString();
        ObjectMapper objectMapper = new ObjectMapper();
        Object json;
        try {
            json = objectMapper.readValue(userInfos, Object.class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return new ResponseEntity<>(json, HttpStatus.OK);
    }
}
