package it.vrscuola.scuola.payload.response;

public class KeycloakCredentialResponse {
    private String password;
    private String username;

    public KeycloakCredentialResponse(String password, String username) {
        this.password = password;
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public String getUsername() {
        return username;
    }
}
