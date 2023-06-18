package it.vrscuola.scuola.controllers.securities;

import it.vrscuola.scuola.services.securities.KeycloakUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
public class KeycloakUserController {

    private final KeycloakUserService keycloakUserService;

    @Autowired
    public KeycloakUserController(KeycloakUserService keycloakUserService) {
        this.keycloakUserService = keycloakUserService;
    }

    @GetMapping({"/keycloak-users","/keycloak-users/{filter:filter}","/keycloak-users/{filter:filter}/{classe}", "/keycloak-users/{filter:filter}/{classe}/{sezione}"})
    @Cacheable("usersCache")
    public List<Map<String, String>> getUsers(@PathVariable(required = false) String filter, @PathVariable(required = false) String classe, @PathVariable(required = false) String sezione) {
        return keycloakUserService.getUsers(filter, classe, sezione);
    }
}
