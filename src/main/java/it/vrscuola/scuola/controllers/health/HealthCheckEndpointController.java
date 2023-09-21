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

package it.vrscuola.scuola.controllers.health;


import it.vrscuola.scuola.services.health.DatabaseHealthCheckService;
import it.vrscuola.scuola.services.health.OperatingSystemHealthCheckService;
import it.vrscuola.scuola.services.health.ResourceDirectoryHealthCheckService;
import it.vrscuola.scuola.services.health.WebsiteHealthCheckService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HealthCheckEndpointController {

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

    @Autowired
    DatabaseHealthCheckService databaseHealthCheckService;

    @Autowired
    ResourceDirectoryHealthCheckService resourceDirectoryHealthCheckService;

    @Autowired
    WebsiteHealthCheckService websiteHealthCheckService;

    @Autowired
    OperatingSystemHealthCheckService operatingSystemHealthCheckService;

    @GetMapping("/health")
    public Map<String, Object> health() {
        JSONObject healthStatus = new JSONObject();
        healthStatus.put("database", databaseHealthCheckService.checkDatabase(healthDataSourceUrl, healthDatasourceUsername, healthDatasourcePassword));
        healthStatus.put("resourceDirectory", resourceDirectoryHealthCheckService.checkResourceDirectory());
        healthStatus.put("website", websiteHealthCheckService.checkWebsite(healthDataSourceWebsite));
        healthStatus.put("websiteKeycloak", websiteHealthCheckService.checkWebsite(healthDataSourceWebsiteKeycloak));
        healthStatus.put("websiteRisorse", websiteHealthCheckService.checkWebsite(healthdataSourceWebsiteRisorse, healthDatasourceUsername, healthDatasourcePassword));
        healthStatus.put("operatingSystem", operatingSystemHealthCheckService.checkOperatingSystem());
        return healthStatus.toMap();
    }

}
