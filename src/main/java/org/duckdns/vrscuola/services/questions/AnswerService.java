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


import org.duckdns.vrscuola.entities.questions.AnswerEntitie;
import org.duckdns.vrscuola.models.AnswerModel;
import org.duckdns.vrscuola.repositories.questions.AnswerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;

@Service
public class AnswerService {

    @Autowired
    private AnswerRepository answerRepository;

    // Metodo esistente
    public AnswerEntitie save(AnswerEntitie answer) {
        return answerRepository.save(answer);
    }

    // Nuovo metodo per inizializzare e salvare una risposta
    public AnswerEntitie initAndSave(AnswerModel answerDTO) {
        AnswerEntitie answer = new AnswerEntitie();
        answer.setAula(answerDTO.getAula());
        answer.setClasse(answerDTO.getClasse());
        answer.setSezione(answerDTO.getSezione());
        answer.setArgomento(answerDTO.getArgomento());
        answer.setText(answerDTO.getText());
        answer.setUsername(answerDTO.getUsername());
        answer.setDomanda(answerDTO.getDomanda());
        answer.setRisposteSelezionate(answerDTO.getRisposteSelezionate());
        answer.setRisposteCorrette(answerDTO.getRisposteCorrette());
        answer.setData(Instant.now()); // Imposta la data corrente

        return this.save(answer);
    }
}