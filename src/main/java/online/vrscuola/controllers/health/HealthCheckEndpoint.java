package online.vrscuola.controllers.health;


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
        healthStatus.put("website", WebsiteHealthCheck.checkWebsite());
        healthStatus.put("operatingSystem", OperatingSystemHealthCheck.checkOperatingSystem());
        return healthStatus.toMap();
    }

}
