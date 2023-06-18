package it.vrscuola.scuola.models;

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
