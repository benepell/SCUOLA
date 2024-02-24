package org.duckdns.vrscuola.repositories.questions;

import jakarta.transaction.Transactional;
import org.duckdns.vrscuola.entities.questions.AnswerEntitie;
import org.duckdns.vrscuola.entities.questions.AttemptEntitie;
import org.duckdns.vrscuola.entities.questions.CorrectAnswerEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AnswerRepository extends JpaRepository<AnswerEntitie, Long> {

    @Query("SELECT a FROM answer a WHERE a.questionEntitie.id = :questionId")
    List<AnswerEntitie> findAnswersByQuestionId(@Param("questionId") Long questionId);

    @Query("SELECT a FROM answer a WHERE a.questionEntitie.id = :questionId AND a.id IN :userAnswerIds")
    List<AnswerEntitie> findByQuestionIdAndIdIn(Long questionId, List<Long> userAnswerIds);

    @Query("SELECT a FROM answer a WHERE a.questionEntitie.id = :questionId AND a.questionEntitie.attemptEntitie = :attemptId AND a.id IN :userAnswerIds")
    List<AnswerEntitie> findByQuestionIdAndAttemptIdAndIdIn(Long questionId, AttemptEntitie attemptId, List<Long> userAnswerIds);

    @Modifying
    @Query("UPDATE answer a SET a.corretto = null WHERE a.questionEntitie.id = :questionId")
    void resetCorrettoByQuestionId(@Param("questionId") Long questionId);

    @Transactional
    @Modifying
    @Query("UPDATE answer a SET a.corretto = :corretto WHERE a.id = :answerId AND a.questionEntitie.id = :questionId")
    void updateCorrettoById(Long answerId, Long questionId, boolean corretto);
}
