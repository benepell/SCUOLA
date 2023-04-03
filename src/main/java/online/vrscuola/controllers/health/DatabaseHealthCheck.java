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

    public static JSONObject checkDatabase(String url, String username, String password) {
        JSONObject response = new JSONObject();
        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            if (conn.isValid(5)) {
                response.put("status", "ok");
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
