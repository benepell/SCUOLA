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

package org.duckdns.vrscuola.controllers.base;

import org.duckdns.vrscuola.services.config.SessionDBService;
import org.duckdns.vrscuola.services.securities.KeycloakUserService;
import org.duckdns.vrscuola.services.securities.ValidateCredentialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/classe")
public class ClasseController {

    private final KeycloakUserService keycloakUserService;
    private final ValidateCredentialService validateCredentialService;

    private final SessionDBService sService;

    @Autowired
    public ClasseController(KeycloakUserService keycloakUserService, ValidateCredentialService validateCredentialService, SessionDBService sService) {
        this.keycloakUserService = keycloakUserService;
        this.validateCredentialService = validateCredentialService;
        this.sService = sService;
    }

    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected) throws Exception {
        sService.setAttribute("classSelected", classSelected);
        sService.setAttribute("allSections", keycloakUserService.filterClasses(classSelected));
        return "redirect:/abilita-sezione";
    }

}

