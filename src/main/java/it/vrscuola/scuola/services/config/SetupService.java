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

package it.vrscuola.scuola.services.config;

import it.vrscuola.scuola.models.SetupModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Service
public class SetupService {

    @Value("${school.setup.file}")
    private String configFile;

    @Autowired
    private ServletContext context;

    // scrive un file di configurazione a partire dal modello di setupModel
    public void writeConfig(SetupModel setupModel) {
        try {
            // Percorso completo del file di configurazione
            String filePath = "/" + configFile;

            // file di testo in modalità scrittura
            BufferedWriter writer = new BufferedWriter(new FileWriter(configFile));

            // tutti i campi dell'oggetto "SetupModel"
            Map<String, String> fields = setupModel.toMap();

            // aggiungi riga bash
            writer.write("#!/bin/bash" + "\n");

            // riga vuota
            writer.write( "\n");

            // mapping nel file di testo
            for (Map.Entry<String, String> entry : fields.entrySet()) {
                String key = entry.getKey().replaceAll("([A-Z]+)", "_$1").toUpperCase();
                String value = entry.getValue();
                writer.write(key + "=" + '"' + value + '"' + "\n");
            }

            // chiudi file di testo
            writer.close();
        } catch (
                IOException e) {
            e.printStackTrace();
        }
    }

    // verifica l'esistenza del file di configurazione e ritorna un JSON con lo stato "ok" se il file esiste e "ko" se il file non esiste
    public Map<String, String> checkConfigFile() {

        // Percorso completo del file di configurazione
        String filePath = "/var/lib/tomcat9/" + configFile;

        File file = new File(filePath);

        Map<String, String> result = new HashMap<>();
        if (file.exists() && !file.isDirectory()) {
            result.put("state", "ok");
        } else {
            result.put("state", "ko");
        }

        return result;
    }
}
