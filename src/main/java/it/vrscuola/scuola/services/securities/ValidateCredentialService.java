/**
 * Copyright (c) 2023, Benedetto Pellerito
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package it.vrscuola.scuola.services.securities;


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