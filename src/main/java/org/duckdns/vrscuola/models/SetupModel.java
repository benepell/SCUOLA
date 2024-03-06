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

package org.duckdns.vrscuola.models;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data
public class SetupModel {
    private String tokenDuckdns;
    private String codiceDiRegistrazioneScuola;
    private String baseScuola;
    private String baseKeycloak;
    private String baseRisorse;

    public Map<String, String> toMap() {
        Map<String, String> fields = new HashMap<>();
        fields.put("tokenDuckdns", tokenDuckdns);
        fields.put("codiceDiRegistrazioneScuola", codiceDiRegistrazioneScuola);
        fields.put("baseScuola", baseScuola);
        fields.put("baseKeycloak", baseKeycloak);
        fields.put("baseRisorse", baseRisorse);

        return fields;
    }

    // getters e setters omessi per brevità
}
