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

package org.duckdns.vrscuola.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.util.Locale;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "org.duckdns.vrscuola")

public class WebApplicationContextConfig  implements WebMvcConfigurer
{

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer)
    {
        configurer.enable();
    }


    @Bean
    public InternalResourceViewResolver getInternalResourceViewResolver()
    {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(JstlView.class);

        resolver.setPrefix("/WEB-INF/view/");
        resolver.setSuffix(".jsp");

        return resolver;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }

    @Bean
    public MessageSource messageSource()
    {
        ResourceBundleMessageSource resource = new ResourceBundleMessageSource();
        resource.setBasename("messages");

        return resource;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry)
    {
        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        localeChangeInterceptor.setParamName("language");

        registry.addInterceptor(localeChangeInterceptor);
    }

    @Bean
    public LocaleResolver localeResolver()
    {
        /*
         * SessionLocaleResolver resolver = new SessionLocaleResolver();
         * resolver.setDefaultLocale(new Locale("it")); return resolver;
         */

        CookieLocaleResolver r = new CookieLocaleResolver();
        r.setCookieName("localeInfo");
        r.setCookieMaxAge(24 * 60 * 60);
        r.setDefaultLocale(new Locale("it"));

        return r;

    }

}