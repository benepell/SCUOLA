package org.duckdns.vrscuola.entities.questions;


import jakarta.persistence.*;
import lombok.Data;
import java.time.Instant;

@Entity
@Table(name = "response")
@Data
public class ResponseEntitie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String aula;

    @Column(nullable = false)
    private String classe;

    @Column(nullable = false)
    private String sezione;

    @Column(nullable = false)
    private String argomento;

    @Column
    private String text;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false, columnDefinition = "TIMESTAMP")
    private Instant data;

}