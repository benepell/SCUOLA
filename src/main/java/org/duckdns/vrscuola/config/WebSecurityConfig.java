/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.duckdns.vrscuola.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authorization.AuthorizationDecision;
import org.springframework.security.authorization.AuthorizationManager;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClientService;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtValidationException;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.intercept.RequestAuthorizationContext;

import java.time.Instant;
import java.util.*;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig {

    private final ApplicationContext applicationContext;
    private final String issuerUri;

    @Autowired
    public WebSecurityConfig(ApplicationContext applicationContext,
                             @Value("${spring.security.oauth2.client.provider.external.issuer-uri}") String issuerUri) {
        this.applicationContext = applicationContext;
        this.issuerUri = issuerUri;
    }
    @Bean
    public JwtDecoder jwtDecoder() {
        String jwkSetUri = issuerUri + "/protocol/openid-connect/certs";
        return NimbusJwtDecoder.withJwkSetUri(jwkSetUri).build();
    }

    private AuthorizationManager<RequestAuthorizationContext> roleAccessManager(String role) {

        OAuth2AuthorizedClientService authorizedClientService = applicationContext.getBean(OAuth2AuthorizedClientService.class);
        JwtDecoder jwtDecoder = jwtDecoder();

        return (auth, context) -> {
            Authentication authentication = auth.get();

            if (authentication instanceof OAuth2AuthenticationToken) {
                OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) authentication;
                OAuth2AuthorizedClient authorizedClient = authorizedClientService.loadAuthorizedClient(
                        oauthToken.getAuthorizedClientRegistrationId(), oauthToken.getName());

                if (authorizedClient != null) {
                    String accessToken = authorizedClient.getAccessToken().getTokenValue();
                    Instant expiryDate = authorizedClient.getAccessToken().getExpiresAt();

                    // Controlla se il token di accesso non è scaduto
                    if (expiryDate.isAfter(Instant.now())) {
                        try {
                            Jwt jwt = jwtDecoder.decode(accessToken);
                            Map<String, Object> claims = jwt.getClaims();

                            Map<String, Object> realmAccess = (Map<String, Object>) claims.get("realm_access");
                            if (realmAccess != null && realmAccess.containsKey("roles")) {
                                List<String> roles = (List<String>) realmAccess.get("roles");
                                boolean hasRoleAdmins = roles.contains(role);
                                return new AuthorizationDecision(hasRoleAdmins);
                            }
                        } catch (JwtValidationException ex) {
                            return new AuthorizationDecision(false);
                        }
                    }
                }
            }
            return new AuthorizationDecision(false);
        };
    }

    @Bean
    public SecurityFilterChain configure(HttpSecurity http) throws Exception {

        http
                // cors disable
                .cors(corsCustomizer -> corsCustomizer.disable())

                // Disabilita CSRF
                .csrf(csrfCustomizer -> {
                    csrfCustomizer.disable();
                })

                // Configurazione delle richieste autorizzate
                .authorizeHttpRequests(auth -> auth

                        .requestMatchers("/test", "/test1", "/abilita-classe", "/abilita-sezione", "/abilita-visore",
                                "/setup-visore", "/scan-visore", "/visore-selection", "/visore-remove", "/allievo-visore",
                                "/classroom", "/classe", "/sezione", "/checkRes", "/chiudi-visore", "/diagnosi",
                                "/generate-keycloak-credentials/**", "/upload/**"
                        ).access(roleAccessManager("admins"))

                        .requestMatchers("/**", "/oauth2/**", "/sso/login", "/error", "/errore", "/health", "/hello", "/config", "/update-env",
                                "/initialize-devices/**", "/connectivity-devices/**", "/keycloak-users/**", "/basesetup",
                                "/argomento-visore", "/static/**", "/favicon.ico", "/argomenti/**", "/swagger-ui/**",
                                "/api-docs/**", "/v3/api-docs", "/swagger-resources/**", "/webjars/**", "/resources/**",
                                "/questions/**", "/answers/**", "/list-questions/**", "/list-media/**", "/questions-view/**",
                                "/setup", "/setup-state", "/setup/**").permitAll()

                        .anyRequest().authenticated()
                )

                // Configurazione della gestione delle sessioni
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                )

                .oauth2Login(oauthLogin -> oauthLogin
                        .successHandler(new CustomAuthenticationSuccessHandler())
                )

                // Configurazione della gestione degli errori
                .exceptionHandling(exceptionHandling -> exceptionHandling
                        .accessDeniedHandler((request, response, accessDeniedException) -> {
                            // Se lo stato è 403, reindirizza l'utente alla pagina di logout
                            response.sendRedirect("/_logout");
                        })
                )

                // Configurazione del logout
                .logout(logout -> logout
                        .logoutSuccessUrl("/_logout")
                )

                .headers(headers -> headers
                        .frameOptions(frameOptions -> frameOptions.sameOrigin())
                );

        return http.build();
    }

}
