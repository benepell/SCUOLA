package online.vrscuola.controllers.health;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import online.vrscuola.utilities.Constants;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;


@Component
public class DatabaseHealthCheck {

    @Value("${health.datasource.url}")
    private static String healthDataSourceUrl;
    @Value("${health.datasource.username}")
    private static String healthDatasourceUsername;
    @Value("${health.datasource.password}")
    private static String healthDatasourcePassword;

    public static JSONObject checkDatabase() {
        JSONObject response = new JSONObject();
        try {
            Connection conn = DriverManager.getConnection(healthDataSourceUrl, healthDatasourceUsername, healthDatasourcePassword);
            if (conn != null) {
                response.put("status", "ok");
                conn.close();
            } else {
                response.put("status", "error");
            }
        } catch (SQLException e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
        }
        return response;
    }

}
