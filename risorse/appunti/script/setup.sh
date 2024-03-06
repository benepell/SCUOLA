#!/bin/bash

set -e

SETUP_FILE=/var/www/html/risorse/files/CONFIGURAZIONI/global_env.sh
MV_PATH=/opt/script/
# Verifica se il file è presente
if [ -f "${SETUP_FILE}" ] && [ $(find "${SETUP_FILE}" -mmin -5 | wc -l) -gt 0 ]; then
    mv ${SETUP_FILE} ${MV_PATH}

    # Configura client duckdns update
    ./setup_duckdns.sh

    # crea domini certs
    ./setup_letsencrypt.sh

    # copia modello nginx 
    cp -fn ./default /etc/nginx/sites-available/

    # applica trasformazione in nginx
    ./setup_replace_nginx.sh

    #avvia nginx
    systemctl restart nginx

    # applica trasformazione tomcat
    ./setup_replace_tomcat.sh

    #avvia tomcat10
    systemctl restart tomcat10

    # applica trasformazione tomcat
    ./setup_replace_apache.sh

    #avvia tomcat10
    systemctl restart apache2

    echo "Installazione Completata";

fi