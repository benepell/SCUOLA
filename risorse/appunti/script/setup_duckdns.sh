#!/bin/bash

# Carica le variabili d'ambiente dal file global_env.sh
source ./global_env.sh

# Prepara il contenuto dello script update_duckdns.sh con i valori attuali
cat <<EOF >update-duckdns.sh
#!/bin/bash
# Imposta l'indirizzo IP corrente
current_ip=\$(cat ~/duckdns/current-ip.txt)
echo "Indirizzo IP corrente: \$current_ip"

# Ottieni l'indirizzo IP attuale
new_ip=\$(curl -sS https://api64.ipify.org)

# Stampa l'indirizzo IP attuale
echo "Indirizzo IP attuale: \$new_ip"

# Confronta l'indirizzo IP corrente con quello nuovo
if [ "\$current_ip" != "\$new_ip" ]; then
    echo "L'indirizzo IP è cambiato. Eseguo l'aggiornamento..."

    # Esegui l'aggiornamento tramite cURL per BASE_SCUOLA
    echo url="https://www.duckdns.org/update?domains=${BASE_SCUOLA}&token=${TOKEN_DUCKDNS}&ip=" | curl -k -o ~/duckdns/duck.log -K -

    # Esegui l'aggiornamento tramite cURL per BASE_KEYCLOAK
    echo url="https://www.duckdns.org/update?domains=${BASE_KEYCLOAK}&token=${TOKEN_DUCKDNS}&ip=" | curl -k -o ~/duckdns/duck.log -K -

    # Esegui l'aggiornamento tramite cURL per BASE_RISORSE
    echo url="https://www.duckdns.org/update?domains=${BASE_RISORSE}&token=${TOKEN_DUCKDNS}&ip=" | curl -k -o ~/duckdns/duck.log -K -

    # Aggiorna il file current-ip.txt con il nuovo indirizzo IP
    echo "\$new_ip" > ~/duckdns/current-ip.txt
fi
EOF

# Rende lo script eseguibile
chmod +x update-duckdns.sh

echo "Lo script update-duckdns.sh è stato aggiornato."