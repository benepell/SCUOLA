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
    private static String healthDataSourceWebsite;
    @Value("${health.datasource.website.keycloak}")
    private static String healthDataSourceWebsiteKeycloak;
    @Value("${health.datasource.website.risorse}")
    private static String healthdataSourceWebsiteRisorse;


    @GetMapping("/health")
    public Map<String, Object> health() {
        JSONObject healthStatus = new JSONObject();
        healthStatus.put("database", DatabaseHealthCheck.checkDatabase());
        healthStatus.put("resourceDirectory", ResourceDirectoryHealthCheck.checkResourceDirectory());
        healthStatus.put("website", WebsiteHealthCheck.checkWebsite(healthDataSourceWebsite));
        healthStatus.put("websiteKeycloak", WebsiteHealthCheck.checkWebsite(healthDataSourceWebsiteKeycloak));
        healthStatus.put("websiteRisorse", WebsiteHealthCheck.checkWebsite(healthdataSourceWebsiteRisorse));
        healthStatus.put("operatingSystem", OperatingSystemHealthCheck.checkOperatingSystem());
        return healthStatus.toMap();
    }

}
