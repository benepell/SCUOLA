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

package org.duckdns.vrscuola.services.devices;

import org.duckdns.vrscuola.utilities.Utilities;

import java.util.List;

public interface VRDeviceInitService {
    void addInit(Utilities utilities, String macAddress, String note, String paramCode, String classroom, String label);

    void updateInit(Utilities utilities, String macAddress, String oldMacAddress, String note, String paramCode, String classroom);

    boolean valid(String macAddress, String code);

    List<Boolean> isOnline(String macAddress);

    List<String> strOnline(List<String> labels, String classroom);


    String label(String macAddress);

    void updateBatteryLevel(String macAddress, String batteryLevel);

    void updateOnline(String macAddress,String batteryLevel);

}
