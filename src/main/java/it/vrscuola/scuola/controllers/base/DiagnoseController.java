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

package it.vrscuola.scuola.controllers.base;

import it.vrscuola.scuola.services.health.DatabaseHealthCheckService;
import it.vrscuola.scuola.services.pdf.EventLogPdfService;
import it.vrscuola.scuola.services.health.OperatingSystemHealthCheckService;
import it.vrscuola.scuola.services.health.ResourceDirectoryHealthCheckService;
import it.vrscuola.scuola.services.health.WebsiteHealthCheckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.IOException;

@Controller
@RequestMapping("/")
public class DiagnoseController {

    @Value("${health.datasource.website}")
    private String healthDataSourceWebsite;
    @Value("${health.datasource.website.keycloak}")
    private String healthDataSourceWebsiteKeycloak;
    @Value("${health.datasource.website.risorse}")
    private String healthdataSourceWebsiteRisorse;
    @Value("${health.datasource.url}")
    private String healthDataSourceUrl;

    @Value("${health.datasource.username}")
    private String healthDatasourceUsername;
    @Value("${health.datasource.password}")
    private String healthDatasourcePassword;

    @Value("${health.datasource.website.keycloak}")
    private String linkKeycloak;

    @Value("${health.datasource.website.risorse}")
    private String linkRisorse;


    @Autowired
    DatabaseHealthCheckService databaseHealthCheckService;

    @Autowired
    ResourceDirectoryHealthCheckService resourceDirectoryHealthCheckService;

    @Autowired
    WebsiteHealthCheckService websiteHealthCheckService;

    @Autowired
    OperatingSystemHealthCheckService operatingSystemHealthCheckService;

    @Autowired
    EventLogPdfService eventLogPdfService;

    @GetMapping("/diagnosi")
    public String getDiagnose(Model model) throws IOException {
        // Recupera i valori dal JSON e assegnali al model

        String databaseStatus = databaseHealthCheckService.checkDatabase(healthDataSourceUrl, healthDatasourceUsername, healthDatasourcePassword).get("status").toString();
        String resourceDirectoryStatus =  resourceDirectoryHealthCheckService.checkResourceDirectory().get("status").toString();
        String websiteStatus =  websiteHealthCheckService.checkWebsite(healthDataSourceWebsite).get("status").toString();
        String websiteKeycloakStatus = websiteHealthCheckService.checkWebsite(healthDataSourceWebsiteKeycloak).get("status").toString();
        String websiteRisorseStatus =  websiteHealthCheckService.checkWebsite(healthdataSourceWebsiteRisorse, healthDatasourceUsername, healthDatasourcePassword).get("status").toString();
        String operatingSystemStatus = operatingSystemHealthCheckService.checkOperatingSystem().get("status").toString();

        model.addAttribute("databaseStatus", databaseStatus);
        model.addAttribute("resourceDirectoryStatus", resourceDirectoryStatus);
        model.addAttribute("websiteStatus", websiteStatus);
        model.addAttribute("websiteKeycloakStatus", websiteKeycloakStatus);
        model.addAttribute("websiteRisorseStatus", websiteRisorseStatus);
        model.addAttribute("operatingSystemStatus", operatingSystemStatus);

        model.addAttribute("utenti", linkKeycloak);
        model.addAttribute("risorse", linkRisorse);


        model.addAttribute("intestazione", "Benvenuti nel sito Vr Scuola");
        model.addAttribute("saluti", "Autenticati per utilizzare i servizi");

        eventLogPdfService.save();

        return ("diagnosi");
    }

}
