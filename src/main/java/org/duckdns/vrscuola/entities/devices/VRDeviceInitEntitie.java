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

package org.duckdns.vrscuola.entities.devices;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
import java.time.Instant;
import java.util.List;

@Entity(name = "init")
@Data
public class VRDeviceInitEntitie implements Serializable {

    private static final long serialVersionUID = 1649157305664836876L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(unique = true) // Impedisce l'inserimento di valori duplicati
    private String macAddress;

    private String label;
    private Instant initDate;
    private String note;
    private String code;

    @Column(columnDefinition = "INTEGER DEFAULT 100")
    private Integer batteryLevel;

    private String classroom;

    private Instant eraOnline;

   /* @OneToMany(mappedBy = "init", fetch = FetchType.LAZY)
    private List<VRDeviceConnectivityEntitie> connectivities;
*/
}
