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

package org.duckdns.vrscuola.services.devices;

import org.duckdns.vrscuola.repositories.devices.VRDeviceDetailConnectivityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;

@Service
public class VRDeviceManageDetailService {

    @Autowired
    VRDeviceDetailConnectivityRepository dRepository;

    public boolean startTime(String username) {
        // controlla se username  e' presente
        if (username == null) {
            return false;
        }

        boolean updating = false;

        // controlla se il visore e' gia' associato
        if (dRepository.usernameExist(username)) {
            updating = true;
        }
        // reinit dei valori start e end date
      //  dRepository.resetDate(username);

        if (updating) {
            dRepository.updateStartDate(Instant.now(),username);
        } else {
            dRepository.insertStartDate(username);
        }

        return true;
    }

    public boolean endTime(String username) {
        // controlla se username  e' presente
        if (username == null) {
            return false;
        }
        // record deve esistere solo update
        dRepository.updateEndDate(Instant.now(),username);

        // aggiunge i minuti al record
        addMinutes(username);
        return true;
    }

    public Long getMinutes(String username) {
        return username != null ? dRepository.findMinutes(username) : null;
    }

    public Long recordExist() {
        return dRepository.countRecord();
    }

    public void resetDate(String username) {
        // controlla se username  e' presente
        if (username == null) {
            return;
        }
        // record deve esistere solo update
        dRepository.resetDate(username);
    }

    public void resetAll(String username) {
        // controlla se username  e' presente
        if (username == null) {
            return;
        }
        // record deve esistere solo update
        dRepository.resetAll(username);
    }


    private void addMinutes(String username) {

        List<Object[]> results = dRepository.findValues(username);

        for (Object[] result : results) {
            Instant startDate = (Instant) result[0];
            Instant endDate = (Instant) result[1];
            Long minutes = (Long) result[2];
            Long seconds = endDate.getEpochSecond() - startDate.getEpochSecond();
            minutes += seconds > 0 ? (seconds / 60 ): 0;
            dRepository.updateMinutes(minutes, username);
        }

    }

}
