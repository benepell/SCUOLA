/**
 * Copyright (c) 2023, Benedetto Pellerito
 * Email: benedettopellerito@gmail.com
 * GitHub: https://github.com/benepell
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package it.vrscuola.scuola.config;

import org.keycloak.adapters.springsecurity.KeycloakConfiguration;
import org.keycloak.adapters.springsecurity.authentication.KeycloakAuthenticationProvider;
import org.keycloak.adapters.springsecurity.config.KeycloakWebSecurityConfigurerAdapter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.authority.mapping.SimpleAuthorityMapper;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.web.authentication.session.RegisterSessionAuthenticationStrategy;
import org.springframework.security.web.authentication.session.SessionAuthenticationStrategy;

@KeycloakConfiguration
public class WebSecurityConfig extends KeycloakWebSecurityConfigurerAdapter {

    @Bean
    @Override
    protected SessionAuthenticationStrategy sessionAuthenticationStrategy() {
        return new RegisterSessionAuthenticationStrategy(new SessionRegistryImpl());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        super.configure(http);
        http.cors().and().csrf().disable()
                .authorizeRequests()

                .antMatchers("/login", "/logout", "/userinfo").authenticated()

                .antMatchers("/sso/login", "/error", "/errore", "/health", "/hello", "/config", "/update-env",
                        "/initialize-devices/**", "/connectivity-devices/**", "/keycloak-users/**", "/basesetup",
                        "/argomento-visore", "/static/**", "/favicon.ico", "/argomenti/**", "/swagger-ui/**",
                        "/v3/api-docs", "/swagger-resources/**", "/webjars/**").permitAll()

                .antMatchers("/test", "/test1", "/abilita-classe", "/abilita-sezione", "/abilita-visore",
                        "/setup-visore", "/scan-visore", "/visore-selection", "/visore-remove", "/allievo-visore",
                        "/classroom", "/classe", "/sezione", "/checkRes", "/chiudi-visore", "/diagnosi",
                        "/generate-keycloak-credentials/**", "/setup", "/setup-state", "/setup/**", "/upload/**",
                        "/resources/**").hasRole("admins")

                .anyRequest().denyAll();

        http.headers().frameOptions().sameOrigin();
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        KeycloakAuthenticationProvider keycloakAuthenticationProvider = keycloakAuthenticationProvider();
        keycloakAuthenticationProvider.setGrantedAuthoritiesMapper(new SimpleAuthorityMapper());
        auth.authenticationProvider(keycloakAuthenticationProvider);
    }
}
