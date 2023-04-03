package online.vrscuola.controllers.health;


import online.vrscuola.utilities.Constants;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HealthCheckEndpoint {

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

    @GetMapping("/health")
    public Map<String, Object> health() {
        JSONObject healthStatus = new JSONObject();
        healthStatus.put("database", DatabaseHealthCheck.checkDatabase(healthDataSourceUrl, healthDatasourceUsername, healthDatasourcePassword));
        healthStatus.put("resourceDirectory", ResourceDirectoryHealthCheck.checkResourceDirectory());
        healthStatus.put("website", WebsiteHealthCheck.checkWebsite(healthDataSourceWebsite));
        healthStatus.put("websiteKeycloak", WebsiteHealthCheck.checkWebsite(healthDataSourceWebsiteKeycloak));
        healthStatus.put("websiteRisorse", WebsiteHealthCheck.checkWebsite(healthdataSourceWebsiteRisorse,"vrscuola","vrscuola!!!"));
        healthStatus.put("operatingSystem", OperatingSystemHealthCheck.checkOperatingSystem());
        return healthStatus.toMap();
    }

}
