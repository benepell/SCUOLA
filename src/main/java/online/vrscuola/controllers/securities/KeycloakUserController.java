package online.vrscuola.controllers.securities;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
    @GetMapping( {"/keycloak-users","/keycloak-users/{filter:filter}","/keycloak-users/{filter:filter}/{classe}", "/keycloak-users/{filter:filter}/{classe}/{sezione}"})
    @Cacheable("usersCache")
    public List<Map<String, String>> getUsers(@PathVariable(required = false) String filter,@PathVariable(required = false) String classe, @PathVariable(required = false) String sezione) {
        List<Map<String, String>> users = new ArrayList<>();
        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery("SELECT username FROM USER_ENTITY WHERE enabled = 1");

            while (resultSet.next()) {
                String username = resultSet.getString("username");
                if (usernamePattern.matcher(username).matches()) {
                    Map<String, String> user = new HashMap<>();
                    String[] parts = username.split("-");
                    if(parts.length == 4){
                        String cl = parts[0]; // "1"
                        String sez = parts[1]; // "a"
                        String nome = parts[2]; // "ben"
                        String cognome = parts[3]; // "pell"

                        // caso tutti i valori
                        if (filter == null) {
                            // ritorna tutti i valori
                            user.put("classe", cl);
                            user.put("sezione", sez);
                            user.put("nome",nome);
                            user.put("cognome",cognome);
                            user.put("username", username);
                            users.add(user);
                        } else if (classe == null && sezione == null){
                            user.put("classe", cl);
                            // se classe non e'presente nella lista aggiungilo
                            if(!users.contains(user)){
                                users.add(user);
                            }
                        }
                        else if (classe != null && sezione == null) { // caso solo classe ritorna tutti gli utenti della classi
                            if (cl.equals(classe)) {
                                user.put("sezione", sez);
                                // se sezione non e'presente nella lista aggiungilo
                                if(!users.contains(user)){
                                    users.add(user);
                                }
                            }
                        } else if (classe != null && sezione != null) { // caso classe e sezione ritorna solo utenti in base alla classe e sezione
                            if(cl.equals(classe) && sez.equals(sezione)){
                                user.put("username", username);
                                users.add(user);
                            }
                        }
                    }
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
