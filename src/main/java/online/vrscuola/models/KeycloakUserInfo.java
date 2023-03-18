package online.vrscuola.models;

public class KeycloakUserInfo {
    private String classe;
    private String cognome;
    private String nome;
    private String sezione;
    private String username;

    public KeycloakUserInfo() {
    }

    public KeycloakUserInfo(String classe, String cognome, String nome, String sezione, String username) {
        this.classe = classe;
        this.cognome = cognome;
        this.nome = nome;
        this.sezione = sezione;
        this.username = username;
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

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
