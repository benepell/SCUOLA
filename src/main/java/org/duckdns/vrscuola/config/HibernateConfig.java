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

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.orm.jpa.EntityManagerFactoryBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@Configuration
@EnableTransactionManagement
public class HibernateConfig {

    @Autowired
    Environment env;

    @Bean
    @Primary
    public LocalContainerEntityManagerFactoryBean entityManagerFactory(EntityManagerFactoryBuilder builder) {
        return builder
                .dataSource(dataSource())
                .packages("org.duckdns.vrscuola.entities")
                .persistenceUnit("default")
                .properties(getHibernateProperties())
                .build();
    }

    @Bean(name = "secondEntityManagerFactory")
    public LocalContainerEntityManagerFactoryBean secondEntityManagerFactory(EntityManagerFactoryBuilder builder) {
        return builder
                .dataSource(secondDataSource())
                .packages("org.duckdns.vrscuola.second.entities")
                .persistenceUnit("second")
                .properties(getSecondHibernateProperties())
                .build();
    }

    @Bean
    @Primary
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(env.getProperty("spring.datasource.driver-class-name"));
        dataSource.setUrl(env.getProperty("spring.datasource.url"));
        dataSource.setUsername(env.getProperty("spring.datasource.username"));
        dataSource.setPassword(env.getProperty("spring.datasource.password"));

        return dataSource;
    }

    @Bean(name = "secondDataSource")
    public DataSource secondDataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(env.getProperty("second.datasource.driver-class-name"));
        dataSource.setUrl(env.getProperty("second.datasource.url"));
        dataSource.setUsername(env.getProperty("second.datasource.username"));
        dataSource.setPassword(env.getProperty("second.datasource.password"));

        // Set connection in read-only mode
        Connection connection = null;
        try {
            connection = dataSource.getConnection();
            connection.setReadOnly(true);
            connection.setAutoCommit(false);
            connection.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return dataSource;
    }

    @Bean
    @Primary
    public PlatformTransactionManager transactionManager(EntityManagerFactory entityManagerFactory) {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(entityManagerFactory);

        return transactionManager;
    }

    @Bean(name = "secondTransactionManager")
    public PlatformTransactionManager secondTransactionManager(EntityManagerFactory secondEntityManagerFactory) {
        JpaTransactionManager transactionManager = new JpaTransactionManager();
        transactionManager.setEntityManagerFactory(secondEntityManagerFactory);

        return transactionManager;
    }

    private Map<String, ?> getHibernateProperties() {
        Map<String, String> properties = new HashMap<>();
        properties.put("hibernate.dialect", env.getProperty("hibernate.dialect"));
        properties.put("hibernate.show_sql", env.getProperty("hibernate.show_sql"));
        properties.put("hibernate.format_sql", env.getProperty("hibernate.format_sql"));
        properties.put("hibernate.hbm2ddl.auto", env.getProperty("hibernate.hbm2ddl.auto"));

        return properties;
    }

    private Map<String, ?> getSecondHibernateProperties() {
        Map<String, String> properties = new HashMap<>();
        properties.put("hibernate.dialect", env.getProperty("second.hibernate.dialect"));
        properties.put("hibernate.show_sql", env.getProperty("second.hibernate.show_sql"));
        properties.put("hibernate.format_sql", env.getProperty("second.hibernate.format_sql"));
        properties.put("hibernate.hbm2ddl.auto", "none");
        properties.put("hibernate.connection.read_only", "true");


        return properties;
    }
}
