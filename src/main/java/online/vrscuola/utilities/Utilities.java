package online.vrscuola.utilities;
import net.minidev.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.Instant;
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


}
