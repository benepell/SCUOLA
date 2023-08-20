#!/bin/bash

# Imposta l'indirizzo IP corrente
current_ip=$(cat ~/duckdns/current-ip.txt)
echo "Indirizzo IP corrente: $current_ip"

# Ottieni l'indirizzo IP attuale
new_ip=$(curl -sS https://api64.ipify.org)

# Stampa l'indirizzo IP attuale
echo "Indirizzo IP attuale: $new_ip"

# Confronta l'indirizzo IP corrente con quello nuovo
if [ "$current_ip" != "$new_ip" ]; then
    echo "L'indirizzo IP è cambiato. Eseguo l'aggiornamento..."

    # Esegui l'aggiornamento tramite cURL
    echo url="https://www.duckdns.org/update?domains=vrscuola.duckdns.org&token=dd9e98df-8c14-4e46-8554-4b4985b96cfb&ip=" | curl -k -o ~/duckdns/duck.log -K -

    # Aggiorna il file current-ip.txt con il nuovo indirizzo IP
    echo "$new_ip" > ~/duckdns/current-ip.txt
else
    echo "L'indirizzo IP non è cambiato. Nessun aggiornamento necessario."
fi