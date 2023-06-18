package it.vrscuola.scuola.repositories.log;

import it.vrscuola.scuola.entities.log.EventLogEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;

@SuppressWarnings("unused")
@Repository
public interface EventLogRepository extends JpaRepository<EventLogEntitie, Long> {
    List<EventLogEntitie> findByUsername(String username);
    List<EventLogEntitie> findByEvent(String event);
    List<EventLogEntitie> findByEventDate(Instant eventDate);
    List<EventLogEntitie> findByUsernameAndEvent(String username, String event);
    List<EventLogEntitie> findByUsernameAndEventDate(String username, Instant eventDate);
    List<EventLogEntitie> findByEventAndEventDate(String event, Instant eventDate);
    List<EventLogEntitie> findByUsernameAndEventAndEventDate(String username, String event, Instant eventDate);
    List<EventLogEntitie> findAll();

}