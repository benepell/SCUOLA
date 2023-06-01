package online.vrscuola.models;

public class UserInfo {
    private String classe;
    private String cognome;
    private String nome;
    private String sezione;
    private String argomento;
    private String durata;

    public UserInfo() {
    }

    public UserInfo(String nome, String cognome, String classe, String sezione, String argomento, String durata) {
        this.classe = classe;
        this.cognome = cognome;
        this.nome = nome;
        this.sezione = sezione;
        this.argomento = argomento;
        this.durata = durata;
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSezione() {
        return sezione;
    }

    public void setSezione(String sezione) {
        this.sezione = sezione;
    }

    public String getArgomento() {
        return argomento;
    }

    public void setArgomento(String argomento) {
        this.argomento = argomento;
    }

    public String getDurata() {
        return durata;
    }

    public void setDurata(String durata) {
        this.durata = durata;
    }
}
