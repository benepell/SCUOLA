package online.vrscuola.controllers.securities;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

@RestController
public class KeycloakUserController {

    private final DataSource dataSource;
    private final Pattern usernamePattern;

    @Autowired
    public KeycloakUserController(@Qualifier("secondDataSource")DataSource dataSource) {
        this.dataSource = dataSource;
        this.usernamePattern = Pattern.compile("\\d+-[a-z]+-[a-z]+-[a-z]+");
    }

    @GetMapping("/keycloak-users")
    @Cacheable("usersCache")
    public List<Map<String, String>> getUsers() {
        List<Map<String, String>> users = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery("SELECT username FROM USER_ENTITY");

            while (resultSet.next()) {
                String username = resultSet.getString("username");
                if (usernamePattern.matcher(username).matches()) {
                    Map<String, String> user = new HashMap<>();
                    user.put("username", username);
                    String[] parts = username.split("-");
                    if(parts.length == 4){
                        String classe = parts[0]; // "1"
                        String sezione = parts[1]; // "a"
                        String nome = parts[2]; // "ben"
                        String cognome = parts[3]; // "pell"
                        user.put("classe", classe);
                        user.put("sezione", sezione);
                        user.put("nome",nome);
                        user.put("cognome",cognome);
                    }
                    users.add(user);
                }
            }
        } catch (SQLException e) {
            // gestire l'eccezione in modo appropriato
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            users.add(error);
        }
        return users;
    }
}
