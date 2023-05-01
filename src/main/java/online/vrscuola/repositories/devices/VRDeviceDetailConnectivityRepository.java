package online.vrscuola.repositories.devices;

import online.vrscuola.entities.devices.VRDeviceDetailConnectivityEntitie;
import online.vrscuola.models.DetailConnectInfoModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.time.Instant;
import java.util.List;

@Repository
public interface VRDeviceDetailConnectivityRepository extends JpaRepository<VRDeviceDetailConnectivityEntitie, Long> {

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM detailconnect d WHERE d.username = :username")
    Boolean usernameExist(@Param("username") String username);

    @Query(value = "SELECT d.minutes FROM detailconnect d WHERE d.username = :username")
    Long findMinutes(@Param("username") String username);

    @Query(value = "SELECT d.startDate, d.endDate, d.minutes FROM detailconnect d WHERE d.username = :username")
    List<Object[]> findValues(@Param("username") String username);

    @Transactional
    default void insertStartDate(String username) {
        VRDeviceDetailConnectivityEntitie entity = new VRDeviceDetailConnectivityEntitie();
        entity.setUsername(username);
        entity.setStartDate(Instant.now());
        save(entity);
    }
    @Transactional
    @Modifying
    @Query(value = "UPDATE detailconnect d SET d.startDate = :timestamp WHERE d.username = :username")
    void updateStartDate(@Param("timestamp") Instant timestamp ,@Param("username") String username);

    @Transactional
    @Modifying
    @Query(value = "UPDATE detailconnect d SET d.endDate = :timestamp WHERE d.username = :username")
    void updateEndDate(@Param("timestamp") Instant timestamp,@Param("username") String username);

    @Transactional
    @Modifying
    @Query(value = "UPDATE detailconnect d SET d.minutes = :minutes WHERE d.username = :username")
    void updateMinutes(@Param("minutes") Long minutes,@Param("username") String username);

    @Transactional
    @Modifying
    @Query(value = "UPDATE detailconnect d SET d.startDate = '0', d.endDate = '0' WHERE d.username = :username")
    void resetDate(@Param("username") String username);

    @Transactional
    @Modifying
    @Query(value = "UPDATE detailconnect d SET d.minutes = 0, d.startDate = 0, d.endDate = 0 WHERE d.username = :username")
    void resetAll(@Param("username") String username);

}
