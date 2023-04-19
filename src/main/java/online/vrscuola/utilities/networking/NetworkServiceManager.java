package online.vrscuola.utilities.networking;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class NetworkServiceManager {

    @Value("${network.nmap.path}") // percorso del nmap path
    private String networkNmapPath;

    @Value("${network.ip}") // percorso del ip network
    private String networkIp;

    @Value("${network.maskbit}") // percorso del ip network
    private String networkMaskBit;

    @Value("${network.filter.oculus}") // percorso del ip network
    private String networkFilterOculus;


    public List<String> scanOculusNetwork() {
        List<String> macAddresses = new ArrayList<>();

        try {
            Process proc = Runtime.getRuntime().exec(networkNmapPath+ " -PR -sn "+networkIp+"/"+networkMaskBit);

            BufferedReader stdInput = new BufferedReader(new InputStreamReader(proc.getInputStream()));
            BufferedReader stdError = new BufferedReader(new InputStreamReader(proc.getErrorStream()));

            // read the output from the command
            String s = null;
            Pattern macPattern = Pattern.compile("([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})");

            while ((s = stdInput.readLine()) != null) {
                Matcher matcher = macPattern.matcher(s);
                if (matcher.find()) {
                    String macAddress = matcher.group();
                    if (macAddress.toLowerCase().startsWith(networkFilterOculus)) {
                        macAddresses.add(macAddress);
                    }
                }
            }

            // read any errors from the attempted command
            while ((s = stdError.readLine()) != null) {
                System.err.println(s);
            }
        } catch (IOException ex) {
            System.err.println(ex);
        }

        return macAddresses;
    }

}