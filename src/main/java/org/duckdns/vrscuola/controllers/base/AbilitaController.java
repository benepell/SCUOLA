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

import com.fasterxml.jackson.core.type.TypeReference;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.duckdns.vrscuola.repositories.devices.VRDeviceInitRepository;
import org.duckdns.vrscuola.services.StudentService;
import org.duckdns.vrscuola.services.config.SessionDBService;
import org.duckdns.vrscuola.services.devices.VRDeviceInitServiceImpl;
import org.duckdns.vrscuola.services.devices.VRDeviceManageService;
import org.duckdns.vrscuola.services.log.EventLogService;
import org.duckdns.vrscuola.services.securities.KeycloakUserService;
import org.duckdns.vrscuola.services.utils.UtilService;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/")
public class AbilitaController {

    private String linkKeycloak;
    private String linkRisorse;
    private final StudentService studentService;
    private final VRDeviceManageService manageService;
    private final EventLogService logService;
    private final UtilService utilService;
    private final KeycloakUserService kService;

    private final VRDeviceInitServiceImpl initService;
    private final VRDeviceInitRepository repository;

    private final SessionDBService sService;

    @Autowired
    public AbilitaController(StudentService studentService, VRDeviceManageService manageService,
                             EventLogService logService, UtilService utilService,
                             KeycloakUserService kService,
                             VRDeviceInitServiceImpl initService,
                             VRDeviceInitRepository repository,
                             @Value("${health.datasource.website.keycloak}") String linkKeycloak,
                             @Value("${health.datasource.website.risorse}") String linkRisorse,
                             SessionDBService sService) {
        this.studentService = studentService;
        this.manageService = manageService;
        this.logService = logService;
        this.utilService = utilService;
        this.kService = kService;
        this.initService = initService;
        this.repository = repository;
        this.linkKeycloak = linkKeycloak;
        this.linkRisorse = linkRisorse;
        this.sService = sService;
    }

    @RequestMapping(value = "abilita-classe")
    public String getAbilitaClasse(Authentication authentication, Model model, HttpServletRequest request) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        model.addAttribute("titolo", "Abilita Classe");
        model.addAttribute("content", "/WEB-INF/view/abilita-classe.jsp");

        sService.setAttribute("isTablet", utilService.isTablet(request));

        return "abilita-classe";
    }

    @RequestMapping(value = "abilita-sezione")
    public String getAbilitaSezione(Model model, HttpSession session) {

        if (session != null) {
            if (session.getAttribute("main_username") != null) {
                sService.setAttribute("main_username", (String) session.getAttribute("main_username"));
            }

            if (session.getAttribute("classroomSelected") != null) {
                sService.setAttribute("classroomSelected", (String) session.getAttribute("classroomSelected"));
            }

        }


        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");
        model.addAttribute("response", "stringaresponse");

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);

        model.addAttribute("titolo", "Abilita Sezione");
        model.addAttribute("content", "/WEB-INF/view/abilita-sezione.jsp");

        String classroom = sService.getLab();

        model.addAttribute("classSelected", classroom);

        String[] letters = (String[]) sService.getAttribute("allSections", String[].class);

        // Aggiungi al modello. Se letters è null, crea un nuovo array vuoto.
        model.addAttribute("allSections", letters != null ? letters : new String[0]);

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

        String classroom = session.getAttribute("classroomSelected") != null ? (String) session.getAttribute("classroomSelected") : null;
        if (classroom != null) {
            sService.setAttribute("classroomSelected", classroom);

        }

        String[] alu = (String[]) sService.getAttribute("alunni", String[].class);
        String[] vis = manageService.allDevices(classroom);
        String[] users = sService.getAttribute("usernameSelected", String[].class) != null ? (String[]) sService.getAttribute("usernameSelected", String[].class) : null;

        model.addAttribute("alunni", alu);
        model.addAttribute("usernameSelected", users);

        String classr = sService.getAttribute("classSelected", String.class) != null ? sService.getAttribute("classSelected", String.class).toString() : "";
        model.addAttribute("classSelected", classr);

        String sectionSelected = sService.getAttribute("sectionSelected", String.class) != null ? sService.getAttribute("sectionSelected", String.class).toString() : "";
        model.addAttribute("sectionSelected", sectionSelected);

        TypeReference<List<String>> typeRef2 = new TypeReference<List<String>>() {
        };
        List<String> argoments = (List<String>) sService.getAttribute("argoments", typeRef2);

        model.addAttribute("argoments", argoments);

        // elimina visori se il tempo trascorso è superiore al max definito
        if (Constants.ENABLED_REMOVE_RECORDS) {
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

        // aggiunto per stato-visori
        List<String> labelsSetup = repository.labelsSetup(classroom);
        List<String> macsSetup = repository.macsSetup(classroom);
        List<String> battSetup = repository.battSetup(classroom);

        String macs = String.join(",", macsSetup);

        if (Constants.ENABLED_ONLINE) {
            List<Boolean> online = initService.isOnline(macs);
            model.addAttribute("onlineSetup", String.join(",", online.stream().map(String::valueOf).collect(Collectors.toList())));
        }

        model.addAttribute("macsSetup", macs);
        model.addAttribute("labelsSetup", String.join(",", labelsSetup));
        model.addAttribute("battSetup", String.join(",", battSetup));

        // model.addAttribute("utenti", linkKeycloak);
        // model.addAttribute("risorse", linkRisorse);
        // fine aggiunto per stato-visori

        studentService.init(Arrays.asList(alu), Arrays.asList(vis), classroom);

        logService.sendLog(sService, Constants.EVENT_LOG_ENABLE_VISOR);

        return "abilita-visore";
    }

    @GetMapping(value = "/aggiornaStatoVisori")
    public String aggiornaStatoVisori(Model model) {
        // Assumi che la logica per ottenere i dati aggiornati dei visori sia simile a quella in abilita-visore

        String classroom = sService.getLab();

        List<String> labelsSetup = repository.labelsSetup(classroom);
        List<String> macsSetup = repository.macsSetup(classroom);
        List<String> battSetup = repository.battSetup(classroom);

        String macs = String.join(",", macsSetup);

        if (Constants.ENABLED_ONLINE) {
            List<Boolean> online = initService.isOnline(macs);
            model.addAttribute("onlineSetup", String.join(",", online.stream().map(String::valueOf).collect(Collectors.toList())));
        }

        model.addAttribute("macsSetup", macs);
        model.addAttribute("labelsSetup", String.join(",", labelsSetup));
        model.addAttribute("battSetup", String.join(",", battSetup));

        // Nota: questo metodo deve ritornare una vista parziale, solo il contenuto che deve essere aggiornato asincronamente
        return "stato-visori";
    }


}