#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../../env_vars.sh

# Verificare se il file .war esiste
if [ ! -f "$a14_WAR_DIR/$a14_WAR_FILE" ]; then
  echo "File .war non trovato"
  exit 1
fi

# Copiare il file .war nella directory webapps di Tomcat
cp "$a14_WAR_DIR/$a14_WAR_FILE" "$a14_TOMCAT_WEBAPPS_DIR/"


#restart tomcat
sudo systemctl restart tomcat9

# attendo 30 secondi
sleep 30

# Trovare il file application.properties
PROPERTIES_FILE="$a14_TOMCAT_WEBAPPS_DIR/$a14_APP_NAME/WEB-INF/classes/application.properties"

# Verificare se il file application.properties esiste
if [ ! -f "$a14_PROPERTIES_FILE" ]; then
  echo "File application.properties non trovato"
  exit 1
fi

# Modificare i parametri nel file application.properties
sed -i "s/^keycloak.realm=.*/keycloak.realm=$a14_KEYCLOAK_REALM/" "$a14_PROPERTIES_FILE"
sed -i "s|^keycloak.auth-server-url=.*|keycloak.auth-server-url=$a14_KEYCLOAK_AUTH_SERVER_URL|" "$a14_PROPERTIES_FILE"
sed -i "s/^keycloak.resource=.*/keycloak.resource=$a14_KEYCLOAK_RESOURCE/" "$a14_PROPERTIES_FILE"
sed -i "s/^keycloak.credentials.secret=.*/keycloak.credentials.secret=$a14_KEYCLOAK_CREDENTIALS_SECRET/" "$a14_PROPERTIES_FILE"
sed -i "s/^keycloak.use-resource-role-mappings=.*/keycloak.use-resource-role-mappings=$a14_KEYCLOAK_USE_RESOURCE_ROLE_MAPPINGS/" "$a14_PROPERTIES_FILE"
sed -i "s|^school.bridge.url=.*|school.bridge.url=$a14_SCHOOL_BRIDGE_URL|" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.datasource.url=.*/spring.datasource.url=$a14_DB_URL/" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.datasource.username=./spring.datasource.username=$a14_DB_USERNAME/" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.datasource.password=./spring.datasource.password=$a14_DB_PASSWORD/" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.datasource.driver-class-name=./spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver/" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=./spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=$a14_JPA_LOB_NON_CONTEXTUAL_CREATION/" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.jpa.properties.hibernate.dialect=./spring.jpa.properties.hibernate.dialect=$a14_JPA_HIBERNATE_DIALECT/" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.jpa.hibernate.ddl-auto=./spring.jpa.hibernate.ddl-auto=$a14_JPA_HIBERNATE_DDL_AUTO/" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.jpa.show-sql=./spring.jpa.show-sql=$a14_SPRING_SHOW_SQL/" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.jpa.properties.hibernate.format_sql=./spring.jpa.properties.hibernate.format_sql=$a14_SPRING_FORMAT_SQL/" "$a14_PROPERTIES_FILE"
sed -i "s/^logging.level.org.hibernate.SQL=./logging.level.org.hibernate.SQL=$a14_LOG_LEVEL_SQL/" "$a14_PROPERTIES_FILE"
sed -i "s/^logging.level.org.hibernate.type.descriptor.sql.BasicBinder=./logging.level.org.hibernate.type.descriptor.sql.BasicBinder=$a14_LOG_LEVEL_SQL_BINDER/" "$a14_PROPERTIES_FILE"
sed -i "s/^logging.level.org.springframework.jdbc.core.JdbcTemplate=./logging.level.org.springframework.jdbc.core.JdbcTemplate=$a14_LOG_LEVEL_JDBC_TEMPLATE/" "$a14_PROPERTIES_FILE"
sed -i "s/^logging.level.org.springframework.jdbc.core.StatementCreatorUtils=./logging.level.org.springframework.jdbc.core.StatementCreatorUtils=$a14_LOG_LEVEL_STATEMENT_CREATOR_UTILS/" "$a14_PROPERTIES_FILE"
sed -i "s|^spring.thymeleaf.prefix=.|spring.thymeleaf.prefix=$a14_THYMELEAF_PREFIX|" "$a14_PROPERTIES_FILE"
sed -i "s/^spring.thymeleaf.suffix=./spring.thymeleaf.suffix=$a14_THYMELEAF_SUFFIX/" "$a14_PROPERTIES_FILE"
sed -i "s|^school.resource=.|school.resource=$a14_SCHOOL_RESOURCE|" "$a14_PROPERTIES_FILE"
sed -i "s/^openvpn.path=./openvpn.path=$a14_OPENVPN_PATH/" "$a14_PROPERTIES_FILE"
sed -i "s|^openvpn.school.config=.|openvpn.school.config=$a14_OPENVPN_SCHOOL_CONFIG|" "$a14_PROPERTIES_FILE"
sed -i "s/^server.servlet.register-default-servlet=./server.servlet.register-default-servlet=$a14_SERVER_SERVLET_REGISTER_DEFAULT_SERVLET/" "$a14_PROPERTIES_FILE"
sed -i "s/^server.servlet.default-servlet-name=.*/server.servlet.default-servlet-name=$a14_SERVER_SERVLET_DEFAULT_SERVLET_NAME/" "$a14_PROPERTIES_FILE"