/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.repositories.devices;

import jakarta.transaction.Transactional;
import org.duckdns.vrscuola.entities.devices.VRDeviceDetailConnectivityEntitie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.List;

@Repository
public interface VRDeviceDetailConnectivityRepository extends JpaRepository<VRDeviceDetailConnectivityEntitie, Long> {

    @Query(value = "SELECT COUNT(*) FROM detailconnect d ")
    Long countRecord();

    @Query(value = "SELECT CASE WHEN COUNT(*) > 0 THEN true ELSE false END FROM detailconnect d WHERE d.username = :username")
    Boolean usernameExist(@Param("username") String username);

    @Query(value = "SELECT d.minutes FROM detailconnect d WHERE d.username = :username")
    Long findMinutes(@Param("username") String username);

    @Query(value = "SELECT d.startDate, d.endDate, d.minutes FROM detailconnect d WHERE d.username = :username")
    List<Object[]> findValues(@Param("username") String username);

    @Query(value = "SELECT d.startDate FROM detailconnect d WHERE d.username = :username")
    Instant findStartDate(@Param("username") String username);

    @Transactional
    default void insertStartDate(String username) {
        if (username == null) return;
        VRDeviceDetailConnectivityEntitie entity = new VRDeviceDetailConnectivityEntitie();
        entity.setUsername(username);
        entity.setStartDate(Instant.now());
        save(entity);
    }

    @Transactional
    @Modifying
    @Query(value = "UPDATE detailconnect d SET d.startDate = :timestamp WHERE d.username = :username")
    void updateStartDate(@Param("timestamp") Instant timestamp, @Param("username") String username);

    @Transactional
    @Modifying
    @Query(value = "UPDATE detailconnect d SET d.endDate = :timestamp WHERE d.username = :username")
    void updateEndDate(@Param("timestamp") Instant timestamp, @Param("username") String username);

    @Transactional
    @Modifying
    @Query(value = "UPDATE detailconnect d SET d.minutes = :minutes WHERE d.username = :username")
    void updateMinutes(@Param("minutes") Long minutes, @Param("username") String username);

    @Transactional
    @Modifying
    @Query(value = "UPDATE detail_connect SET minutes = 0, start_date = '1970-01-01 00:00:00', end_date = '1970-01-01 00:00:00' WHERE username = :username", nativeQuery = true)
    void resetDate(@Param("username") String username);

    @Transactional
    @Modifying
    @Query(value = "UPDATE detail_connect SET minutes = 0, start_date = '1970-01-01 00:00:00', end_date = '1970-01-01 00:00:00' WHERE username = :username", nativeQuery = true)
    void resetAll(@Param("username") String username);

}
