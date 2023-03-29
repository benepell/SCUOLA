#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# stop tomcat9 per liberare porta 80
systemctl stop tomcat9

# vai a percorso cert
CERT_PATH=$(sudo ls -1d /etc/letsencrypt/live/"${a11_DOMAIN}"* | sort -r | head -1)
cd "${CERT_PATH}"

# Verificare se il file del certificato esiste
if [ ! -f "$a11_CERT_FILE" ]; then
  echo "File del certificato non trovato"
  exit 1
fi

# Verificare se il file della chiave privata esiste
if [ ! -f "$a11_PRIVKEY_FILE" ]; then
  echo "File della chiave privata non trovato"
  exit 1
fi

# Calcolare la data di scadenza del certificato
notAfter=$(openssl x509 -in "$a11_CERT_FILE" -noout -enddate | cut -d= -f2)
if [ -z "$notAfter" ]; then
  echo "Errore durante la lettura della data di scadenza del certificato"
  exit 1
fi

expiration=$(date -d "$notAfter" +"%s")
now=$(date +"%s")
days_left=$(( (expiration - now) / 86400 ))

# Verificare se il certificato è in scadenza (meno di 15 giorni)
if [ $days_left -lt 15 ]; then
  in_scadenza=true
else
  in_scadenza=false
fi

echo "Il certificato scade in $days_left giorni"
echo "In scadenza: $in_scadenza"

# Se il certificato non è in scadenza e non è richiesto un nuovo certificato, terminare lo script
if [ "$in_scadenza" = false ] && [ "$a11_CERT_OPTION" = "2" ]; then
  echo "Il certificato non è in scadenza e non è richiesto un nuovo certificato"
  exit 0
fi

# Esecuzione del comando certbot in modalità dry run
if certbot certonly --standalone --preferred-challenges http -d "${a11_DOMAIN}" --dry-run; then
    echo "test successful create cert."

    # GENERA CERTIFICATO
	echo "${a11_CERT_OPTION}" | certbot certonly --standalone --preferred-challenges http -d "${a11_DOMAIN}"

	# vai a percorso cert
	CERT_PATH=$(sudo ls -1d /etc/letsencrypt/live/"${a11_DOMAIN}"* | sort -r | head -1)

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
  if [ -f "${CERT_PATH}/${a11_PRIVKEY_FILE}" ]; then
      # Se il file è presente, procedi con le altre operazioni
	# Convertire il certificato e la chiave privata in un file PKCS12
	openssl pkcs12 -export -in "$a11_CERT_FILE" -inkey "$a11_PRIVKEY_FILE" -out "$a11_P12_FILE" -name "$a11_ALIAS" -passout pass:"$a11_PASSWORD_P12"

	# Importare il file PKCS12 nel keystore JKS
	keytool -importkeystore -srckeystore "$a11_P12_FILE" -srcstoretype pkcs12 -destkeystore "$a11_JKS_FILE" -deststoretype jks -alias "$a11_ALIAS" -deststorepass "$a11_PASSWORD_JKS" -srcstorepass "$a11_PASSWORD_P12" -noprompt

	# Aggiungere la catena di certificati al keystore JKS
	keytool -import -alias root -keystore "$a11_JKS_FILE" -trustcacerts -file "$a11_CERT_FILE" -storepass "$a11_PASSWORD_JKS" -noprompt

	# crea cartella certs se non esiste
	mkdir -p /etc/certs/keycloak
	
	# copia tutti i file del certificato in /etc/certs
	cp -rf -n * /etc/certs/keycloak/

	# gestione permessi permette a tutti di leggere i file
	chmod -R 644 /etc/certs/keycloak

    exit 0
  else
      # Se il file non è presente entro il tempo massimo, stampa un messaggio di errore e termina lo script
      echo "Il file ${a11_PRIVKEY_FILE} non è stato trovato in ${CERT_PATH} entro il tempo massimo di attesa di ${MAX_WAIT_TIME} secondi. Impossibile procedere."
      exit 1
  fi


else
    echo "letsencrypt ${a11_DOMAIN} failed."
    exit 1
fi