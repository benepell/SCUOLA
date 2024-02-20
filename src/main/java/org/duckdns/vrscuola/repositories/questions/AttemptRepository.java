package org.duckdns.vrscuola.repositories.questions;

import org.duckdns.vrscuola.entities.questions.AttemptEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface AttemptRepository extends JpaRepository<AttemptEntitie, Long> {
    @Query("SELECT a FROM attempt a JOIN a.userFileEntitie u WHERE u.username = :username ORDER BY a.attemptDate DESC")
    List<AttemptEntitie> findLatestAttemptByUserName(@Param("username") String username);
}