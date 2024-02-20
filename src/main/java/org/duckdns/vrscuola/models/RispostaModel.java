package org.duckdns.vrscuola.models;

public class RispostaModel {
    private String id;
    private String testo;
    private String media;

    public RispostaModel(String id, String testo, String media) {
        this.id = id;
        this.testo = testo;
        this.media = media;
    }

    // Getter e setter
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTesto() {
        return testo;
    }

    public void setTesto(String testo) {
        this.testo = testo;
    }

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

}