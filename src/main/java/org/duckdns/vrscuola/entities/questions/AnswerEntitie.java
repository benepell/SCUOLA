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

package org.duckdns.vrscuola.entities.questions;


import jakarta.persistence.*;
import lombok.Data;

import java.time.Instant;

@Entity(name = "answer")
@Data
public class AnswerEntitie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "aula", nullable = false)
    private String aula;

    @Column(name = "classe", nullable = false)
    private String classe;

    @Column(name = "sezione", nullable = false)
    private String sezione;

    @Column(name = "argomento", nullable = false)
    private String argomento;

    @Column(name = "text")
    private String text;

    @Column(name = "username", nullable = false)
    private String username;

    @Column(name = "domanda", nullable = false)
    private String domanda;

    @Column(name = "risposte_selezionate", nullable = false)
    private String risposteSelezionate;

    @Column(name = "risposte_corrette", nullable = false)
    private String risposteCorrette;

    @Column(name = "data", nullable = false, columnDefinition = "TIMESTAMP")
    private Instant data;

}
