package org.duckdns.vrscuola.repositories.questions;

import org.duckdns.vrscuola.entities.questions.ScoreEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ScoreRepository extends JpaRepository<ScoreEntitie, Long> {
    @Query("SELECT s FROM ScoreEntitie s WHERE s.username = :username AND s.attemptId = :attemptId ORDER BY s.id DESC")
    List<ScoreEntitie> findByUsernameAndAttemptId(@Param("username") String username, @Param("attemptId") Long attemptId);
}
