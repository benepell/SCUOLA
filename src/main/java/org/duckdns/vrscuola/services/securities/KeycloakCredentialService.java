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

import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

@Service
public class KeycloakCredentialService {

    public String generateKeycloakCredentials(String resource, String username) {
        int multiply = 1;
        for (char c : (username + resource).toCharArray()) {
            multiply *= (int) c;
        }
        String result = String.valueOf(multiply);
        result = result.substring(result.length() - 6);
        result = (int) username.charAt(0) + result;

        return result;
    }


    public String generateKeycloakBridgeCredentials(String resource, String username) {
        int multiply = 1;
        for (char c : (username + resource).toCharArray()) {
            multiply *= (int) c;
        }
        String result = String.valueOf(multiply);
        result = username.charAt(0) + result;

        return Base64.getEncoder().encodeToString(result.getBytes(StandardCharsets.UTF_8));
    }

}
