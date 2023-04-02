package online.vrscuola.utilities;

public interface Constants {

    String UNIQUE_TIME_FORMAT = "yyyyMMdd_HHmmss";

    String HEALTH_DATASOURCE_URL= "jdbc:mysql://localhost:3306/vrscuoladb?serverTimezone=UTC";
    String HEALTH_DATASOURCE_USERNAME= "vrscuola";
    String HEALTH_DATASOURCE_PASSWORD= "vrscuola!!!!";

    // use http in website https error "PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target"
    String HEALTH_DATASOURCE_WEBSITE = "http://scuola.vrscuola.online";
    String HEALTH_DATASOURCE_WEBSITE_KEYCLOAK = "https://keycloak.vrscuola.online";
    String HEALTH_DATASOURCE_WEBSITE_WORDPRESS = "https://scuola.vrscuola.online:8443";
    String PATH_RESOURCE_DIR = "/var/www/html/risorse/files/";

}
