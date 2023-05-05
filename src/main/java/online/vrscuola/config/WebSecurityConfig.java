package online.vrscuola.config;

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
        return new RegisterSessionAuthenticationStrategy(
                new SessionRegistryImpl());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        super.configure(http);
        http.cors().and().csrf().disable()
                .authorizeRequests()
                .antMatchers("/login").authenticated()
                .antMatchers("/userinfo").authenticated()
                .antMatchers("/health").permitAll()
                .antMatchers("/hello").permitAll()
                .antMatchers("/config").permitAll()
                .antMatchers("/update-env").permitAll()
                .antMatchers("/test").hasRole("admins")
                .antMatchers("/test1").hasRole("users")

                .antMatchers("/abilita-classe").hasRole("admins")
                .antMatchers("/abilita-sezione").hasRole("admins")
                .antMatchers("/abilita-visore").hasRole("admins")

                .antMatchers("/setup-visore").hasRole("admins")
                .antMatchers("/scan-visore").hasRole("admins")
                .antMatchers("/sezione").hasRole("admins")

                .antMatchers("/vpnconnect").hasRole("admins")
                .antMatchers("/vpndisconnect").hasRole("admins")
                .antMatchers("/initialize-devices/**").permitAll()
                .antMatchers("/connectivity-devices/**").permitAll()
                .antMatchers("/generate-keycloak-credentials/**").hasRole("admins")
                .antMatchers("/keycloak-users/**").permitAll()
                .antMatchers("/setup").hasRole("admins")
                .antMatchers("/setup-state").hasRole("admins")
                .antMatchers("/setup/**").hasRole("admins")
                .antMatchers("/basesetup").permitAll()
                .antMatchers("/upload/**").hasRole( "admins")
                .antMatchers("/resources/**").hasRole("admins")
                .anyRequest().permitAll();

    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        KeycloakAuthenticationProvider keycloakAuthenticationProvider = keycloakAuthenticationProvider();
        keycloakAuthenticationProvider.setGrantedAuthoritiesMapper(new SimpleAuthorityMapper());
        auth.authenticationProvider(keycloakAuthenticationProvider);
    }

}