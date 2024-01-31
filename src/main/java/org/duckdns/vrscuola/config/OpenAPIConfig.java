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

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Contact;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.servers.Server;

@Configuration
public class OpenAPIConfig {

    @Value("${basename}")
    private String basename;

    @Bean
    public OpenAPI myOpenAPI() {
        Server server = new Server();
        server.setUrl(basename);
        server.setDescription("VrScuola Server URL");

        Contact contact = new Contact();
        contact.setEmail("benedettopellerito@gmail.com");
        contact.setName("Benedetto Pellerito");
        contact.setUrl(basename);

        License apacheLicense = new License().name("Apache 2.0 License").url("https://www.apache.org/licenses/LICENSE-2.0");

        Info info = new Info()
                .title("VrScuola Management API")
                .version("1.0")
                .contact(contact)
                .description("This API exposes endpoints to manage vrscuola.").termsOfService("https://www.apache.org/licenses/LICENSE-2.0")
                .license(apacheLicense);

        return new OpenAPI().info(info).servers(List.of(server));
    }
}