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

package org.duckdns.vrscuola.services.config;

import org.duckdns.vrscuola.entities.config.ConfigEntitie;
import org.duckdns.vrscuola.repositories.config.ConfigRepository;
import org.duckdns.vrscuola.utilities.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ConfigService {
    @Autowired
    private ConfigRepository cRepository;

    public void eventLogPdf(String value) {
        if (cRepository.existsByName(Constants.CONFIG_EVENT_LOG_PDF)) {
            cRepository.updateValue(value, Constants.CONFIG_EVENT_LOG_PDF);
        } else {
            try {
                ConfigEntitie config = new ConfigEntitie();
                config.setName(Constants.CONFIG_EVENT_LOG_PDF);
                config.setValue(value);
                config.setId(1L);
                cRepository.save(config);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
    }

    public String getEventLogPdf() {
        if (cRepository.existsByName(Constants.CONFIG_EVENT_LOG_PDF)) {
            return cRepository.findByName(Constants.CONFIG_EVENT_LOG_PDF);
        } else {
            return null;
        }
    }
}
