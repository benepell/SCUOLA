/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.services.securities;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.util.regex.Pattern;

@Service
public class KeycloakUserService {

    @Autowired
    private OAuth2AuthorizedClientService authorizedClientService;
    @Autowired
    private JwtDecoder jwtDecoder;

    private final DataSource dataSource;
    private final Pattern usernamePattern;

    private List<Map<String, String>> users;

    @Autowired
    public KeycloakUserService(@Qualifier("secondDataSource") DataSource dataSource) {
        this.dataSource = dataSource;
        this.usernamePattern = Pattern.compile("\\d+-[a-z]+-[a-z]+-[a-z]+");
    }


    @Autowired
    private RestTemplate restTemplate;

    private static final String USERINFO_ENDPOINT = "https://vrscuola-auth.duckdns.org:9443/realms/scuola/protocol/openid-connect/userinfo";

    public Map<String, Object> getUserInfo(String accessToken) {
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.add(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken);

            HttpEntity<String> entity = new HttpEntity<>("parameters", headers);

            ResponseEntity<Map> response = restTemplate.exchange(
                    USERINFO_ENDPOINT,
                    HttpMethod.GET,
                    entity,
                    Map.class
            );

            return response.getBody();
        } catch (Exception e) {
            // Log the exception or handle it as per your need
            e.printStackTrace();
            return Collections.emptyMap();
        }
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
        return users != null ? users.stream()
                .map(user -> user.get("username"))
                .toArray(String[]::new) : null;
    }

    public boolean existUser(String username) {
        boolean exist = false;
        if (username == null) return exist;
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

    public List<String> getRolesFromAccessToken(String accessToken) {
        try {
            Jwt jwt = jwtDecoder.decode(accessToken);
            Map<String, Object> claims = jwt.getClaims();

            Map<String, Object> realmAccess = (Map<String, Object>) claims.get("realm_access");
            if (realmAccess != null && realmAccess.containsKey("roles")) {
                return (List<String>) realmAccess.get("roles");
            }
        } catch (Exception e) {
            return null;
            // log.error("Errore durante la decodifica del token JWT", e);
        }

        return Collections.emptyList();
    }

    public boolean hasRoleInAccessToken(String accessToken, String role) {
        try {
            Jwt jwt = jwtDecoder.decode(accessToken);
            Map<String, Object> claims = jwt.getClaims();

            Map<String, Object> realmAccess = (Map<String, Object>) claims.get("realm_access");
            if (realmAccess != null && realmAccess.containsKey("roles")) {
                List<String> roles = (List<String>) realmAccess.get("roles");
                return roles.contains(role);
            }
        } catch (Exception e) {
            return false;
            // log.error("Errore durante la decodifica del token JWT", e);
        }

        return false;
    }

    public String getAccessToken(Authentication authentication) {
        if (authentication instanceof OAuth2AuthenticationToken) {
            OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;
            OAuth2AuthorizedClient authorizedClient = authorizedClientService.loadAuthorizedClient(
                    oauthToken.getAuthorizedClientRegistrationId(), oauthToken.getName());

            if (authorizedClient != null && authorizedClient.getAccessToken() != null) {
                return authorizedClient.getAccessToken().getTokenValue();
            }
        }
        return null;
    }

    public String getIdToken(Authentication authentication) {
        if (authentication instanceof OAuth2AuthenticationToken) {
            OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;
            OAuth2AuthorizedClient authorizedClient = authorizedClientService.loadAuthorizedClient(
                    oauthToken.getAuthorizedClientRegistrationId(), oauthToken.getName());

            // Controlla se il client autorizzato e l'id_token sono non nulli
            if (authorizedClient != null && authorizedClient.getRefreshToken() != null) {
                // Restituisce l'id_token
                return authorizedClient.getRefreshToken().getTokenValue();
            }
        }
        return null;
    }

    public String getTokenAttribute(Authentication authentication, String key) {
        if (authentication != null && authentication.getPrincipal() instanceof OAuth2User) {
            OAuth2User user = (OAuth2User) authentication.getPrincipal();
            Object attribute = user.getAttribute(key);
            return attribute != null ? attribute.toString() : null;
        }

        return null;
    }


}
