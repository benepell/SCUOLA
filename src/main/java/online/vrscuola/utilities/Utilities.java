package online.vrscuola.utilities;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.Instant;
import java.util.Date;

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


}
