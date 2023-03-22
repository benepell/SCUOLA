package online.vrscuola.services.securities;

import online.vrscuola.models.KeycloakUserInfo;
import org.json.JSONArray;
import org.json.JSONObject;
import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.keycloak.representations.AccessToken;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Service
public class KeycloakServiceBridge {

    @Value("${school.bridge.url}")
    private String bridgeUrl;

    // Ottiene la lista di utenti da Keycloak come oggetto JSON
    public JSONArray getKeycloakUsers(String username, String otp) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        // Aggiunge i parametri della richiesta
        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("pusername", username);
        map.add("potp", otp);

        // Crea un oggetto HttpEntity con i parametri e gli headers
        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(map, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(
                bridgeUrl.concat("/bridge/users"),
                HttpMethod.POST,
                request,
                String.class);

        String result = response.getBody();
        return new JSONArray(result);
    }

    // Restituisce la lista di informazioni degli utenti come oggetto JSON
    public JSONArray getKeycloakUserInfos(String username, String otp) {
        JSONArray users = getKeycloakUsers(username, otp);
        List<KeycloakUserInfo> userInfos = new ArrayList<>();

        for (int i = 0; i < users.length(); i++) {
            JSONObject user = users.getJSONObject(i);
            KeycloakUserInfo userInfo = new KeycloakUserInfo(
                    user.getString("classe"),
                    user.getString("cognome"),
                    user.getString("nome"),
                    user.getString("sezione"),
                    user.getString("username")
            );

            userInfos.add(userInfo);
        }

        return new JSONArray(userInfos);
    }
}
