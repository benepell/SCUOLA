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

package org.duckdns.vrscuola.controllers.health;


import org.duckdns.vrscuola.services.health.DatabaseHealthCheckService;
import org.duckdns.vrscuola.services.health.OperatingSystemHealthCheckService;
import org.duckdns.vrscuola.services.health.ResourceDirectoryHealthCheckService;
import org.duckdns.vrscuola.services.health.WebsiteHealthCheckService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HealthCheckEndpointController {

    private final String healthDataSourceWebsite;
    private final String healthDataSourceWebsiteKeycloak;
    private final String healthDataSourceWebsiteRisorse;
    private final String healthDataSourceUrl;
    private final String healthDatasourceUsername;
    private final String healthDatasourcePassword;
    private final DatabaseHealthCheckService databaseHealthCheckService;
    private final ResourceDirectoryHealthCheckService resourceDirectoryHealthCheckService;
    private final WebsiteHealthCheckService websiteHealthCheckService;
    private final OperatingSystemHealthCheckService operatingSystemHealthCheckService;

    @Autowired
    public HealthCheckEndpointController(@Value("${health.datasource.website}") String healthDataSourceWebsite,
                                         @Value("${health.datasource.website.keycloak}") String healthDataSourceWebsiteKeycloak,
                                         @Value("${health.datasource.website.risorse}") String healthDataSourceWebsiteRisorse,
                                         @Value("${health.datasource.url}") String healthDataSourceUrl,
                                         @Value("${health.datasource.username}") String healthDatasourceUsername,
                                         @Value("${health.datasource.password}") String healthDatasourcePassword,
                                         DatabaseHealthCheckService databaseHealthCheckService,
                                         ResourceDirectoryHealthCheckService resourceDirectoryHealthCheckService,
                                         WebsiteHealthCheckService websiteHealthCheckService,
                                         OperatingSystemHealthCheckService operatingSystemHealthCheckService) {
        this.healthDataSourceWebsite = healthDataSourceWebsite;
        this.healthDataSourceWebsiteKeycloak = healthDataSourceWebsiteKeycloak;
        this.healthDataSourceWebsiteRisorse = healthDataSourceWebsiteRisorse;
        this.healthDataSourceUrl = healthDataSourceUrl;
        this.healthDatasourceUsername = healthDatasourceUsername;
        this.healthDatasourcePassword = healthDatasourcePassword;
        this.databaseHealthCheckService = databaseHealthCheckService;
        this.resourceDirectoryHealthCheckService = resourceDirectoryHealthCheckService;
        this.websiteHealthCheckService = websiteHealthCheckService;
        this.operatingSystemHealthCheckService = operatingSystemHealthCheckService;
    }

    @GetMapping("/health")
    public Map<String, Object> health() {
        JSONObject healthStatus = new JSONObject();
        healthStatus.put("database", databaseHealthCheckService.checkDatabase(healthDataSourceUrl, healthDatasourceUsername, healthDatasourcePassword));
        healthStatus.put("resourceDirectory", resourceDirectoryHealthCheckService.checkResourceDirectory());
        healthStatus.put("website", websiteHealthCheckService.checkWebsite(healthDataSourceWebsite));
        healthStatus.put("websiteKeycloak", websiteHealthCheckService.checkWebsite(healthDataSourceWebsiteKeycloak));
        healthStatus.put("websiteRisorse", websiteHealthCheckService.checkWebsite(healthDataSourceWebsiteRisorse, healthDatasourceUsername, healthDatasourcePassword));
        healthStatus.put("operatingSystem", operatingSystemHealthCheckService.checkOperatingSystem());
        return healthStatus.toMap();
    }

}
