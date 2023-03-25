#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# Cerca e sostituisci i valori nel file keycloak.conf
sed -i "s/^db-username=.*/db-username=$a5_DB_USERNAME/" "$a5_KEYCLOAK_BASE"/conf/keycloak.conf
sed -i "s/^db-password=.*/db-password=$a5_DB_PASSWORD/" "$a5_KEYCLOAK_BASE"/conf/keycloak.conf
sed -i "s|^db-url=.*|db-url=$a5_DB_URL|" "$a5_KEYCLOAK_BASE"/conf/keycloak.conf
sed -i "s|^hostname=.*|hostname=$a5_HOSTNAME|" "$a5_KEYCLOAK_BASE"/conf/keycloak.conf