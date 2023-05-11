package online.vrscuola.repositories.devices;


import online.vrscuola.entities.devices.VRDeviceConnectivityEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.time.Instant;
import java.util.Date;

@Repository
public interface VRDeviceConnectivityRepository extends JpaRepository<VRDeviceConnectivityEntitie, Long> {

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM connect c WHERE ( c.macAddress = :mac )")
    Boolean existsByMacAddress(@Param("mac") String mac);

    @Query(value = "SELECT username FROM connect c WHERE ( c.macAddress = :mac )")
    String existsUsername(@Param("mac") String mac);

    @Query("SELECT c.macAddress FROM connect c WHERE c.macAddress = :mac")
    String findMac(@Param("mac") String mac);

    @Transactional
    @Modifying
    @Query(value = "UPDATE connect c set c.initDate=:initDate,c.username = :username, c.note = :note, c.connected = :connected WHERE  c.macAddress = :macAddress  ")
    void updateByMacAddress(@Param("initDate") Instant initDate, @Param("username") String username, @Param("note") String note, @Param("macAddress") String macAddress, @Param("connected") String connected );

    @Transactional
    @Modifying
    @Query(value = "UPDATE connect c set c.initDate=:initDate,c.username = :username, c.note = :note, c.connected = :connected, c.argoment = :arg WHERE  c.macAddress = :macAddress  ")
    void updateByMacAddress2(@Param("initDate") Instant initDate, @Param("username") String username, @Param("note") String note, @Param("macAddress") String macAddress, @Param("connected") String connected, @Param("arg") String arg);

    @Transactional
    @Modifying
    @Query(value = "UPDATE connect c set c.initDate=:initDate, c.argoment = :argoment WHERE c.macAddress = :macAddress  ")
    void updateArgomentByVisore(@Param("initDate") Instant initDate, @Param("argoment") String argoment,  @Param("macAddress") String macAddress);

    @Transactional
    @Modifying
    @Query(value = "DELETE FROM connect c WHERE c.username NOT LIKE :prefix")
    void deleteByUsernameNotLike(@Param("prefix") String prefix);
}

