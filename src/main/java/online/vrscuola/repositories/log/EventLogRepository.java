package online.vrscuola.repositories.log;

import online.vrscuola.entities.log.EventLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@SuppressWarnings("unused")
@Repository
public interface EventLogRepository extends JpaRepository<EventLog, Long> {
}

