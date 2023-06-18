package it.vrscuola.scuola.services.securities;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

@Service
public class KeycloakCredentialService {

    public String generateKeycloakCredentials(String resource, String username)
    {
        int multiply = 1;
        for (char c : (username + resource).toCharArray()) {
            multiply *= (int) c;
        }
        String result = String.valueOf(multiply);
        result = result.substring(result.length() - 6);
        result = (int) username.charAt(0) + result;

        return result;
    }


    public String generateKeycloakBridgeCredentials(String resource, String username)
    {
        int multiply = 1;
        for (char c : (username + resource).toCharArray()) {
            multiply *= (int) c;
        }
        String result = String.valueOf(multiply);
        result =  username.charAt(0) + result;

        return Base64.getEncoder().encodeToString(result.getBytes(StandardCharsets.UTF_8));
    }

}
