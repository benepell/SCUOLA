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