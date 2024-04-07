package org.duckdns.vrscuola.config;

import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {

        // Controlla se l'utente autenticato è un'istanza di OidcUser
        if (authentication.getPrincipal() instanceof OidcUser) {
            OidcUser oidcUser = (OidcUser) authentication.getPrincipal();
            String idTokenValue = oidcUser.getIdToken().getTokenValue(); // Ottenere il token ID come stringa
            String user = oidcUser.getName();

            // Salva l'idToken in sessione se disponibile
            if (idTokenValue != null) {
                HttpSession session = request.getSession();
                session.setAttribute("idToken", idTokenValue);
            }

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("main_username", user);
            }
        }

        // Reindirizza l'utente all'URL desiderato dopo il login riuscito
        redirectStrategy.sendRedirect(request, response, "/abilita-classe");
    }
}

