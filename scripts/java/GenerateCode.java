/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
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

import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.net.URLEncoder;

public class GenerateCode {

    private String key;

    public GenerateCode(String key) {
        this.key = key;
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

    //  usage: java GenerateCode <key> <resource>
    // example: java GenerateCode MizAkO7AcNiDEgsGwXIsCHWdhAlNMc2A 52:54:00:12:35:02

    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Usage: java Main <key> <resource>");
            return;
        }

        String key = args[0];
        String resource = args[1];
        GenerateCode main = new GenerateCode(key);

        try {
            String visorCode = main.generateVisorCode(resource);
            System.out.println("Generated Visor Code: " + visorCode);
        } catch (Exception e) {
            System.err.println("Error generating visor code: " + e.getMessage());
        }
    }
}
