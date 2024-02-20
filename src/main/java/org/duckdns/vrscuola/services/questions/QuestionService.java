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

package org.duckdns.vrscuola.services.questions;

import org.duckdns.vrscuola.entities.questions.*;
import org.duckdns.vrscuola.models.QuestionModel;
import org.duckdns.vrscuola.models.RispostaModel;
import org.duckdns.vrscuola.repositories.questions.*;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Service
public class QuestionService {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private UserFileRepository userFileRepository;

    @Autowired
    private AnswerRepository answerRepository;

    @Autowired
    private AttemptRepository attemptRepository;

    @Autowired
    private CorrectAnswerRepository correctAnswerRepository;

    public List<QuestionModel> scriviDomandeInDb(List<QuestionModel> domande, String username, String hash, String textName) {
        UserFileEntitie userFileEntitie = userFileRepository.findByUsernameAndFileHash(username, hash)
                .orElseGet(() -> {
                    UserFileEntitie newUserFileEntitie = new UserFileEntitie();
                    newUserFileEntitie.setUsername(username);
                    newUserFileEntitie.setFileHash(hash);
                    newUserFileEntitie.setTextName(textName);
                    return userFileRepository.save(newUserFileEntitie);
                });

        AttemptEntitie attemptEntitie = new AttemptEntitie();
        attemptEntitie.setUserFileEntitie(userFileEntitie);
        attemptEntitie = attemptRepository.save(attemptEntitie);

        AttemptEntitie finalAttemptEntitie = attemptEntitie;
        List<QuestionModel> domandeAggiornate = domande.stream().map(model -> {
            QuestionEntitie q = new QuestionEntitie();
            q.setDomanda(model.getDomanda());
            q.setMedia(model.getMedia());
            q.setAttemptEntitie(finalAttemptEntitie);
            q = questionRepository.save(q); // Salva la domanda per ottenere l'ID

            // Aggiorna l'ID della domanda nel modello
            model.setId(String.valueOf(q.getId()));

            QuestionEntitie finalQ = q;
            AtomicInteger posix = new AtomicInteger(1);
            List<RispostaModel> risposteAggiornate = model.getRisposte().stream().map(rispostaModel -> {
                AnswerEntitie answerEntitie = new AnswerEntitie();
                answerEntitie.setRisposta(rispostaModel.getTesto());
                AttemptEntitie tmpAttempt = new AttemptEntitie();
                tmpAttempt.setId(finalAttemptEntitie.getId());
                answerEntitie.setAttemptEntitie(tmpAttempt);
                answerEntitie.setPosizione(posix.get());
                answerEntitie.setQuestionEntitie(finalQ);
                answerEntitie = answerRepository.save(answerEntitie);
                // Aggiorna l'ID della risposta nel modello
                rispostaModel.setId(String.valueOf(answerEntitie.getId()));
                posix.getAndIncrement();
                return rispostaModel;
            }).collect(Collectors.toList());

            // Aggiungi la logica per salvare le risposte corrette
            List<RispostaModel> risposteCorretteAggiornate = model.getCorrette().stream().map(rispostaCorrettaModel -> {
                CorrectAnswerEntitie correctAnswerEntitie = new CorrectAnswerEntitie();
                correctAnswerEntitie.setCorretta(rispostaCorrettaModel.getTesto());
                correctAnswerEntitie.setQuestionEntitie(finalQ);
                correctAnswerEntitie = correctAnswerRepository.save(correctAnswerEntitie);
                // Aggiorna l'ID della risposta corretta nel modello
                rispostaCorrettaModel.setId(String.valueOf(correctAnswerEntitie.getId()));
                return rispostaCorrettaModel;
            }).collect(Collectors.toList());

            // Aggiorna le risposte corrette con gli ID nel modello della domanda
            model.setCorrette(risposteCorretteAggiornate);


            // Aggiorna le risposte con gli ID nel modello della domanda
            model.setRisposte(risposteAggiornate);

            return model; // Restituisce il modello aggiornato con gli ID
        }).collect(Collectors.toList());

        return domandeAggiornate;
    }


