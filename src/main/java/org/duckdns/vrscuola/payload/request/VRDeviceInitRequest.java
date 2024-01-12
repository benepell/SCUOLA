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

package org.duckdns.vrscuola.payload.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;



@Data
public class VRDeviceInitRequest {
    private static final Logger Log = LogManager.getLogger(VRDeviceInitRequest.class.getName());

    @Size(max = 17)
    private String macAddress;

    @Size(max = 5)
    private String label;

    @Size(max = 50)
    private String code;

    @NotBlank
    @Size(max = 17)
    private String oldMacAddress;

    @Size(max = 255)
    private String note;

}
