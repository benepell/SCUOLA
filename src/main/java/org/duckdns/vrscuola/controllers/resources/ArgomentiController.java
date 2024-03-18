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

package org.duckdns.vrscuola.controllers.resources;

import org.duckdns.vrscuola.services.ArgomentiDirService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ArgomentiController {

    private final ArgomentiDirService argomentiDirService;

    @Autowired
    public ArgomentiController(ArgomentiDirService argomentiDirService) {
        this.argomentiDirService = argomentiDirService;
    }

    @GetMapping(value = "/argomenti/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> getArgomentiAll(
            @RequestParam(name = "lab", defaultValue = "") String lab,
            @RequestParam(name = "classe", defaultValue = "") String classe,
            @RequestParam(name = "sezione", defaultValue = "") String sezione) {

        try {
            List<String> args = argomentiDirService.getArgomentiAll(lab, classe, sezione);
            Map<String, Object> argsMap = new HashMap<>();
            argsMap.put("message", args);

            return ResponseEntity.ok(argsMap);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


}
