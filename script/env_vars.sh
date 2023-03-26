#!/bin/bash

# -- START GLOBAL Variabili d'ambiente per cartella di lavoro apache --
#BASE
BASE_SCUOLA="https://scuola.vrscuola.online"
BASE_KEYCLOAK="https://keycloak.vrscuola.online:9443"
BASE_WORDPRESS="https://scuola.vrscuola.online:8443"

# CERTS
CERT_SCUOLA="/etc/certs/scuola"
CERT_KEYCLOAK="/etc/certs/keycloak"
DOMAIN_SCUOLA="scuola.vrscuola.online"
DOMAIN_KEYCLOAK="keycloak.vrscuola.online"
CERT_PASSWORD="vrscuola!!!" #usa per semplificare stessa password
CERT_ALIAS_SCUOLA="vrscuola"
CERT_ALIAS_KEYCLOAK="keycloak"

# DATABASES
DB_SCUOLA_NAME="vrscuoladb"
DB_SCUOLA_USERNAME="vrscuola"
DB_SCUOLA_PASSWORD="vrscuola!!!!"

DB_SCUOLA_BRIDGE_USERNAME="keycloakread"
DB_SCUOLA_BRIDGE_PASSWORD="vrscuolaread!!"

DB_KEYCLOAK_NAME="keycloakdb"
DB_KEYCLOAK_USERNAME="keycloak"
DB_KEYCLOAK_PASSWORD="vrscuola!!!"

DB_WORDPRESS_NAME="wpdb"
DB_WORDPRESS_USERNAME="wp"
DB_WORDPRESS_PASSWORD="vrscuola!!!"

# KEYCLOAK
KEYCLOAK_DIR="/opt/keycloak-21.0.0"
KEYCLOAK_ADMIN_USERNAME="admin"
KEYCLOAK_ADMIN_PASSWORD="vrscuola!!!"
KEYCLOAK_CLIENT_ID="scuolaelementare" #indicare il nome della scuola per il client

# -- END Variabili d'ambiente per cartella di lavoro apache --

# -- START Variabili d'ambiente per cartella di lavoro apache --

# Definire i parametri [apache.update_default_apache2_conf.sh] ID: 1
a1_CERTS_DIR="$CERT_SCUOLA"
a1_SSL_CERT_FILE="$CERT_SCUOLA/fullchain.pem"
a1_SSL_CERT_PK="$CERT_SCUOLA/privkey.pem"
a1_SSL_CERT_CHAIN="$CERT_SCUOLA/chain.pem"

# -- END Variabili d'ambiente per cartella di lavoro keycloak --

# -- START Variabili d'ambiente per cartella di lavoro database --

# Parametri di inizializzazione [database.keycloak.sh] ID: 2
a2_USER="root"
a2_PASSWORD="vrscuola!!!"
a2_PASSWORD_POLICY="LOW"
a2_DB_NAME="$DB_KEYCLOAK_NAME"
a2_DB_USER="$DB_KEYCLOAK_USERNAME"
a2_DB_PASSWORD="$DB_KEYCLOAK_PASSWORD"
a2_DB_USER_READ_ONLY="$DB_SCUOLA_BRIDGE_USERNAME"
a2_DB_PASSWORD_READ_ONLY="$DB_SCUOLA_BRIDGE_PASSWORD"
#2_SQL_SCUOLA="scuola-elementare" todo al momento non usato

# Parametri di inizializzazione [database.vrscuoladb.sh] ID: 3
a3_USER="root"
a3_PASSWORD="vrscuola!!!"
a3_PASSWORD_POLICY="LOW"
a3_DB_NAME="$DB_SCUOLA_NAME"
a3_DB_USER="$DB_SCUOLA_USERNAME"
a3_DB_PASSWORD="$DB_SCUOLA_PASSWORD"

# Parametri di inizializzazione [database.wpdb.sh] ID: 4
a4_USER="root"
a4_PASSWORD="vrscuola!!!"
a4_DB_NAME="$DB_WORDPRESS_NAME"
a4_DB_USER="$DB_WORDPRESS_USERNAME"
a4_DB_PASSWORD="$DB_WORDPRESS_PASSWORD"
a4_URL="$BASE_WORDPRESS"

# -- START Variabili d'ambiente per cartella di lavoro database --

# -- START Variabili d'ambiente per cartella di lavoro keycloak --


# Imposta i nuovi valori delle variabili [keycloak.update_conf.sh] ID: 5
a5_KEYCLOAK_BASE="$KEYCLOAK_DIR"
a5_DB_USERNAME="$DB_KEYCLOAK_USERNAME"
a5_DB_PASSWORD="$DB_KEYCLOAK_PASSWORD"
a5_DB_URL="jdbc:mysql://localhost:3306/$DB_KEYCLOAK_NAME"
a5_HOSTNAME="$DOMAIN_KEYCLOAK"

