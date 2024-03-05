#!/bin/bash

# Carica le variabili d'ambiente dal file global_env.sh
source global_env.sh

# Rimuove "https://" dalle variabili, se presente
BASE_SCUOLA=$(echo $BASE_SCUOLA | sed 's|https://||')
BASE_KEYCLOAK=$(echo $BASE_KEYCLOAK | sed 's|https://||')
BASE_RISORSE=$(echo $BASE_RISORSE | sed 's|https://||')

# Rimuove "http://" dalle variabili, se presente
BASE_SCUOLA=$(echo $BASE_SCUOLA | sed 's|http://||')
BASE_KEYCLOAK=$(echo $BASE_KEYCLOAK | sed 's|http://||')
BASE_RISORSE=$(echo $BASE_RISORSE | sed 's|http://||')

# Percorso del file di configurazione Nginx da modificare
NGINX_CONFIG="/etc/nginx/sites-available/default"

# Backup del file di configurazione Nginx originale
cp $NGINX_CONFIG "${NGINX_CONFIG}.bak"

# Sostituisce i placeholders con i valori delle variabili
sed -i "s|{{vrscuola}}|$BASE_SCUOLA|g" $NGINX_CONFIG
sed -i "s|{{vrscuola-auth}}|$BASE_KEYCLOAK|g" $NGINX_CONFIG
sed -i "s|{{vrscuola-res}}|$BASE_RISORSE|g" $NGINX_CONFIG

echo "Sostituzione completata."
