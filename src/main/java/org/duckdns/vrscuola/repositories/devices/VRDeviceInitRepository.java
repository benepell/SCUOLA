/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.repositories.devices;

import jakarta.transaction.Transactional;
import org.duckdns.vrscuola.entities.devices.VRDeviceInitEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;
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
    @Query(value = "SELECT i.eraOnline FROM init i WHERE i.macAddress  =:mac")
    Instant findEraOnlineByMacAddress(@Param("mac") String mac);

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
    @Query(value = "UPDATE init i set i.macAddress = :newmac, i.note = :note, i.code = :code, i.classroom = :classroom WHERE  i.macAddress = :oldmac  ")
    void updateByMacAddress(@Param("oldmac") String oldmac,@Param("newmac") String newmac,@Param("note") String note, @Param("code") String code, @Param("classroom") String classroom );

    @Transactional
    @Modifying
    @Query(value = "UPDATE init i set i.batteryLevel = :batteryLevel WHERE  i.macAddress = :mac  ")
    void updateBatteryLevel(@Param("mac") String mac,@Param("batteryLevel") int batteryLevel);

    @Transactional
    @Modifying
    @Query(value = "UPDATE init i set i.eraOnline = :eraOnline WHERE  i.macAddress = :mac  ")
    void updateEraOnline(@Param("mac") String mac,@Param("eraOnline") Instant eraOnline);
}

