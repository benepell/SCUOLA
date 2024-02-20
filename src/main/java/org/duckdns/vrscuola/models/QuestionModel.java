package org.duckdns.vrscuola.models;

import java.util.List;

public class QuestionModel {
    private String id;
    private String domanda;
    private String media;

    private List<RispostaModel> risposte; // Modificato per utilizzare RispostaModel
    private List<RispostaModel> corrette; // Modificato per utilizzare RispostaModel

    public QuestionModel(String id, String domanda, String media ,List<RispostaModel> risposte, List<RispostaModel> corrette) {
        this.id = id;
        this.domanda = domanda;
        this.media = media;
        this.risposte = risposte;
        this.corrette = corrette;
    }

    // Getter e setter modificati per utilizzare RispostaModel
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDomanda() {
        return domanda;
    }

    public void setDomanda(String domanda) {
        this.domanda = domanda;
    }

    public List<RispostaModel> getRisposte() {
        return risposte;
    }

    public void setRisposte(List<RispostaModel> risposte) {
        this.risposte = risposte;
    }

    public List<RispostaModel> getCorrette() {
        return corrette;
    }

    public void setCorrette(List<RispostaModel> corrette) {
        this.corrette = corrette;
    }

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }
}