    public List<QuestionModel> leggiDomandeDaFile(String percorsoFile, String baselink) throws IOException {
        List<String> linee = Files.readAllLines(Paths.get(percorsoFile));
        List<QuestionModel> domande = new ArrayList<>();
        String domanda = null;
        String media = null; // Inizializza media qui per tener traccia dell'URL per ogni domanda
        List<RispostaModel> risposte = new ArrayList<>();
        List<RispostaModel> risposteCorrette = new ArrayList<>();

        for (String linea : linee) {
            if (linea.startsWith(Constants.QUESTIONS_TAG_DOMANDA)) {
                if (domanda != null) {
                    String tmpMedia = media != null ? baselink + media : null;
                    domande.add(new QuestionModel("0", domanda, tmpMedia, new ArrayList<>(risposte), new ArrayList<>(risposteCorrette)));
                    // Reset delle liste per la nuova domanda
                    risposte = new ArrayList<>();
                    risposteCorrette = new ArrayList<>();
                }
                // Estrai la domanda e verifica la presenza dell'URL del media
                int mediaIndex = linea.indexOf(Constants.QUESTIONS_TAG_MEDIA_START);
                if (mediaIndex != -1) {
                    domanda = linea.substring(Constants.QUESTIONS_TAG_DOMANDA.length(), mediaIndex).trim();
                    media = linea.substring(mediaIndex + Constants.QUESTIONS_TAG_MEDIA_START.length(),
                            linea.lastIndexOf(Constants.QUESTIONS_TAG_MEDIA_END)).trim();
                } else {
                    domanda = linea.substring(Constants.QUESTIONS_TAG_DOMANDA.length()).trim();
                    media = null; // Reset di media se non presente
                }
            } else if (linea.matches("^[1-8]\\) .*")) {
                String risp = linea.substring(3);
                String mediaRisp = null;
                int mediaIdx = linea.indexOf(Constants.QUESTIONS_TAG_MEDIA_START);
                if (mediaIdx != -1) {
                    risp = linea.substring(3, mediaIdx).trim();
                    mediaRisp = linea.substring(mediaIdx + Constants.QUESTIONS_TAG_MEDIA_START.length(),
                            linea.lastIndexOf(Constants.QUESTIONS_TAG_MEDIA_END)).trim();
                }
                String tmpMediaRisp = mediaRisp != null ? baselink + mediaRisp : null;
                risposte.add(new RispostaModel("0", risp, tmpMediaRisp));
            } else if (linea.startsWith(Constants.QUESTIONS_TAG_CORRETTA)) {
                // Estrazione e gestione delle risposte corrette
                int inizioTestoCorretta = linea.indexOf(Constants.QUESTIONS_TAG_CORRETTA) + Constants.QUESTIONS_TAG_CORRETTA.length();
                String testoRisposteCorrette = linea.substring(inizioTestoCorretta).trim();

                // Gestione delle risposte corrette con separatore
                if (testoRisposteCorrette.contains(Constants.QUESTIONS_SEPARATOR)) {
                    List<RispostaModel> finalRisposteCorrette = risposteCorrette;
                    Arrays.stream(testoRisposteCorrette.split(Constants.QUESTIONS_SEPARATOR))
                            .forEach(corretta -> finalRisposteCorrette.add(new RispostaModel("0", corretta, null))); // Imposta l'ID di default
                } else {
                    risposteCorrette.add(new RispostaModel("0", testoRisposteCorrette, null)); // la risposta corretta non ha media quindi null
                }
            }
        }

        // Aggiungi l'ultima domanda processata dopo l'uscita dal ciclo
        if (domanda != null) {
            domande.add(new QuestionModel("0", domanda, media, new ArrayList<>(risposte), new ArrayList<>(risposteCorrette)));
        }

        // Mescola le domande in ordine casuale
        if (Constants.QUESTIONS_RANDOM) {
            Collections.shuffle(domande);
        }

        return domande;
    }

}
