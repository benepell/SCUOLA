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

package org.duckdns.vrscuola.utilities;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.regex.Pattern;

@SuppressWarnings("unused")
@Component
public class Utilities {
    @SuppressWarnings("unused")
    public Instant getEpoch() {
        return Instant.now();
    }

    public String strTime(){
        return new SimpleDateFormat(Constants.UNIQUE_TIME_FORMAT).format(new Date());
    }

    public boolean isValidMacAddr(String mac){
        Pattern pattern = Pattern.compile("^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$");
        return pattern.matcher(mac).matches();
    }
    public boolean isExpired(Instant timestamp, long minutes) {
        long differenceInMinutes = ChronoUnit.MINUTES.between(timestamp, Instant.now());
        return  timestamp != null && differenceInMinutes < Constants.MIN_ONLINE_ERA;
    }

    public String generateBatterySVG(int batteryLevel, String width){
        StringBuilder svg = new StringBuilder();
        svg.append("<svg version=\"1.1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" x=\"0px\" y=\"0px\" viewBox=\"0 0 1000 1000\" enable-background=\"new 0 0 1000 1000\" xml:space=\"preserve\" width=\""+width+"\">\n");
        svg.append("<metadata> Svg Vector Icons : http://www.onlinewebfonts.com/icon </metadata>\n");
        svg.append("<g><g transform=\"translate(0.000000,511.000000) scale(0.100000,-0.100000)\">\n");
        svg.append("<path d=\"M597.6,2149.6c-171.4-52.5-353.8-215.6-431.3-384.3l-66.3-141V120.5c0-1072.6,8.3-1534.3,33.2-1611.7c41.5-138.2,215.6-337.2,364.9-417.4l113.3-60.8h3884.1h3884.1l110.6,60.8c268.2,143.8,425.7,403.6,428.5,702.2v182.4l312.4,13.8c212.9,8.3,337.3,27.6,395.3,58c107.8,55.3,223.9,190.8,254.3,290.3c11.1,41.5,19.4,398.1,19.4,793.4c0,804.5-2.8,823.8-199,973.1c-96.8,74.6-118.9,77.4-436.8,85.7l-340,11.1l-11.1,223.9c-13.8,273.7-74.6,406.4-259.8,569.5c-237.8,210.1,33.2,196.3-4168.8,193.5C1346.8,2188.3,699.9,2180,597.6,2149.6z M8329.8,1627.1c74.6-66.3,77.4-74.6,91.2-411.9c13.8-317.9,19.4-353.9,80.2-417.4c63.6-69.1,77.4-71.9,483.8-77.4l417.4-8.3l8.3-613.7l5.5-616.5h-411.9c-398.1,0-417.4-2.8-492.1-66.3c-77.4-66.4-77.4-71.9-85.7-414.7c-11.1-348.3-11.1-348.3-94-417.5l-82.9-69.1H4495.5H738.6l-77.4,66.4l-77.4,66.3V103.9v1456.9l77.4,66.3l77.4,66.3h3756.9h3756.9L8329.8,1627.1z\"/>\n");
        svg.append("<path d=\"M818.8,103.9v-1340.8h3676.7h3676.7V103.9v1340.8H4495.5H818.8V103.9z M7945.5,98.3l-8.3-1100.3H4509.3H1081.4l-8.3,1100.3l-5.5,1097.5h3441.7h3441.7L7945.5,98.3z\"/>\n");
        boolean charging = false;
        if(batteryLevel < 0 && batteryLevel > -100){
            charging = true;
        }
        int batteryLevelRounded =  (int) Math.round(Math.abs(batteryLevel) / 10.0);

        String strCharging = "<animate attributeName=\"fill\" values=\"#FF6601; #00FF00\" dur=\"6.5s\" repeatCount=\"indefinite\"/>\n";
        String strChargingPath = charging ? strCharging.concat("</path>\n") : "</path>\n";


        switch (batteryLevelRounded){
            case 10:
                svg.append("<path d=\"M7204.7,90.1v-857h248.8h248.8v857v857h-248.8h-248.8V90.1z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
            case 9:
                svg.append("<path d=\"M6463.8,98.3l8.3-851.5l243.3-8.3l240.5-8.3V90.1v857h-248.8h-248.8L6463.8,98.3z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
            case 8:
                svg.append("<path d=\"M5739.5,90.1v-859.8l243.3,8.3l240.5,8.3l8.3,851.5l5.5,848.7h-248.8h-248.8V90.1z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
            case 7:
                svg.append("<path d=\"M4993.1,90.1v-857h248.8h248.8v857v857h-248.8h-248.8V90.1z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
            case 6:
                svg.append("<path d=\"M4252.2,98.3l8.3-851.5l243.3-8.3l240.5-8.3V90.1v857h-248.8h-248.8L4252.2,98.3z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
            case 5:
                svg.append("<path d=\"M3527.9,90.1v-859.8l243.3,8.3l240.5,8.3l8.3,851.5l5.5,848.7h-248.8h-248.8V90.1z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
            case 4:
                svg.append("<path d=\"M2781.5,90.1v-857h248.8h248.8v857v857h-248.8h-248.8V90.1z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
            case 3:
                svg.append("<path d=\"M2062.8,90.1v-857h235h235v857v857h-235h-235V90.1z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
            case 2:
            case 1:
                svg.append("<path d=\"M1316.4,90.1v-859.8l243.3,8.3l240.5,8.3l8.3,851.5L1814,947h-248.8h-248.8V90.1z\" style=\"fill:#00FF00\">\n");
                svg.append(strChargingPath);
        }

        svg.append("</g></g>\n");
        svg.append("</svg>");

        return svg.toString();
    }


}
