package org.duckdns.vrscuola.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.registration.InMemoryClientRegistrationRepository;
import org.springframework.security.oauth2.core.AuthorizationGrantType;

@Configuration
public class OAuth2Config {


    private final String baseName;
    private final String issuerUri;
    private final String provider;
    private final String clientName;
    private final String clientId;
    private final String clientSecret;
    private final String scope;
    private final String authorizationGrantType;

    @Autowired
    public OAuth2Config(@Value("${basename}") String baseName,
                        @Value("${spring.security.oauth2.client.provider.external.issuer-uri}") String issuerUri,
                        @Value("${spring.security.oauth2.client.registration.external.provider}") String provider,
                        @Value("${spring.security.oauth2.client.registration.external.client-name}") String clientName,
                        @Value("${spring.security.oauth2.client.registration.external.client-id}") String clientId,
                        @Value("${spring.security.oauth2.client.registration.external.client-secret}") String clientSecret,
                        @Value("${spring.security.oauth2.client.registration.external.scope}") String scope,
                        @Value("${spring.security.oauth2.client.registration.external.authorization-grant-type}") String authorizationGrantType) {
        this.baseName = baseName;
        this.issuerUri = issuerUri;
        this.provider = provider;
        this.clientName = clientName;
        this.clientId = clientId;
        this.clientSecret = clientSecret;
        this.scope = scope;
        this.authorizationGrantType = authorizationGrantType;
    }

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
