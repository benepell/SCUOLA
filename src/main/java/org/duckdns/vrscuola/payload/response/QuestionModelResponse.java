package org.duckdns.vrscuola.payload.response;

import org.duckdns.vrscuola.models.RispostaModel;

import java.util.List;

public class QuestionModelResponse {
    private String id;
    private String domanda;
    private String media;
    private List<RispostaModel> risposte; // Modificato per utilizzare RispostaModel

    public QuestionModelResponse(String id, String domanda, String media, List<RispostaModel> risposte) {
        this.id = id;
        this.domanda = domanda;
        this.media = media;
        this.risposte = risposte;
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

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

}