package org.duckdns.vrscuola.repositories.config;

import jakarta.transaction.Transactional;
import org.duckdns.vrscuola.entities.config.SessionEntity; // Import dell'entità corretto
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;

@Repository
public interface SessionRepository extends JpaRepository<SessionEntity, Long> {
    @Query("SELECT s.value FROM SessionEntity s WHERE (s.name =:name AND s.username =:username AND s.lab =:lab)")
    String getAttribute(@Param("name") String name, @Param("username") String username, @Param("lab") String lab);

    @Query("SELECT CASE WHEN COUNT(s) > 0 THEN true ELSE false END FROM SessionEntity s WHERE (s.name =:name AND s.username =:username AND s.lab =:lab)")
    Boolean exists(@Param("name") String name, @Param("username") String username, @Param("lab") String lab);

    @Transactional
    @Modifying
    @Query("UPDATE SessionEntity s SET s.value = :value, s.sessionDate=:sessionDate WHERE (s.name =:name AND s.username =:username AND s.lab =:lab)")
    void setAttribute(@Param("name") String name, @Param("value") String value, @Param("username") String username, @Param("lab") String lab, @Param("sessionDate") Instant sessionDate);

    @Transactional
    @Modifying
    @Query("DELETE FROM SessionEntity s WHERE s.name = :name AND s.username = :username AND s.lab = :lab")
    void removeAttribute(@Param("name") String name, @Param("username") String username, @Param("lab") String lab);

}
