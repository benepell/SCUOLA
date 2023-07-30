package it.vrscuola.scuola.repositories.devices;


import it.vrscuola.scuola.entities.devices.VRDeviceConnectivityEntitie;
import it.vrscuola.scuola.models.VRDeviceConnectivityModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Repository
public interface VRDeviceConnectivityRepository extends JpaRepository<VRDeviceConnectivityEntitie, Long> {

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM connect c WHERE ( c.macAddress = :mac )")
    Boolean existsByMacAddress(@Param("mac") String mac);

    @Query(value = "SELECT username FROM connect c WHERE ( c.macAddress = :mac )")
    String existsUsername(@Param("mac") String mac);

    @Query("SELECT c.macAddress FROM connect c WHERE c.macAddress = :mac")
    String findMac(@Param("mac") String mac);

    @Query("SELECT  c.username FROM connect c")
    String[] findAllUsers();

    @Query("SELECT c.id, c.macAddress, c.initDate, c.username, c.note, c.connected, c.argoment FROM connect c")
    List<Object[]> findAllUsername();

    default List<VRDeviceConnectivityModel> findAllConnectivityModels() {
        List<Object[]> connectivityDataList = findAllUsername();
        List<VRDeviceConnectivityModel> connectivityModelList = new ArrayList<>();

        for (Object[] connectivityData : connectivityDataList) {
            Long id = (Long) connectivityData[0];
            String macAddress = (String) connectivityData[1];
            Instant initDate = (Instant) connectivityData[2];
            String username = (String) connectivityData[3];
            String note = (String) connectivityData[4];
            String connected = (String) connectivityData[5];
            String argoment = (String) connectivityData[6];

            VRDeviceConnectivityModel connectivityModel = new VRDeviceConnectivityModel(id, macAddress, initDate, username, note, connected, argoment);
            connectivityModelList.add(connectivityModel);
        }

        return connectivityModelList;
    }

    @Query(value = "SELECT argoment FROM connect c WHERE c.macAddress =:mac")
    String argomentByMacAddress(@Param("mac") String mac);

    @Transactional
    @Modifying
    @Query(value = "UPDATE connect c set c.initDate=:initDate,c.username = :username, c.note = :note, c.connected = :connected WHERE  c.macAddress = :macAddress  ")
    void updateByMacAddress(@Param("initDate") Instant initDate, @Param("username") String username, @Param("note") String note, @Param("macAddress") String macAddress, @Param("connected") String connected);

    @Transactional
    @Modifying
    @Query(value = "UPDATE connect c set c.initDate=:initDate,c.username = :username, c.note = :note, c.connected = :connected, c.argoment = :arg WHERE  c.macAddress = :macAddress  ")
    void updateByMacAddress2(@Param("initDate") Instant initDate, @Param("username") String username, @Param("note") String note, @Param("macAddress") String macAddress, @Param("connected") String connected, @Param("arg") String arg);

    @Transactional
    @Modifying
    @Query(value = "UPDATE connect c set c.initDate=:initDate, c.argoment = :argoment WHERE c.macAddress = :macAddress  ")
    void updateArgomentByVisore(@Param("initDate") Instant initDate, @Param("argoment") String argoment, @Param("macAddress") String macAddress);

    @Transactional
    @Modifying
    @Query(value = "DELETE FROM connect")
    void removeAll();

    @Transactional
    @Modifying
    @Query(value = "DELETE FROM connect c WHERE c.username NOT LIKE :prefix")
    int deleteByUsernameNotLike(@Param("prefix") String prefix);
}

