#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# stop tomcat9 per liberare porta 80
systemctl stop tomcat9

# vai a percorso cert
CERT_PATH=$a11_(sudo find /etc/letsencrypt/live/ -name "${a11_DOMAIN}*")
cd "${a11_CERT_PATH}"

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
notAfter=$a11_(openssl x509 -in "$a11_CERT_FILE" -noout -enddate | cut -d= -f2)
if [ -z "$a11_notAfter" ]; then
  echo "Errore durante la lettura della data di scadenza del certificato"
  exit 1
fi

expiration=$a11_(date -d "$a11_notAfter" +"%s")
now=$a11_(date +"%s")
days_left=$a11_(( (expiration - now) / 86400 ))

# Verificare se il certificato è in scadenza (meno di 15 giorni)
if [ $a11_days_left -lt 15 ]; then
  in_scadenza=true
else
  in_scadenza=false
fi

echo "Il certificato scade in $a11_days_left giorni"
echo "In scadenza: $a11_in_scadenza"

# Se il certificato non è in scadenza e non è richiesto un nuovo certificato, terminare lo script
if [ "$a11_in_scadenza" = false ] && [ "$a11_CERT_OPTION" = "2" ]; then
  echo "Il certificato non è in scadenza e non è richiesto un nuovo certificato"
  exit 0
fi

# Esecuzione del comando certbot in modalità dry run
if certbot certonly --standalone --preferred-challenges http -d "${a11_DOMAIN}" --dry-run; then
    echo "test successful create cert."

    # GENERA CERTIFICATO
	echo "${a11_CERT_OPTION}" | certbot certonly --standalone --preferred-challenges http -d "${a11_DOMAIN}"

	# vai a percorso cert
	CERT_PATH=$a11_(sudo find /etc/letsencrypt/live/ -name "${a11_DOMAIN}*")
	cd "${a11_CERT_PATH}"

	# rimuovi precedenti files
	rm -f *.p12
	rm -f *.jks

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
    echo "letsencrypt ${a11_DOMAIN} failed."
    exit 1
fi