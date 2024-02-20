package org.duckdns.vrscuola.repositories.questions;


import org.duckdns.vrscuola.entities.questions.QuestionEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface QuestionRepository extends JpaRepository<QuestionEntitie, Long> {
    List<QuestionEntitie> findByAttemptEntitieId(Long attemptId);

}
