package online.vrscuola.services.securities;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;

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

    public String generateVisorCode(String resource) throws Exception {
        // Genera un hash SHA-256 della chiave e della risorsa
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hash = digest.digest((key + resource).getBytes(StandardCharsets.UTF_8));

        // Codifica il risultato in Base64
        String encodedHash = Base64.getEncoder().encodeToString(hash);

        // Esegue l'URL encoding del risultato
        String encodedResult = URLEncoder.encode(encodedHash, StandardCharsets.UTF_8.toString());

        // Restituisce il codice visore
        return key.charAt(0) + encodedResult;
    }



}