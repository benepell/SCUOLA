package org.duckdns.vrscuola.entities.questions;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "score")
@Data
public class ScoreEntitie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column
    private Integer scoreValue;

    @Column
    private Integer totalQuestions;

    @Column
    private String username;

    @Column
    private Long attemptId;

}