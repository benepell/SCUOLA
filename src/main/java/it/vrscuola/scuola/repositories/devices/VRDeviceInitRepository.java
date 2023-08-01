package it.vrscuola.scuola.repositories.devices;

import it.vrscuola.scuola.entities.devices.VRDeviceInitEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository
public interface VRDeviceInitRepository extends JpaRepository<VRDeviceInitEntitie, Long> {

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM init i WHERE i.macAddress =:mac")
    Boolean existsByMacAddress(@Param("mac") String mac);

    @Query(value = "SELECT label FROM init i WHERE i.macAddress =:mac and FUNCTION('abs', i.batteryLevel) > :batteryLevel")
    String labelByMacAddress(@Param("mac") String mac,@Param("batteryLevel") int batteryLevel);

    @Query(value = "SELECT code FROM init i WHERE i.macAddress =:mac")
    String codeByMacAddress(@Param("mac") String mac);

    @Query(value = "SELECT label FROM init i WHERE FUNCTION('abs', i.batteryLevel) > :batteryLevel and i.classroom = :classroom" )
    List<String> labels(@Param("batteryLevel") int batteryLevel, @Param("classroom") String classroom);

    @Query(value = "SELECT label FROM init i WHERE i.classroom =:classroom")
    List<String> labelsSetup(String classroom);

    @Query(value = "SELECT i.macAddress FROM init i WHERE i.classroom =:classroom")
    List<String> macsSetup(String classroom);

    @Query(value = "SELECT i.batteryLevel FROM init i WHERE i.classroom =:classroom")
    List<String> battSetup(String classroom);

    @Query(value = "SELECT COUNT(*) FROM init i")
    int getCount();

    @Query(value = "SELECT MAX(id) + 1 FROM init i")
    int getNextAvailableId();
    @Query(value = "SELECT i.label "
            + "FROM init i "
            + "JOIN connect c ON i.macAddress = c.macAddress "
            + "WHERE c.username = :username and c.connected != 'disconnected' and i.classroom = :classroom")
    String findLabelByUsername(@Param("username") String username, @Param("classroom") String classroom);

    @Query(value = "SELECT i.label "
            + "FROM init i "
            + "JOIN connect c ON i.macAddress = c.macAddress "
            + "WHERE (i.label = :label  AND FUNCTION('abs', i.batteryLevel) >  :batteryLevel)")
    String findLabelAvailable(@Param("label") String label, @Param("batteryLevel") int batteryLevel);

    @Query(value = "SELECT macAddress FROM init i WHERE i.label =:label")
    String findMac(@Param("label") String label);
    @Transactional
    @Modifying
    @Query(value = "UPDATE init i set i.macAddress = :newmac, i.note = :note, i.code = :code WHERE  i.macAddress = :oldmac  ")
    void updateByMacAddress(@Param("oldmac") String oldmac,@Param("newmac") String newmac,@Param("note") String note, @Param("code") String code );

    @Transactional
    @Modifying
    @Query(value = "UPDATE init i set i.batteryLevel = :batteryLevel WHERE  i.macAddress = :mac  ")
    void updateBatteryLevel(@Param("mac") String mac,@Param("batteryLevel") int batteryLevel);
}

