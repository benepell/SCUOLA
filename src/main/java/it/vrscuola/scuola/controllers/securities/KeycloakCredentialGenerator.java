package it.vrscuola.scuola.controllers.securities;

import it.vrscuola.scuola.payload.response.KeycloakCredentialResponse;
import it.vrscuola.scuola.services.securities.KeycloakCredentialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KeycloakCredentialGenerator
{
    @Value("${keycloak.resource}")
    private String resource;

    @Autowired
    KeycloakCredentialService kService;

    @GetMapping("/generate-keycloak-credentials/{username}")
    public ResponseEntity<KeycloakCredentialResponse> generateKeycloakCredentials(@PathVariable String username)
    {
        String password = kService.generateKeycloakCredentials(resource,username);
        KeycloakCredentialResponse response = new KeycloakCredentialResponse(password, username);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}