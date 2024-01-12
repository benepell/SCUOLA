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

package org.duckdns.vrscuola.controllers.base;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.duckdns.vrscuola.services.StudentService;
import org.duckdns.vrscuola.services.devices.VRDeviceManageService;
import org.duckdns.vrscuola.services.log.EventLogService;
import org.duckdns.vrscuola.services.utils.UtilService;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import java.util.Arrays;

@Controller
@RequestMapping("/")
public class AbilitaController {

    @Value("${health.datasource.website.keycloak}")
    private String linkKeycloak;

    @Value("${health.datasource.website.risorse}")
    private String linkRisorse;

    @Autowired
    StudentService studentService;

    @Autowired
    VRDeviceManageService manageService;

    @Autowired
    EventLogService logService;

    @Autowired
    UtilService utilService;

    @RequestMapping(value = "abilita-classe")
    public String getAbilitaClasse(Model model, HttpServletRequest request, HttpSession session) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        model.addAttribute("titolo", "Abilita Classe");
        model.addAttribute("content", "/WEB-INF/view/abilita-classe.jsp");

        session.setAttribute("isTablet", utilService.isTablet(request));

        return "abilita-classe";
    }

    @RequestMapping(value = "abilita-sezione")
    public String getAbilitaSezione(Model model, HttpSession session) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        model.addAttribute("titolo", "Abilita Sezione");
        model.addAttribute("content", "/WEB-INF/view/abilita-sezione.jsp");

        String classroom = session != null && session.getAttribute("classroomSelected") != null ?  session.getAttribute("classroomSelected").toString() : "";

        if (classroom.isEmpty()) {
            return "redirect:/abilita-classe";
        }

        return "abilita-sezione";
    }

    @RequestMapping(value = "abilita-visore")
    public String getAbilitaVisore(Model model, HttpSession session) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        session.setAttribute("isCloseVisorLogout", true);

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        String classroom = session != null && session.getAttribute("classroomSelected") != null ?  session.getAttribute("classroomSelected").toString() : "";

        String[] alu = (String[]) session.getAttribute("alunni");
        String[] vis = manageService.allDevices(classroom);
        String[] users = session.getAttribute("usernameSelected") != null ? session.getAttribute("usernameSelected").toString().split(",") : null;

        model.addAttribute("username", users);

        // elimina visori se il tempo trascorso è superiore al max definito
        if (Constants.ENABLED_REMOVE_RECORDS){
            manageService.removeRecordsOlder();
        }

        String[] resume = manageService.resume(classroom);
        if (resume != null && resume.length == 2) {
            model.addAttribute("resumeUsers", resume[0]);
            model.addAttribute("resumeLabels", resume[1]);
        }

        if (alu == null || vis == null) {
            return "redirect:/abilita-classe";
        }


        studentService.init(Arrays.asList(alu), Arrays.asList(vis), classroom);

        logService.sendLog(session, Constants.EVENT_LOG_ENABLE_VISOR);

        return "abilita-visore";
    }

}