package org.duckdns.vrscuola.entities.questions;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.Date;
import java.util.List;

@Entity(name = "question")
@Data
public class QuestionEntitie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Lob
    private String domanda;

    @ManyToOne
    @JoinColumn(name = "attempt_id")
    private AttemptEntitie attemptEntitie;

    @Column
    private String media;

    @Temporal(TemporalType.TIMESTAMP)
    private Date data = new Date();

    @ToString.Exclude
    @OneToMany(mappedBy = "questionEntitie", cascade = CascadeType.ALL)
    private List<AnswerEntitie> risposte;

    @ToString.Exclude
    @OneToMany(mappedBy = "questionEntitie", cascade = CascadeType.ALL)
    private List<CorrectAnswerEntitie> corrette;

}