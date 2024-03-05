#!/bin/bash

# Definisce il percorso del file di servizio Tomcat da modificare
TOMCAT_SERVICE_FILE="/etc/systemd/system/multi-user.target.wants/tomcat10.service"

# Carica le variabili d'ambiente dal file global_env.sh
source global_env.sh

# Sostituisce i valori nel file di servizio di Tomcat usando espressioni regolari per catturare qualsiasi valore attuale
sed -i "s|Environment=\"VRSCUOLA_BASE_URL=.*\"|Environment=\"VRSCUOLA_BASE_URL=$BASE_SCUOLA\"|g" $TOMCAT_SERVICE_FILE
sed -i "s|Environment=\"VRSCUOLA_KEYCLOAK_URL=.*\"|Environment=\"VRSCUOLA_KEYCLOAK_URL=$BASE_KEYCLOAK\"|g" $TOMCAT_SERVICE_FILE
sed -i "s|Environment=\"VRSCUOLA_RESOURCES_URL=.*\"|Environment=\"VRSCUOLA_RESOURCES_URL=$BASE_RISORSE\"|g" $TOMCAT_SERVICE_FILE

# Ricarica i daemon di systemd per applicare le modifiche
systemctl daemon-reload

echo "Modifiche al file di servizio Tomcat completate."
