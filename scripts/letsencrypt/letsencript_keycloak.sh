#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# stop tomcat9 per liberare porta 80
systemctl stop tomcat9

# Esecuzione del comando certbot in modalità dry run
if certbot certonly --standalone --preferred-challenges http -d "${a9_DOMAIN}" --dry-run; then
    echo "test successful create cert."

    # GENERA CERTIFICATO
	echo "${a9_CERT_OPTION}" | certbot certonly --standalone --preferred-challenges http -d "${a9_DOMAIN}"

	# vai a percorso cert
	CERT_PATH=$(sudo find /etc/letsencrypt/live/ -name "${a9_DOMAIN}*")
	cd "${CERT_PATH}"

	# rimuovi precedenti files
	rm -f *.p12
	rm -f *.jks

	# Imposta il tempo massimo di attesa in secondi (10 minuti = 600 secondi)
  MAX_WAIT_TIME=600
  WAIT_TIME=0

  # Esegui il ciclo while finché il file non è presente e non è stato raggiunto il tempo massimo di attesa
  while [ ! -f "${CERT_PATH}/${a9_PRIVKEY_FILE}" ] && [ ${WAIT_TIME} -lt ${MAX_WAIT_TIME} ]; do
      # Stampa un messaggio di attesa
      echo "Il file ${a9_PRIVKEY_FILE} non è presente in ${CERT_PATH}. Attendo 5 secondi..."

      # Attendi 5 secondi
      sleep 5

      # Aggiorna il tempo di attesa trascorso
      WAIT_TIME=$((WAIT_TIME + 5))
  done

  # Verifica se il file è presente
  if [ -f "${CERT_PATH}/${a9_PRIVKEY_FILE}" ]; then
      # Se il file è presente, procedi con le altre operazioni
      # Convertire il certificato e la chiave privata in un file PKCS12
	openssl pkcs12 -export -in "$a9_CERT_FILE" -inkey "$a9_PRIVKEY_FILE" -out "$a9_P12_FILE" -name "$a9_ALIAS" -passout pass:"$a9_PASSWORD_P12"

	# Importare il file PKCS12 nel keystore JKS
	keytool -importkeystore -srckeystore "$a9_P12_FILE" -srcstoretype pkcs12 -destkeystore "$a9_JKS_FILE" -deststoretype jks -alias "$a9_ALIAS" -deststorepass "$a9_PASSWORD_JKS" -srcstorepass "$a9_PASSWORD_P12" -noprompt

	# Aggiungere la catena di certificati al keystore JKS
	keytool -import -alias root -keystore "$a9_JKS_FILE" -trustcacerts -file "$a9_CERT_FILE" -storepass "$a9_PASSWORD_JKS" -noprompt

	# crea cartella certs se non esiste
	mkdir -p /etc/certs/keycloak
	
	# copia tutti i file del certificato in /etc/certs
	cp cert.pem /etc/certs/keycloak/
  cp chain.pem /etc/certs/keycloak/
  cp fullchain.pem /etc/certs/keycloak/
  cp privkey.pem /etc/certs/keycloak/
  cp vrscuola.jks /etc/certs/keycloak/
  cp vrscuola.p12 /etc/certs/keycloak/

	# gestione permessi permette a tutti di leggere i file
	chmod -R 644 /etc/certs/keycloak

    exit 0  
else
      # Se il file non è presente entro il tempo massimo, stampa un messaggio di errore e termina lo script
      echo "Il file ${a10_PRIVKEY_FILE} non è stato trovato in ${CERT_PATH} entro il tempo massimo di attesa di ${MAX_WAIT_TIME} secondi. Impossibile procedere."
      exit 1
  fi

else
    echo "letsencrypt ${a9_DOMAIN} failed."
    exit 1
fi