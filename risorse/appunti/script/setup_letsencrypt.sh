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


if certbot certonly --standalone --preferred-challenges http -d ${BASE_SCUOLA} --dry-run; then
   certbot certonly --standalone --preferred-challenges http -d ${BASE_SCUOLA} --register-unsafely-without-email
else
    echo "certs ${BASE_SCUOLA} failed"
    exit 1
fi

if certbot certonly --standalone --preferred-challenges http -d ${BASE_KEYCLOAK} --dry-run; then
    certbot certonly --standalone --preferred-challenges http -d ${BASE_KEYCLOAK} --register-unsafely-without-email
else
    echo "certs ${BASE_KEYCLOAK} failed"
    exit 1
fi

if certbot certonly --standalone --preferred-challenges http -d ${BASE_RISORSE} --dry-run; then
    certbot certonly --standalone --preferred-challenges http -d ${BASE_RISORSE} --register-unsafely-without-email
else
    echo "certs ${BASE_RISORSE} failed"
    exit 1
fi