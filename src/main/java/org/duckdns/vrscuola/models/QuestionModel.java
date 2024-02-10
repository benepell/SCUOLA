package org.duckdns.vrscuola.models;

import java.util.List;

public class QuestionModel {
    private String domanda;
    private List<String> risposte;
    private List<String> corrette;

    public QuestionModel(String domanda, List<String> risposte, List<String> corrette) {
        this.domanda = domanda;
        this.risposte = risposte;
        this.corrette = corrette;
    }

    // Getters e setters
    public String getDomanda() {
        return domanda;
    }

    public void setDomanda(String domanda) {
        this.domanda = domanda;
    }

    public List<String> getRisposte() {
        return risposte;
    }

    public void setRisposte(List<String> risposte) {
        this.risposte = risposte;
    }

    public List<String> getCorrette() {
        return corrette;
    }

    public void setCorrette(List<String> corrette) {
        this.corrette = corrette;
    }
}