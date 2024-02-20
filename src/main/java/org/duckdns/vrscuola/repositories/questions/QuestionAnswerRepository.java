package org.duckdns.vrscuola.repositories.questions;

import org.duckdns.vrscuola.entities.questions.QuestionAnswer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface QuestionAnswerRepository extends JpaRepository<QuestionAnswer, Long> {
}
