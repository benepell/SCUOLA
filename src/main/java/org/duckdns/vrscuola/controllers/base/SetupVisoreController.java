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

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.duckdns.vrscuola.models.InitParamModel;
import org.duckdns.vrscuola.repositories.devices.VRDeviceInitRepository;
import org.duckdns.vrscuola.services.config.ReadOculusServices;
import org.duckdns.vrscuola.services.devices.VRDeviceInitServiceImpl;
import org.duckdns.vrscuola.services.securities.ValidateCredentialService;
import org.duckdns.vrscuola.services.utils.UtilServiceImpl;
import org.duckdns.vrscuola.utilities.Constants;
import org.duckdns.vrscuola.utilities.Utilities;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.RedirectView;

import java.util.List;
import java.util.stream.Collectors;

@Controller
public class SetupVisoreController {

    @Value("${health.datasource.website.keycloak}")
    private String linkKeycloak;

    @Value("${health.datasource.website.risorse}")
    private String linkRisorse;

    @Autowired
    ReadOculusServices readOculusServices;

    @Autowired
    ValidateCredentialService validateCredentialService;

    @Autowired
    VRDeviceInitServiceImpl initService;

    @Autowired
    VRDeviceInitRepository repository;

    @Autowired
    Utilities utilities;

    @Autowired
    UtilServiceImpl utilService;

    @RequestMapping(value = "setup-visore")
    public String getSetupVisoreClasse(Model model, HttpSession session, HttpServletResponse response) {

        // Aggiungi questi headers per prevenire la cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0
        response.setHeader("Expires", "0"); // Proxies

        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");

        String classroom = session != null && session.getAttribute("classroomSelected") != null ?  session.getAttribute("classroomSelected").toString() : "";

        if (classroom.isEmpty()) {
            return "redirect:/abilita-classe";
        }

        try {

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

            model.addAttribute("utenti", linkKeycloak);
            model.addAttribute("risorse", linkRisorse);


        } catch (Exception e) {
            System.out.println("Errore: " + e.getMessage()
            );
            throw new RuntimeException(e);
        }

        return "setup-visore";
    }

    @PostMapping("/setup-visore")
    public RedirectView postScanVisoreClasse(Model model) {
        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Gestione dei visori");

        if (readOculusServices.existAddFile()) {
            List<InitParamModel> macs = readOculusServices.addOculus(validateCredentialService);
            String[] macsString = new String[macs.size()];
            String note = "aggiunta visore";
            for (InitParamModel p : macs) {
                macsString[macs.indexOf(p)] = p.getMacAddress();
                initService.addInit(utilities, p.getMacAddress(), note,
                        utilService.isCodeActivation() ? p.getCode() : Constants.NO_CODE,
                        p.getClassroom(),p.getLabel());
            }

        } else if (readOculusServices.existUpdateFile()) {
            List<InitParamModel> paramModels = readOculusServices.changeOculus(repository);
            for (InitParamModel p : paramModels) {
                if(utilService.isCodeActivation()){
                    boolean valid = initService.valid(p.getOldMacAddress(), p.getCode());

                    if (valid) {
                        try {
                            String note = "modifica visore con vecchio mac: " + p.getOldMacAddress();
                            String code = validateCredentialService.generateVisorCode(p.getMacAddress());
                            initService.updateInit(utilities, p.getOldMacAddress(), p.getMacAddress(), note, code, p.getClassroom());

                        } catch (Exception e) {
                            throw new RuntimeException(e);
                        }
                    }
                } else {
                    // nocode validation
                    try {
                        String note = "modifica visore con vecchio mac: " + p.getOldMacAddress();
                        String code = Constants.NO_CODE;
                        initService.updateInit(utilities, p.getOldMacAddress(), p.getMacAddress(), note, code, p.getClassroom());

                    } catch (Exception e) {
                        throw new RuntimeException(e);
                    }

                }


            }
        }

        // aggiunge un timeout prima del redirect di 1 secondi
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        // Effettua il redirect al metodo GET desiderato
        return new RedirectView("/setup-visore", true);
    }

}
