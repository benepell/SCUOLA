package online.vrscuola.services;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class ValidateCredentialService {

    @Value("${school.setup.key}")
    private String key;

    public String generateCredentials(String resource)
    {
        int multiply = 1;
        for (char c : (key + resource).toCharArray()) {
            multiply *= (int) c;
        }
        String result = String.valueOf(multiply);
        return  key.charAt(0) + result;
    }


}