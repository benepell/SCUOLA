package org.duckdns.vrscuola.entities.questions;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

@Entity(name = "correct_answer")
@Data
public class CorrectAnswerEntitie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "question_id")
    @ToString.Exclude
    private QuestionEntitie questionEntitie;

    @Lob
    private String corretta;


}