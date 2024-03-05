#!/bin/bash

set -e

SETUP_FILE=/var/www/html/risorse/files/CONFIGURAZIONI/global_env.sh
MV_PATH=/opt/script/
# Verifica se il file è presente
if [ -f "${SETUP_FILE}" ]; then
    mv ${SETUP_FILE} ${MV_PATH}

    # crea domini certs
    ./setup_letsencrypt.sh

    # copia modello nginx 
    cp -fn ./default /etc/nginx/sites-available/

    # applica trasformazione in nginx
    ./setup_replace_nginx.sh

    #avvia nginx
    systemctl start nginx
    systemctl enable nginx

    # applica trasformazione tomcat
    ./setup_replace_tomcat.sh

    #avvia tomcat10
    systemctl start tomcat10
    systemctl enable tomcat10

    # applica trasformazione tomcat
    ./setup_replace_apache.sh

    #avvia tomcat10
    systemctl start apache2
    systemctl enable apache2

    echo "Installazione Completata";

fi