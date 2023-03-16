package online.vrscuola.controllers.resources;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GeneratePasswordController
{
    @Value("${keycloak.resource}")
    private String resource;
    @GetMapping("/generatepwd/{username}")
    public String hello(@PathVariable String username)
    {
        int multiply = 1;
        for (char c : (username + resource).toCharArray()) {
            multiply *= (int) c;
        }
        String result = String.valueOf(multiply);
        result = result.substring(result.length() - 6);
        result = (int) username.charAt(0) + result;

        return "Password:"+ result + " per utente: " + username;
    }
}