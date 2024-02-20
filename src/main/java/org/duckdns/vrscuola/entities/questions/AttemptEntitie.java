package org.duckdns.vrscuola.entities.questions;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.Date;
import java.util.List;

@Entity(name = "attempt")
@Data
public class AttemptEntitie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_file_id")
    @ToString.Exclude  // Escludi questo campo dal metodo toString() per prevenire la ricorsione
    private UserFileEntitie userFileEntitie;

    @Temporal(TemporalType.TIMESTAMP)
    private Date attemptDate = new Date();

    @OneToMany(mappedBy = "attemptEntitie")
    @ToString.Exclude
    private List<QuestionEntitie> questions;

}