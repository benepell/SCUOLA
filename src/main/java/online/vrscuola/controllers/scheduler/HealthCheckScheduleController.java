package online.vrscuola.controllers.scheduler;

import com.jayway.jsonpath.JsonPath;
import online.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class HealthCheckScheduleController {
    @Value("${health.datasource.website}")
    private String healthDatasourceWebsite;

    @Scheduled(fixedDelay = Constants.SCHEDULE_HEALTH) // ogni ora
    public void checkHealth() {
        RestTemplate restTemplate = new RestTemplate();
        String url = healthDatasourceWebsite.concat("/api/health");

        try {
            String response = restTemplate.getForObject(url, String.class);
            String databaseStatus = JsonPath.parse(response).read("$.database.status");
            String websiteStatus = JsonPath.parse(response).read("$.website.status");
            String websiteRisorseStatus = JsonPath.parse(response).read("$.websiteRisorse.status");
            String resourceDirectoryStatus = JsonPath.parse(response).read("$.resourceDirectory.status");
            String websiteKeycloakStatus = JsonPath.parse(response).read("$.websiteKeycloak.status");
            String operatingSystemStatus = JsonPath.parse(response).read("$.operatingSystem.status");

            // controlla tutti gli stati di salute
            if (databaseStatus.equals("ok") && websiteStatus.equals("ok") && websiteRisorseStatus.equals("ok")
                    && resourceDirectoryStatus.equals("ok") && websiteKeycloakStatus.equals("ok") && operatingSystemStatus.equals("ok")) {
                System.out.println("Il sistema è in buona salute!");
            } else {
                System.out.println("Il sistema ha un problema di salute!");
            }

        } catch (Exception e) {
            System.out.println("Errore durante la richiesta HTTP: " + e.getMessage());
            return;
        }


    }
}
