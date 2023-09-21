#!/bin/bash

# Copyright (c) 2023, Benedetto Pellerito
# Email: benedettopellerito@gmail.com
# GitHub: https://github.com/benepell
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Definisci il formato del timestamp
timestamp=$(date +"[%Y-%m-%d %T]")
baseurl=https://scuola.vrscuola.it/health

# Definisci il nome del file di log
logfile="/opt/script/log/$(date +'%Y_%m_%d')_service.log"

# Crea la cartella di log se non esiste
if [[ ! -d /opt/script/log/ ]]; then
  mkdir -p /opt/script/log/
fi

# Ottieni l'ora corrente in formato 24 ore
hour=$(date +%H)

# Verifica se l'ora corrente è compresa tra le 1:00 e le 05:59 (ora di backup)
if [[ $hour -eq 1 || $hour -eq 2 || $hour -eq 3 || $hour -eq 4 || $hour -eq 5 ]]; then
  echo "$timestamp [info] L'ora corrente è compresa tra le 1:00 e le 05:59. Durante le ore di backup non si procede con il ripristino automatico " >> "$logfile"
  exit 0
fi

# Controlla se l'applicazione è presente nella directory /var/lib/tomcat9/webapps/ROOT/
if [[ ! -e /var/lib/tomcat9/webapps/ROOT/ ]]; then
  echo "$timestamp [error] L'applicazione non è presente nella directory /var/lib/tomcat9/webapps/api/. Eseguo il comando per riavviare il servizio Tomcat9 e attendo 3 minuti prima di riavviare lo script." >> "$logfile"
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


# Imposta il tempo massimo di attesa in secondi (10 minuti = 600 secondi)
MAX_WAIT_TIME=600
WAIT_TIME=0

# Esegui il ciclo while finché tomcat9 non è avviato e non è stato raggiunto il tempo massimo di attesa
while ! pgrep -f tomcat9 > /dev/null && [ ${WAIT_TIME} -lt ${MAX_WAIT_TIME} ]; do
    # Controlla se la risposta dall'endpoint è null
    if [ -z "$response" ]; then
      echo "$timestamp [error] La risposta dall'endpoint è null. Eseguo il comando per riavviare il servizio Tomcat9 e attendo 3 minuti prima di riavviare lo script." >> "$logfile"
      echo "$timestamp [error] La risposta dall'endpoint è null. Eseguo il comando per riavviare il servizio Tomcat9." >> "$logfile"
      systemctl restart tomcat9
      exec "$0"
    fi

    # Attendi 15 secondi
    sleep 15
    # Aggiorna il tempo di attesa trascorso
    WAIT_TIME=$((WAIT_TIME + 15))
done

if [ "$status_website" != "ok" ]; then
  echo "$timestamp [error] Il servizio website è in stato di errore. Eseguo il comando per riavviare il servizio Tomcat9." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  systemctl restart tomcat9
fi

if [ "$status_database" != "ok" ]; then
  echo "$timestamp [error] Il servizio database è in stato di errore. Eseguo il comando per riavviare il servizio mysql." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  systemctl restart mysql
fi

if [ "$status_websiteRisorse" != "ok" ]; then
  echo "$timestamp [error] Il servizio websiteRisorse è in stato di errore. Eseguo il comando per riavviare il servizio apache2." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  systemctl restart apache2
fi

if [ "$status_resourceDirectory" != "ok" ]; then
  echo "$timestamp [error] Il servizio resourceDirectory è in stato di errore. Eseguo il comando di ripristino." >> /var/log/myapp.log
  echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
  # Inserisci qui il comando per ripristinare il servizio
fi

if [ "$status_websiteKeycloak" != "ok" ]; then
   echo "$timestamp [error] Il servizio websiteKeycloak è in stato di errore. Eseguo il comando per riavviare il servizio Tomcat9." >> /var/log/myapp.log
   echo "$timestamp [error] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"
   killall -9 java
   systemctl restart tomcat9
   cd /opt/keycloak/bin/
   ./start.sh &
fi

echo "$timestamp [info] Stato dei servizi: website=$status_website, database=$status_database, websiteRisorse=$status_websiteRisorse, resourceDirectory=$status_resourceDirectory, websiteKeycloak=$status_websiteKeycloak, operatingSystem=$status_operatingSystem." >> "$logfile"