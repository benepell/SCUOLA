package online.vrscuola.repositories.connect;


import online.vrscuola.entities.connect.Connect;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ConnectRepository extends JpaRepository<Connect, Long> {

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM connect c WHERE ( c.macAddress = :mac )")
    Boolean existsByMacAddress(@Param("mac") String mac);

    @Query(value = "SELECT username FROM connect c WHERE ( c.macAddress = :mac )")
    String existsUsername(@Param("mac") String mac);

}
