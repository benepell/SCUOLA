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

import org.duckdns.vrscuola.services.securities.KeycloakUserService;
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

    @GetMapping({"/keycloak-users", "/keycloak-users/{filter:filter}", "/keycloak-users/{filter:filter}/{classe}", "/keycloak-users/{filter:filter}/{classe}/{sezione}"})
    @Cacheable("usersCache")
    public List<Map<String, String>> getUsers(@PathVariable(required = false) String filter, @PathVariable(required = false) String classe, @PathVariable(required = false) String sezione) {
        return keycloakUserService.getUsers(filter, classe, sezione);
    }
}
