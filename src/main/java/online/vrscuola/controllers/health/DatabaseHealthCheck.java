package online.vrscuola.controllers.health;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import online.vrscuola.utilities.Constants;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

@Component
public class DatabaseHealthCheck {

    public static JSONObject checkDatabase() {
        JSONObject response = new JSONObject();
        try {
            Connection conn = DriverManager.getConnection(Constants.HEALTH_DATASOURCE_URL, Constants.HEALTH_DATASOURCE_USERNAME, Constants.HEALTH_DATASOURCE_PASSWORD);
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
