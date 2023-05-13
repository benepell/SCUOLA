package online.vrscuola.services.health;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;


@Service
public class DatabaseHealthCheckService {

    public JSONObject checkDatabase(String url, String username, String password) {
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
