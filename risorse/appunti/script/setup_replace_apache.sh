#!/bin/bash

# Definisce il percorso del file di configurazione di Apache come variabile
APACHE_CONFIG_FILE="/etc/apache2/sites-available/000-default.conf"

# Carica le variabili d'ambiente dal file global_env.sh
source global_env.sh


# Sostituisce i valori nel file di configurazione di Apache usando espressioni regolari per catturare qualsiasi valore
sed -i "s|SetEnv VRSCUOLA_KEYCLOAK_URL \".*\"|SetEnv VRSCUOLA_KEYCLOAK_URL \"$BASE_KEYCLOAK\"|g" $APACHE_CONFIG_FILE
sed -i "s|SetEnv VRSCUOLA_RESOURCES_URL \".*\"|SetEnv VRSCUOLA_RESOURCES_URL \"$BASE_RISORSE\"|g" $APACHE_CONFIG_FILE

echo "Modifiche completate."
