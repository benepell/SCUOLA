package online.vrscuola.services.securities;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

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

@Service
public class KeycloakUserService {
    private final DataSource dataSource;
    private final Pattern usernamePattern;
    private List<Map<String, String>> users;

    @Autowired
    public KeycloakUserService(@Qualifier("secondDataSource") DataSource dataSource) {
        this.dataSource = dataSource;
        this.usernamePattern = Pattern.compile("\\d+-[a-z]+-[a-z]+-[a-z]+");
    }

    public List<Map<String, String>> getUsers(String filter, String classe, String sezione) {
        List<Map<String, String>> users = new ArrayList<>();

        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery("SELECT username FROM USER_ENTITY WHERE enabled = 1");

            while (resultSet.next()) {
                String username = resultSet.getString("username");
                if (usernamePattern.matcher(username).matches()) {
                    Map<String, String> user = new HashMap<>();
                    String[] parts = username.split("-");
                    if (parts.length == 4) {
                        String cl = parts[0];
                        String sez = parts[1];
                        String nome = parts[2];
                        String cognome = parts[3];

                        if (filter == null) {
                            user.put("classe", cl);
                            user.put("sezione", sez);
                            user.put("nome", nome);
                            user.put("cognome", cognome);
                            user.put("username", username);
                            users.add(user);
                        } else if (classe == null && sezione == null) {
                            user.put("classe", cl);
                            if (!users.contains(user)) {
                                users.add(user);
                            }
                        } else if (classe != null && sezione == null) {
                            if (cl.equals(classe)) {
                                user.put("sezione", sez.toLowerCase());
                                if (!users.contains(user)) {
                                    users.add(user);
                                }
                            }
                        } else if (classe != null && sezione != null) {
                            if (cl.equals(classe) && sez.equals(sezione.toLowerCase())) {
                                user.put("username", username);
                                user.put("nome", nome);
                                user.put("cognome", cognome);
                                users.add(user);
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            // handle the exception appropriately
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
            users.add(error);
        }

        return users;
    }

    public String[] filterClasses(String classSelected) {
        List<Map<String, String>> users = getUsers("filter", classSelected, null);

        return classSelected != null ? users.stream()
                .map(user -> user.get("sezione"))
                .sorted()
                .toArray(String[]::new) : null;
    }

    public void initFilterSections(String classSelected, String sectionSelected) {
        users = getUsers("filter", classSelected, sectionSelected);

    }

    public String[] filterSectionsAllievi() {
        return users != null ? users.stream()
                .map(user -> user.get("nome").concat(" ").concat(user.get("cognome")))
                .toArray(String[]::new) : null;
    }

    public String[] filterSectionsUsername() {
        return  users != null ? users.stream()
                .map(user -> user.get("username"))
                .toArray(String[]::new): null;
    }

    public boolean existUser(String username) {
        boolean exist = false;
        if(username == null) return exist;
        try (Connection connection = dataSource.getConnection();
             Statement statement = connection.createStatement()) {

            ResultSet resultSet = statement.executeQuery("SELECT username FROM USER_ENTITY WHERE username = '" + username + "'");

            while (resultSet.next()) {
                exist = true;
            }
        } catch (SQLException e) {
            // handle the exception appropriately
            Map<String, String> error = new HashMap<>();
            error.put("error", e.getMessage());
        }
        return exist;
    }
}
