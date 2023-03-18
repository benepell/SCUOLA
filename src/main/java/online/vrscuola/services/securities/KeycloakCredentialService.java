package online.vrscuola.services.securities;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
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


}
