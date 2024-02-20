package org.duckdns.vrscuola.entities.questions;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "question_answer")
@Data
public class QuestionAnswer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "response_id", nullable = false)
    private ResponseEntitie response;

    @Column(nullable = false)
    private String questionId;

    @Column(nullable = false)
    private String answerIds; // Considera di utilizzare JSON o un approccio simile per memorizzare le liste

    @Column
    private String posizione;


}