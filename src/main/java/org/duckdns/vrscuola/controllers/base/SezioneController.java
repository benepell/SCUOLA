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

import org.duckdns.vrscuola.services.ArgomentiDirService;
import org.duckdns.vrscuola.services.StudentService;
import org.duckdns.vrscuola.services.config.SessionDBService;
import org.duckdns.vrscuola.services.devices.VRDeviceManageDetailService;
import org.duckdns.vrscuola.services.devices.VRDeviceManageService;
import org.duckdns.vrscuola.services.devices.VRDeviceManagerOrderService;
import org.duckdns.vrscuola.services.securities.KeycloakUserService;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Arrays;

@Controller
@RequestMapping("/sezione")
public class SezioneController {

    private final KeycloakUserService keycloakUserService;
    private final ArgomentiDirService argomentiDirService;
    private final VRDeviceManagerOrderService orderService;
    private final VRDeviceManageDetailService detailService;
    private final StudentService studentService;
    private final VRDeviceManageService manageService;
    private final SessionDBService sService;

    @Autowired
    public SezioneController(KeycloakUserService keycloakUserService, ArgomentiDirService argomentiDirService,
                             VRDeviceManagerOrderService orderService, VRDeviceManageDetailService detailService,
                             StudentService studentService, VRDeviceManageService manageService, SessionDBService sService) {
        this.keycloakUserService = keycloakUserService;
        this.argomentiDirService = argomentiDirService;
        this.orderService = orderService;
        this.detailService = detailService;
        this.studentService = studentService;
        this.manageService = manageService;
        this.sService = sService;
    }


    @PostMapping
    public String handleClasseSelection(@RequestParam("classSelected") String classSelected, @RequestParam("sectionSelected") String sectionSelected) {
        try {
            sService.setAttribute("classSelected", classSelected);
            sService.setAttribute("sectionSelected", sectionSelected);

            keycloakUserService.initFilterSections(classSelected, sectionSelected);
            String[] alunni = keycloakUserService.filterSectionsAllievi();
            String[] username = keycloakUserService.filterSectionsUsername();

            String classroom = sService.getAttribute("classroomSelected", String.class) != null ? sService.getAttribute("classroomSelected", String.class).toString() : "";

            sService.setAttribute("usernameSelected", username);
            // cancella i dati precedenti se cambia classe in connec sovrascrivi i dati precedenti
            if (username != null && username.length > 0) {
                int row = studentService.deleteUserNotClass(username[0]);
                if (row > 0) {
                    String[] alu = (String[]) sService.getAttribute("alunni", String[].class);
                    String[] vis = manageService.allDevices(classroom);
                    studentService.cleanVisori(sService);
                    if (alu != null && alu.length > 0 && vis != null && vis.length > 0) {
                        studentService.init(Arrays.asList(alu), Arrays.asList(vis), classroom);
                    }
                }
            }

            orderService.initOrder(alunni, username, detailService);
            String[] alunniOrdinati = orderService.getAlunni();
            String[] usernameOrdinati = orderService.getUsername();
            sService.setAttribute("alunni", alunniOrdinati);
            sService.setAttribute("usernameSelected", usernameOrdinati);
            sService.setAttribute("argoments", argomentiDirService.getArgomentiAll(Constants.PREFIX_CLASSROOM + classroom, classSelected, sectionSelected));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/abilita-visore";
    }

}