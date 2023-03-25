#!/bin/bash

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
	CERT_PATH=$a10_(sudo find /etc/letsencrypt/live/ -name "${a10_DOMAIN}*")
	cd "${a10_CERT_PATH}"

	# rimuovi precedenti files
	rm -f *.p12
	rm -f *.jks

	# Convertire il certificato e la chiave privata in un file PKCS12
	openssl pkcs12 -export -in "$a10_CERT_FILE" -inkey "$a10_PRIVKEY_FILE" -out "$a10_P12_FILE" -name "$a10_ALIAS" -passout pass:"$a10_PASSWORD_P12"

	# Importare il file PKCS12 nel keystore JKS
	keytool -importkeystore -srckeystore "$a10_P12_FILE" -srcstoretype pkcs12 -destkeystore "$a10_JKS_FILE" -deststoretype jks -alias "$a10_ALIAS" -deststorepass "$a10_PASSWORD_JKS" -srcstorepass "$a10_PASSWORD_P12" -noprompt

	# Aggiungere la catena di certificati al keystore JKS
	keytool -import -alias root -keystore "$a10_JKS_FILE" -trustcacerts -file "$a10_CERT_FILE" -storepass "$a10_PASSWORD_JKS" -noprompt
	
	# crea cartella certs se non esiste
	mkdir -p /etc/certs/scuola
	
	# copia tutti i file del certificato in /etc/certs
	cp -rf -n * /etc/certs/scuola/

	# gestione permessi permette a tutti di leggere i file
	chmod -R 644 /etc/certs/scuola

    exit 0
else
    echo "letsencrypt ${a10_DOMAIN} failed."
    exit 1
fi