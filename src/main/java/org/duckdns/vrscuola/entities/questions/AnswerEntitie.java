package org.duckdns.vrscuola.entities.questions;

import jakarta.persistence.*;
import lombok.Data;

@Entity(name = "answer")
@Data
public class AnswerEntitie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "question_id")
    private QuestionEntitie questionEntitie;

    @ManyToOne
    @JoinColumn(name = "attempt_id")
    private AttemptEntitie attemptEntitie;

    @Lob
    private String risposta;

    @Column
    private Integer posizione;

    @Column
    private Boolean corretto;


}