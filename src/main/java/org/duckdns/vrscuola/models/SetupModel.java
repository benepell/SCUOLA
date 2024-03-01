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
    private String passwordServerScuola;
    private String codiceDiRegistrazioneScuola;
    private String versioneSoftware;
    private String baseScuola;
    private String baseKeycloak;
    private String baseRisorse;
    private String certScuola;
    private String certKeycloak;
    private String domainScuola;
    private String domainKeycloak;
    private String certPassword;
    private String certAliasScuola;
    private String certAliasKeycloak;
    private String dbScuolaName;
    private String dbScuolaUsername;
    private String dbScuolaPassword;
    private String dbScuolaBridgeUsername;
    private String dbScuolaBridgePassword;
    private String dbKeycloakName;
    private String dbKeycloakUsername;
    private String dbKeycloakPassword;
    private String keycloakDir;
    private String keycloakAdminUsername;
    private String keycloakAdminPassword;
    private String keycloakClientId;

    public Map<String, String> toMap() {
        Map<String, String> fields = new HashMap<>();
        fields.put("passwordServerScuola", passwordServerScuola);
        fields.put("codiceDiRegistrazioneScuola", codiceDiRegistrazioneScuola);
        fields.put("versioneSoftware", versioneSoftware);
        fields.put("baseScuola", baseScuola);
        fields.put("baseKeycloak", baseKeycloak);
        fields.put("baseRisorse", baseRisorse);
        fields.put("certScuola", certScuola);
        fields.put("certKeycloak", certKeycloak);
        fields.put("domainScuola", domainScuola);
        fields.put("domainKeycloak", domainKeycloak);
        fields.put("certPassword", certPassword);
        fields.put("certAliasScuola", certAliasScuola);
        fields.put("certAliasKeycloak", certAliasKeycloak);
        fields.put("dbScuolaName", dbScuolaName);
        fields.put("dbScuolaUsername", dbScuolaUsername);
        fields.put("dbScuolaPassword", dbScuolaPassword);
        fields.put("dbScuolaBridgeUsername", dbScuolaBridgeUsername);
        fields.put("dbScuolaBridgePassword", dbScuolaBridgePassword);
        fields.put("dbKeycloakName", dbKeycloakName);
        fields.put("dbKeycloakUsername", dbKeycloakUsername);
        fields.put("dbKeycloakPassword", dbKeycloakPassword);
        fields.put("keycloakDir", keycloakDir);
        fields.put("keycloakAdminUsername", keycloakAdminUsername);
        fields.put("keycloakAdminPassword", keycloakAdminPassword);
        fields.put("keycloakClientId", keycloakClientId);

        return fields;
    }

    // getters e setters omessi per brevità
}
