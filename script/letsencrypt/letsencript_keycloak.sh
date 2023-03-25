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
	CERT_PATH=$a9_(sudo find /etc/letsencrypt/live/ -name "${a9_DOMAIN}*")
	cd "${a9_CERT_PATH}"

	# rimuovi precedenti files
	rm -f *.p12
	rm -f *.jks

	# Convertire il certificato e la chiave privata in un file PKCS12
	openssl pkcs12 -export -in "$a9_CERT_FILE" -inkey "$a9_PRIVKEY_FILE" -out "$a9_P12_FILE" -name "$a9_ALIAS" -passout pass:"$a9_PASSWORD_P12"

	# Importare il file PKCS12 nel keystore JKS
	keytool -importkeystore -srckeystore "$a9_P12_FILE" -srcstoretype pkcs12 -destkeystore "$a9_JKS_FILE" -deststoretype jks -alias "$a9_ALIAS" -deststorepass "$a9_PASSWORD_JKS" -srcstorepass "$a9_PASSWORD_P12" -noprompt

	# Aggiungere la catena di certificati al keystore JKS
	keytool -import -alias root -keystore "$a9_JKS_FILE" -trustcacerts -file "$a9_CERT_FILE" -storepass "$a9_PASSWORD_JKS" -noprompt

	# crea cartella certs se non esiste
	mkdir -p /etc/certs/keycloak
	
	# copia tutti i file del certificato in /etc/certs
	cp -rf -n * /etc/certs/keycloak/

	# gestione permessi permette a tutti di leggere i file
	chmod -R 644 /etc/certs/keycloak

    exit 0
else
    echo "letsencrypt ${a9_DOMAIN} failed."
    exit 1
fi