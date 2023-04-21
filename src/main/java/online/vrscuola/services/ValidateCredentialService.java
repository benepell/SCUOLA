package online.vrscuola.services;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
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

        // Genera una chiave segreta per la crittografia simmetrica
        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
        keyGen.init(128);
        SecretKey secretKey = keyGen.generateKey();

        // Cifra l'hash con la chiave segreta utilizzando AES
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedHash = cipher.doFinal(hash);

        // Codifica il risultato in Base64
        String encodedHash = Base64.getEncoder().encodeToString(encryptedHash);

        // Restituisce il codice visore
        return key.charAt(0) + encodedHash;
    }

}