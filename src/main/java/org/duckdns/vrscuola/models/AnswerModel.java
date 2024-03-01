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

import java.util.List;

@Data
public class AnswerModel {
    private String aula;
    private String classe;
    private String sezione;
    private String argomento;
    private String text;
    private String username;
    private List<QuestionAnswerPair> questionAnswers; // Lista di coppie domanda-risposta

    @Data
    public static class QuestionAnswerPair {
        private String questionId;
        private List<String> answerIds; // Lista degli ID delle risposte selezionate per ogni domanda
        private Long attemptId;
    }
}