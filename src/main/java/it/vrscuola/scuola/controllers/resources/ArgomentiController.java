/**
 * Copyright (c) 2023, Benedetto Pellerito
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

package it.vrscuola.scuola.controllers.resources;

import it.vrscuola.scuola.services.ArgomentiDirService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ArgomentiController {

    @Autowired
    ArgomentiDirService argomentiDirService;

    @GetMapping(value = "/argomenti/all", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<String>> getArgomentiAll(
            @RequestParam(name = "aula", defaultValue = "") String aula,
            @RequestParam(name = "classe", defaultValue = "") String classe,
            @RequestParam(name = "sezione", defaultValue = "") String sezione) {

        try {
            List<String> args = argomentiDirService.getArgomentiAll(aula, classe, sezione);
            return ResponseEntity.ok(args);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }

    }


}
