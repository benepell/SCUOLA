package org.duckdns.vrscuola.repositories.questions;

import org.duckdns.vrscuola.entities.questions.AnswerEntitie;
import org.duckdns.vrscuola.entities.questions.CorrectAnswerEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CorrectAnswerRepository extends JpaRepository<CorrectAnswerEntitie, Long> {
    @Query("SELECT ca FROM correct_answer ca WHERE ca.questionEntitie.id = :questionId")
    List<CorrectAnswerEntitie> findCorrectAnswersByQuestionId(@Param("questionId") Long questionId);

}