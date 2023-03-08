package online.vrscuola.controllers.health;


import online.vrscuola.utilities.Constants;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class HealthCheckEndpoint {

    @GetMapping("/health")
    public Map<String, Object> health() {
        JSONObject healthStatus = new JSONObject();
        healthStatus.put("database", DatabaseHealthCheck.checkDatabase());
        healthStatus.put("resourceDirectory", ResourceDirectoryHealthCheck.checkResourceDirectory());
        healthStatus.put("website", WebsiteHealthCheck.checkWebsite(Constants.HEALTH_DATASOURCE_WEBSITE));
        healthStatus.put("websiteKeycloak", WebsiteHealthCheck.checkWebsite(Constants.HEALTH_DATASOURCE_WEBSITE_KEYCLOAK));
        healthStatus.put("websiteWordpress", WebsiteHealthCheck.checkWebsite(Constants.HEALTH_DATASOURCE_WEBSITE_WORDPRESS));
        healthStatus.put("operatingSystem", OperatingSystemHealthCheck.checkOperatingSystem());
        return healthStatus.toMap();
    }

}