# Imposta i valori delle variabili [keycloak.init_start.sh] ID: 6
a6_KEYCLOAK_BASE="$KEYCLOAK_DIR"
a6_KEYCLOAK_ADMIN="$KEYCLOAK_ADMIN_USERNAME"
a6_KEYCLOAK_ADMIN_PASSWORD="$KEYCLOAK_ADMIN_PASSWORD"
a6_HTTPS_PORT=9443
a6_HTTPS_KEY_STORE_FILE="/etc/certs/keycloak/keystore.jks"
a6_HTTPS_KEY_STORE_PASSWORD="$CERT_PASSWORD"

# Definire i parametri [keycloak.generate_client_id.sh] ID: 7
a7_KEYCLOAK_URL="$BASE_KEYCLOAK/auth"
a7_REALM_NAME="scuola"
a7_CLIENT_ID="scuola-secondaria-primo-grado"
a7_NEW_CLIENT_ID="$KEYCLOAK_CLIENT_ID"
a7_ADMIN_USERNAME="$KEYCLOAK_ADMIN_USERNAME"
a7_ADMIN_PASSWORD="$KEYCLOAK_ADMIN_PASSWORD"

# Definire i parametri [keycloak.generate_secret_id.sh] ID: 8
a8_KEYCLOAK_URL="$BASE_KEYCLOAK/auth"
a8_REALM_NAME="scuola"
a8_CLIENT_ID="scuola-secondaria-primo-grado" # inserire il client ID del nuovo client
a8_ADMIN_USERNAME="$KEYCLOAK_ADMIN_USERNAME"
a8_ADMIN_PASSWORD="$KEYCLOAK_ADMIN_PASSWORD"

# -- END Variabili d'ambiente per cartella di lavoro keycloak --

# -- START Variabili d'ambiente per cartella di lavoro letsencrypt --

# Parametri di inizializzazione [letsencrypt.letsencrypt_keycloak.sh] ID: 9
a9_DOMAIN="$DOMAIN_KEYCLOAK"
a9_CERT_OPTION="1" #valori 1 nuovo cert 2 aggiornamento
a9_CERT_FILE="fullchain.pem"  # nome del file di certificato
a9_PRIVKEY_FILE="privkey.pem"  # nome del file di chiave privata
a9_P12_FILE="keystore.p12"  # nome del file P12 in cui esportare il certificato e la chiave privata
a9_JKS_FILE="keystore.jks"  # nome del keystore JKS in cui importare il certificato
a9_PASSWORD_P12="$CERT_PASSWORD"  # Password utilizzata per proteggere il file P12
a9_PASSWORD_JKS="$CERT_PASSWORD"  # Password utilizzata per proteggere il keystore JKS
a9_ALIAS="$CERT_ALIAS_SCUOLA"  # Nome dell'alias utilizzato per il certificato nel file P12 e nel keystore JKS

# Parametri di inizializzazione [letsencrypt.letsencrypt.sh] ID: 10
a10_DOMAIN="$DOMAIN_SCUOLA"
a10_CERT_OPTION="1" #valori 1 nuovo cert 2 aggiornamento
a10_CERT_FILE="fullchain.pem"  # nome del file di certificato
a10_PRIVKEY_FILE="privkey.pem"  # nome del file di chiave privata
a10_P12_FILE="vrscuola.p12"  # nome del file P12 in cui esportare il certificato e la chiave privata
a10_JKS_FILE="vrscuola.jks"  # nome del keystore JKS in cui importare il certificato
a10_PASSWORD_P12="$CERT_PASSWORD"  # Password utilizzata per proteggere il file P12
a10_PASSWORD_JKS="$CERT_PASSWORD"  # Password utilizzata per proteggere il keystore JKS
a10_ALIAS="$CERT_ALIAS_SCUOLA"  # Nome dell'alias utilizzato per il certificato nel file P12 e nel keystore JKS

# Parametri di inizializzazione [letsencrypt.update_letsencrypt_keycloak.sh] ID: 11
a11_DOMAIN="$DOMAIN_KEYCLOAK"
a11_CERT_OPTION="2" #valori 1 nuovo cert 2 aggiornamento
a11_CERT_FILE="fullchain.pem"  # nme del file di certificato
a11_PRIVKEY_FILE="privkey.pem"  # nome del file di chiave privata
a11_P12_FILE="keystore.p12"  # nome del file P12 in cui esportare il certificato e la chiave privata
a11_JKS_FILE="keystore.jks"  # nome del keystore JKS in cui importare il certificato
a11_PASSWORD_P12="$CERT_PASSWORD"  # Password utilizzata per proteggere il file P12
a11_PASSWORD_JKS="$CERT_PASSWORD"  # Password utilizzata per proteggere il keystore JKS
a11_ALIAS="$CERT_ALIAS_KEYCLOAK"  # Nome dell'alias utilizzato per il certificato nel file P12 e nel keystore JKS

