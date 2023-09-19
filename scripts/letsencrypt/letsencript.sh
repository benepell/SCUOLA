#!/bin/bash

# Copyright (c) 2023, Benedetto Pellerito
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

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# stop tomcat9 per liberare porta 80
systemctl stop tomcat9

# Esecuzione del comando certbot in modalità dry run
if certbot certonly --standalone --preferred-challenges http -d "${a10_DOMAIN}" --dry-run; then
    echo "test successful create cert."

    # GENERA CERTIFICATO
	echo "${a10_CERT_OPTION}" | certbot certonly --standalone --preferred-challenges http -d "${a10_DOMAIN}"

	# vai a percorso cert
	CERT_PATH=$(sudo ls -1d /etc/letsencrypt/live/"${a10_DOMAIN}"* | sort -r | head -1)

	cd "${CERT_PATH}"

	# rimuovi precedenti files
	rm -f *.p12
	rm -f *.jks

	# Imposta il tempo massimo di attesa in secondi (10 minuti = 600 secondi)
  MAX_WAIT_TIME=600
  WAIT_TIME=0

  # Esegui il ciclo while finché il file non è presente e non è stato raggiunto il tempo massimo di attesa
  while [ ! -f "${CERT_PATH}/${a10_PRIVKEY_FILE}" ] && [ ${WAIT_TIME} -lt ${MAX_WAIT_TIME} ]; do
      # Stampa un messaggio di attesa
      echo "Il file ${a10_PRIVKEY_FILE} non è presente in ${CERT_PATH}. Attendo 5 secondi..."

      # Attendi 5 secondi
      sleep 5

      # Aggiorna il tempo di attesa trascorso
      WAIT_TIME=$((WAIT_TIME + 5))
  done

  # Verifica se il file è presente
  if [ -f "${CERT_PATH}/${a10_PRIVKEY_FILE}" ]; then
      # Se il file è presente, procedi con le altre operazioni
      # Convertire il certificato e la chiave privata in un file PKCS12
      openssl pkcs12 -export -in "$a10_CERT_FILE" -inkey "$a10_PRIVKEY_FILE" -out "$a10_P12_FILE" -name "$a10_ALIAS" -passout pass:"$a10_PASSWORD_P12"

      # Importare il file PKCS12 nel keystore JKS
      keytool -importkeystore -srckeystore "$a10_P12_FILE" -srcstoretype pkcs12 -destkeystore "$a10_JKS_FILE" -deststoretype jks -alias "$a10_ALIAS" -deststorepass "$a10_PASSWORD_JKS" -srcstorepass "$a10_PASSWORD_P12" -noprompt

      # Aggiungere la catena di certificati al keystore JKS
      keytool -import -alias root -keystore "$a10_JKS_FILE" -trustcacerts -file "$a10_CERT_FILE" -storepass "$a10_PASSWORD_JKS" -noprompt

      # crea cartella certs se non esiste
      mkdir -p /etc/certs/scuola

      # copia tutti i file del certificato in /etc/certs
      cp cert.pem /etc/certs/scuola/
      cp chain.pem /etc/certs/scuola/
      cp fullchain.pem /etc/certs/scuola/
      cp privkey.pem /etc/certs/scuola/
      cp vrscuola.jks /etc/certs/scuola/
      cp vrscuola.p12 /etc/certs/scuola/



      # gestione permessi permette a tutti di leggere i file
      chmod -R 644 /etc/certs/scuola
      exit 0
  else
      # Se il file non è presente entro il tempo massimo, stampa un messaggio di errore e termina lo script
      echo "Il file ${a10_PRIVKEY_FILE} non è stato trovato in ${CERT_PATH} entro il tempo massimo di attesa di ${MAX_WAIT_TIME} secondi. Impossibile procedere."
      exit 1
  fi

else
    echo "letsencrypt ${a10_DOMAIN} failed."
    exit 1
fi