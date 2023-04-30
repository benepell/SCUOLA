package online.vrscuola.repositories.devices;

import online.vrscuola.entities.devices.VRDeviceInitEntitie;
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

    @Query(value = "SELECT label FROM init i WHERE i.macAddress =:mac")
    String labelByMacAddress(@Param("mac") String mac);

    @Query(value = "SELECT label FROM init i ")
    List<String> labels();

    @Query(value = "SELECT macAddress FROM init i WHERE i.label =:label")
    String findMac(@Param("label") String label);
    @Transactional
    @Modifying
    @Query(value = "UPDATE init i set i.macAddress = :newmac, i.note = :note WHERE  i.macAddress = :oldmac  ")
    void updateByMacAddress(@Param("oldmac") String oldmac,@Param("newmac") String newmac,@Param("note") String note );

}
