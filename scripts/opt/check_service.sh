#!/bin/bash

# Definisci il formato del timestamp
timestamp=$(date +"[%Y-%m-%d %T]")
baseurl=https://scuola.vrscuola.online/api/health

# Definisci il nome del file di log
logfile="/opt/script/log/$(date +'%Y_%m_%d')_service.log"

# Crea la cartella di log se non esiste
if [[ ! -d /opt/script/log/ ]]; then
  mkdir -p /opt/script/log/
fi


# Controlla se l'applicazione è presente nella directory /var/lib/tomcat9/webapps/api/
if [[ ! -e /var/lib/tomcat9/webapps/api/ ]]; then
  echo "$timestamp [error] L'applicazione non è presente nella directory /var/lib/tomcat9/webapps/api/. Eseguo il comando per riavviare il servizio Tomcat9 e attendo 3 minuti prima di riavviare lo script." >> /var/log/myapp.log
  exit 1
fi

# Recupera i dati dall'endpoint
response=$(curl -s "$baseurl")

# Analizza i dati con jq
status_database=$(echo "$response" | jq -r '.database.status')
status_website=$(echo "$response" | jq -r '.website.status')
status_websiteRisorse=$(echo "$response" | jq -r '.websiteRisorse.status')
status_resourceDirectory=$(echo "$response" | jq -r '.resourceDirectory.status')
status_websiteKeycloak=$(echo "$response" | jq -r '.websiteKeycloak.status')
status_operatingSystem=$(echo "$response" | jq -r '.operatingSystem.status')

# Controlla se la risposta dall'endpoint è null
if [[ -z "$response" ]]; then
  echo "$timestamp [error] La risposta dall'endpoint è null. Eseguo il comando per riavviare il servizio Tomcat9 e attendo 3 minuti prima di riavviare lo script." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  systemctl restart tomcat9
  sleep 180
  exec "$0"
fi

if [[ "$status_website" != "ok" ]]; then
  echo "$timestamp [error] Il servizio website è in stato di errore. Eseguo il comando per riavviare il servizio Tomcat9." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  systemctl restart tomcat9
fi

if [[ "$status_database" != "ok" ]]; then
  echo "$timestamp [error] Il servizio database è in stato di errore. Eseguo il comando per riavviare il servizio mysql." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  systemctl restart mysql
fi

if [[ "$status_websiteRisorse" == "error" ]]; then
  echo "$timestamp [error] Il servizio websiteRisorse è in stato di errore. Eseguo il comando per riavviare il servizio apache2." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  systemctl restart apache2
fi

if [[ "$status_resourceDirectory" != "ok" ]]; then
  echo "$timestamp [error] Il servizio resourceDirectory è in stato di errore. Eseguo il comando di ripristino." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  # Inserisci qui il comando per ripristinare il servizio
fi

if [[ "$status_websiteKeycloak" != "ok" ]]; then
   echo "$timestamp [error] Il servizio websiteKeycloak è in stato di errore. Eseguo il comando per riavviare il servizio Tomcat9." >> /var/log/myapp.log
   echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
   killall -9 java
   systemctl restart tomcat9
   cd /opt/keycloak-21.0.0/bin/
./start.sh &
fi

echo "$timestamp [info] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"