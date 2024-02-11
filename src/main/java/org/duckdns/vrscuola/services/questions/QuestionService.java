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

package org.duckdns.vrscuola.services.questions;

import org.duckdns.vrscuola.models.QuestionModel;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

@Service
public class QuestionService {

    public List<QuestionModel> leggiDomandeDaFile(String percorsoFile) throws IOException {
        List<String> linee = Files.readAllLines(Paths.get(percorsoFile));
        List<QuestionModel> domande = new ArrayList<>();
        String domanda = null;
        List<String> risposte = new ArrayList<>();
        // Lista per memorizzare le risposte corrette codificate in base64
        List<String> risposteCorretteCodificate = new ArrayList<>();

        for (String linea : linee) {
            if (linea.startsWith("Domanda: ")) {
                if (domanda != null) {
                    // Aggiungi la domanda precedente con le sue risposte e le risposte corrette codificate
                    domande.add(new QuestionModel(domanda, new ArrayList<>(risposte), new ArrayList<>(risposteCorretteCodificate)));
                    risposte = new ArrayList<>();
                    risposteCorretteCodificate.clear(); // Prepara per la prossima domanda
                }
                int inizioTestoDomanda = linea.indexOf(":") + 2;
                domanda = linea.substring(inizioTestoDomanda);
            } else if (linea.startsWith("A) ") || linea.startsWith("B) ") || linea.startsWith("C) ")
                    || linea.startsWith("D) ") || linea.startsWith("E) ")
                    || linea.startsWith("F) ") || linea.startsWith("G) ")
            ) {
                risposte.add(linea);
            } else if (linea.startsWith("Risposta corretta: ")) {
                int inizioTestoCorretta = linea.indexOf(":") + 2;
                List<String> risposteCorretteTemp = new ArrayList<>(Arrays.asList(linea.substring(inizioTestoCorretta).split(Constants.QUESTIONS_SEPARATOR)));
                String risposteConcatenate = String.join(Constants.QUESTIONS_SEPARATOR, risposteCorretteTemp);
                String risposteCorretteCodificateString = Base64.getEncoder().encodeToString(risposteConcatenate.getBytes());
                risposteCorretteCodificate.add(risposteCorretteCodificateString); // Usa questa lista separata per le risposte codificate
            }
        }

        // Aggiungi l'ultima domanda se esiste
        if (domanda != null) {
            domande.add(new QuestionModel(domanda, new ArrayList<>(risposte), new ArrayList<>(risposteCorretteCodificate)));
        }

        // Mescola le domande in ordine casuale
        if (Constants.QUESTIONS_RANDOM) {
            Collections.shuffle(domande);
        }

        return domande;
    }
}
