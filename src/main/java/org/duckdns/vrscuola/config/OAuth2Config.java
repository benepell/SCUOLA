package org.duckdns.vrscuola.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;

@Configuration
public class OAuth2Config {


    @Value("${basename}")
    private String baseName;

    @Value("${spring.security.oauth2.client.provider.external.issuer-uri}")
    private String issuerUri;

    @Value("${spring.security.oauth2.client.registration.external.provider}")
    private String provider;

    @Value("${spring.security.oauth2.client.registration.external.client-name}")
    private String clientName;

    @Value("${spring.security.oauth2.client.registration.external.client-id}")
    private String clientId;

    @Value("${spring.security.oauth2.client.registration.external.client-secret}")
    private String clientSecret;

    @Value("${spring.security.oauth2.client.registration.external.scope}")
    private String scope;

    @Value("${spring.security.oauth2.client.registration.external.authorization-grant-type}")
    private String authorizationGrantType;

    @Bean
    public InMemoryClientRegistrationRepository clientRegistrationRepository() {
        try {
            // Converte la stringa authorizationGrantType nella costante AuthorizationGrantType
            AuthorizationGrantType grantType = new AuthorizationGrantType(authorizationGrantType);

            ClientRegistration registration = ClientRegistration
                    .withRegistrationId(provider)
                    .clientId(clientId)
                    .clientSecret(clientSecret)
                    .clientName(clientName)
                    .redirectUri(baseName + "/login/oauth2/code/" + provider)
                    .authorizationGrantType(grantType)
                    .scope(scope)
                    .authorizationUri(issuerUri + "/protocol/openid-connect/auth")
                    .tokenUri(issuerUri + "/protocol/openid-connect/token")
                    .userInfoUri(issuerUri + "/protocol/openid-connect/userinfo")
                    .userNameAttributeName("preferred_username") // Sostituisci con il nome corretto dell'attributo "user name" restituito dal server
                    .jwkSetUri(issuerUri + "/protocol/openid-connect/certs")
                    .build();

            return new InMemoryClientRegistrationRepository(registration);
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            return null;
        }
    }
}
