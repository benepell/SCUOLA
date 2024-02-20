package org.duckdns.vrscuola.repositories.questions;

import org.duckdns.vrscuola.entities.questions.CorrectAnswerEntitie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CorrectAnswerRepository extends JpaRepository<CorrectAnswerEntitie, Long> {
}