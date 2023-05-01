package online.vrscuola.component;

import online.vrscuola.models.DetailConnectInfoModel;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.Map;

@Component
public class DetailConnectInfoModelConverter implements Converter<Map<String, Object>, DetailConnectInfoModel> {

    @Override
    public DetailConnectInfoModel convert(Map<String, Object> source) {
        Instant startDate = (Instant) source.get("startDate");
        Instant endDate = (Instant) source.get("endDate");
        Long minutes = (Long) source.get("minutes");

        return new DetailConnectInfoModel(startDate, endDate, minutes);
    }
}