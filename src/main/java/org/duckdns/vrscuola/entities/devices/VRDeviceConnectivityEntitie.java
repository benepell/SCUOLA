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

@SuppressWarnings("com.haulmont.jpb.LombokDataInspection")
@Entity(name = "connect")
@Data
public class VRDeviceConnectivityEntitie implements Serializable {

    private static final long serialVersionUID = -2449476168160441991L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(unique = true) // Impedisce l'inserimento di valori duplicati a macAddress
    private String macAddress;

    private Instant initDate;

    @Column(unique = true) // Impedisce l'inserimento di valori duplicati a username
    private String username;

    private String avatar;
    private String connected;
    private String argoment;

    /*
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "init_id")
    private VRDeviceInitEntitie init;
*/
    // Metodi getter e setter
}
