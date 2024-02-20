package org.duckdns.vrscuola.repositories.questions;

import org.duckdns.vrscuola.entities.questions.ScoreEntitie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ScoreRepository extends JpaRepository<ScoreEntitie, Long> {
}
