package it.vrscuola.scuola.models;

import lombok.Data;

import java.time.Instant;

@Data
public class DetailConnectInfoModel {
    private String username;
    private Instant startDate;
    private Instant endDate;
    private Long minutes;

    // getter e setter

    public DetailConnectInfoModel(Instant startDate, Instant endDate, Long minutes) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.minutes = minutes;
    }
}
