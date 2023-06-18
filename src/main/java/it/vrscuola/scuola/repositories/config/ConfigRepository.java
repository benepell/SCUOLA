package it.vrscuola.scuola.repositories.config;

import it.vrscuola.scuola.entities.config.ConfigEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;

@Repository
public interface ConfigRepository extends JpaRepository<ConfigEntitie, Long> {
    @Query(value = "SELECT value FROM config c WHERE c.name =:name")
    String findByName(@Param("name") String name);

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM config c WHERE ( c.name = :name )")
    Boolean existsByName(@Param("name") String name);

    @Transactional
    @Modifying
    @Query(value = "UPDATE config c set c.value = :value WHERE  c.name = :name  ")
    void updateValue(@Param("value") String value,@Param("name") String name);

}
