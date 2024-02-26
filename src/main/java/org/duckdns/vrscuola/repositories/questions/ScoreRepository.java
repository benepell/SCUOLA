package org.duckdns.vrscuola.repositories.questions;

import org.duckdns.vrscuola.entities.questions.ScoreEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface ScoreRepository extends JpaRepository<ScoreEntitie, Long> {
    @Query("SELECT s FROM ScoreEntitie s WHERE s.username = :username AND s.attemptId = :attemptId ORDER BY s.id DESC")
    List<ScoreEntitie> findByUsernameAndAttemptId(@Param("username") String username, @Param("attemptId") Long attemptId);

    @Query("SELECT s FROM ScoreEntitie s")
    List<ScoreEntitie> findAllScores();

    // ritorna score con username piu recente sulla base del range temporale
    @Query(value = "SELECT s.* " +
            "FROM score s " +
            "INNER JOIN ( " +
            "  SELECT MAX(s.id) as maxId " +
            "  FROM score s " +
            "  JOIN attempt a ON s.attemptId = a.id " +
            "  WHERE a.attemptDate BETWEEN :start AND :end " +
            "  GROUP BY s.username " +
            ") AS latestScores ON s.id = latestScores.maxId;", nativeQuery = true)
    List<ScoreEntitie> findScoresInTimeRange(@Param("start") String start, @Param("end") String end);
}