# Parametri di inizializzazione [letsencrypt.update_letsencrypt.sh] ID: 12
a12_DOMAIN="$DOMAIN_SCUOLA"
a12_CERT_OPTION="2" #valori 1 nuovo cert 2 aggiornamento
a12_CERT_FILE="fullchain.pem"  # nome del file di certificato
a12_PRIVKEY_FILE="privkey.pem"  # nome del file di chiave privata
a12_P12_FILE="vrscuola.p12"  # nome del file P12 in cui esportare il certificato e la chiave privata
a12_JKS_FILE="vrscuola.jks"  # nome del keystore JKS in cui importare il certificato
a12_PASSWORD_P12="$CERT_PASSWORD"  # Password utilizzata per proteggere il file P12
a12_PASSWORD_JKS="$CERT_PASSWORD"  # Password utilizzata per proteggere il keystore JKS
a12_ALIAS="$CERT_ALIAS_SCUOLA"  # Nome dell'alias utilizzato per il certificato nel file P12 e nel keystore JKS

# -- END Variabili d'ambiente per cartella di lavoro letsencrypt --


# -- START Variabili d'ambiente per cartella di lavoro spring --

# Definire i parametri  [spring.bridge.update_war_bridge.sh] ID: 13
a13_WAR_FILE="bridge.war"
a13_TOMCAT_WEBAPPS_DIR="/var/lib/tomcat9/webapps"
a13_APP_NAME="bridge"
a13_KEYCLOAK_RESOURCE="$KEYCLOAK_CLIENT_ID"
a13_KEYCLOAK_CREDENTIALS_SECRET="MizAkO7AcNiDEgsGwXIsCHWdhAlNMc2A"
a13_DB_URL="jdbc:mysql://localhost:3306/$DB_NAME_SCUOLA"
a13_DB_USERNAME="$DB_SCUOLA_BRIDGE_USERNAME"
a13_DB_PASSWORD="$DB_SCUOLA_BRIDGE_PASSWORD"
a13_DB_DRIVER_CLASS="com.mysql.cj.jdbc.Driver"
a13_THYMELEAF_PREFIX="classpath:/templates/"
a13_THYMELEAF_SUFFIX=".html"

# Definire i parametri [spring.bridge.update_war_scuola.sh] ID: 14
a14_WAR_FILE="api.war"
a14_TOMCAT_WEBAPPS_DIR="/var/lib/tomcat9/webapps"
a14_APP_NAME="api"
a14_KEYCLOAK_REALM="scuola"
a14_KEYCLOAK_AUTH_SERVER_URL="$BASE_KEYCLOAK/auth"
a14_KEYCLOAK_RESOURCE="scuola-secondaria-primo-grado"
a14_KEYCLOAK_CREDENTIALS_SECRET="MizAkO7AcNiDEgsGwXIsCHWdhAlNMc2A"
a14_KEYCLOAK_USE_RESOURCE_ROLE_MAPPINGS="false"
a14_SCHOOL_BRIDGE_URL="$BASE_SCUOLA"
a14_DB_URL="jdbc:mysql://localhost:3306/$DB_KEYCLOAK_NAME?serverTimezone=UTC"
a14_DB_USERNAME="$DB_KEYCLOAK_USERNAME"
a14_DB_PASSWORD="$DB_KEYCLOAK_PASSWORD"
a14_JPA_LOB_NON_CONTEXTUAL_CREATION="true"
a14_JPA_HIBERNATE_DIALECT="org.hibernate.dialect.MySQL8Dialect"
a14_JPA_HIBERNATE_DDL_AUTO="update"
a14_SPRING_SHOW_SQL="true"
a14_SPRING_FORMAT_SQL="true"
a14_LOG_LEVEL_SQL="DEBUG"
a14_LOG_LEVEL_SQL_BINDER="TRACE"
a14_LOG_LEVEL_JDBC_TEMPLATE="DEBUG"
a14_LOG_LEVEL_STATEMENT_CREATOR_UTILS="TRACE"
a14_THYMELEAF_PREFIX="classpath:/templates/"
a14_THYMELEAF_SUFFIX=".html"
a14_SCHOOL_RESOURCE="/var/lib/tomcat9/resources"
a14_OPENVPN_PATH="/usr/sbin/openvpn"
a14_OPENVPN_SCHOOL_CONFIG="/var/lib/tomcat9/vpn/vrscuola.opvn"
a14_SERVER_SERVLET_REGISTER_DEFAULT_SERVLET="true"
a14_SERVER_SERVLET_DEFAULT_SERVLET_NAME="default"

# -- END Variabili d'ambiente per cartella di lavoro spring --

# -- START Variabili d'ambiente per cartella di lavoro tomcat --

# Definire i parametri [tomcat.update_server_conf.sh] ID: 15
a15_JKS_FILE="vrscuola.jks"  # nome del keystore JKS in cui importare il certificato
a15_PASSWORD_JKS="$CERT_PASSWORD"  # Password utilizzata per proteggere il keystore JKS
a15_KEYSTORE_DIR="$CERT_SCUOLA"
a15_KEYSTORE_FILE="$KEYSTORE_DIR/$JKS_FILE"
a15_KEYSTORE_PASSWORD="$PASSWORD_JKS"
# -- END Variabili d'ambiente per cartella di lavoro tomcat --
