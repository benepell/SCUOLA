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

package it.vrscuola.scuola.services.devices;

import it.vrscuola.scuola.utilities.Utilities;

public interface VRDeviceInitService {
    void addInit(Utilities utilities, String macAddress,  String note, String paramCode, String classroom);

    void updateInit(Utilities utilities, String macAddress, String oldMacAddress, String note, String paramCode);

    boolean valid(String macAddress, String code);

    String label(String macAddress);

    void updateBatteryLevel(String macAddress, int batteryLevel);

}
