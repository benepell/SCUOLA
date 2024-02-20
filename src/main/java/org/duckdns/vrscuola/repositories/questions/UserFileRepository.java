package org.duckdns.vrscuola.repositories.questions;

import org.duckdns.vrscuola.entities.questions.UserFileEntitie;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserFileRepository extends JpaRepository<UserFileEntitie, Long> {
    Optional<UserFileEntitie> findByUsernameAndFileHash(String username, String fileHash);
    Optional<UserFileEntitie> findFirstByUsernameOrderByIdDesc(String username);

}
