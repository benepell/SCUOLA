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

package org.duckdns.vrscuola.models;

import lombok.Data;

import java.time.Instant;

@Data
public class VRDeviceConnectivityModel {
    private Long id;
    private String macAddress;
    private Instant initDate;
    private String username;
    private String note;
    private String connected;
    private String argoment;

    // add constructor
    public VRDeviceConnectivityModel(Long id, String macAddress, Instant initDate, String username, String note, String connected, String argoment) {
        this.id = id;
        this.macAddress = macAddress;
        this.initDate = initDate;
        this.username = username;
        this.note = note;
        this.connected = connected;
        this.argoment = argoment;
    }
}
