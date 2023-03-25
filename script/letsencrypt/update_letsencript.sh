#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# stop tomcat9 per liberare porta 80
systemctl stop tomcat9

# vai a percorso cert
CERT_PATH=$a12_(sudo find /etc/letsencrypt/live/ -name "${a12_DOMAIN}*")
cd "${a12_CERT_PATH}"

# Verificare se il file del certificato esiste
if [ ! -f "$a12_CERT_FILE" ]; then
  echo "File del certificato non trovato"
  exit 1
fi

# Verificare se il file della chiave privata esiste
if [ ! -f "$a12_PRIVKEY_FILE" ]; then
  echo "File della chiave privata non trovato"
  exit 1
fi

# Calcolare la data di scadenza del certificato
notAfter=$a12_(openssl x509 -in "$a12_CERT_FILE" -noout -enddate | cut -d= -f2)
if [ -z "$a12_notAfter" ]; then
  echo "Errore durante la lettura della data di scadenza del certificato"
  exit 1
fi

expiration=$a12_(date -d "$a12_notAfter" +"%s")
now=$a12_(date +"%s")
days_left=$a12_(( (expiration - now) / 86400 ))

# Verificare se il certificato è in scadenza (meno di 15 giorni)
if [ $a12_days_left -lt 15 ]; then
  in_scadenza=true
else
  in_scadenza=false
fi

echo "Il certificato scade in $a12_days_left giorni"
echo "In scadenza: $a12_in_scadenza"

# Se il certificato non è in scadenza e non è richiesto un nuovo certificato, terminare lo script
if [ "$a12_in_scadenza" = false ] && [ "$a12_CERT_OPTION" = "2" ]; then
  echo "Il certificato non è in scadenza e non è richiesto un nuovo certificato"
  exit 0
fi

# Esecuzione del comando certbot in modalità dry run
if certbot certonly --standalone --preferred-challenges http -d "${a12_DOMAIN}" --dry-run; then
    echo "test successful create cert."

    # GENERA CERTIFICATO
	echo "${a12_CERT_OPTION}" | certbot certonly --standalone --preferred-challenges http -d "${a12_DOMAIN}"

	# rimuovi precedenti files
	rm -f *.p12
	rm -f *.jks

	# Convertire il certificato e la chiave privata in un file PKCS12
	openssl pkcs12 -export -in "$a12_CERT_FILE" -inkey "$a12_PRIVKEY_FILE" -out "$a12_P12_FILE" -name "$a12_ALIAS" -passout pass:"$a12_PASSWORD_P12"

	# Importare il file PKCS12 nel keystore JKS
	keytool -importkeystore -srckeystore "$a12_P12_FILE" -srcstoretype pkcs12 -destkeystore "$a12_JKS_FILE" -deststoretype jks -alias "$a12_ALIAS" -deststorepass "$a12_PASSWORD_JKS" -srcstorepass "$a12_PASSWORD_P12" -noprompt

	# Aggiungere la catena di certificati al keystore JKS
	keytool -import -alias root -keystore "$a12_JKS_FILE" -trustcacerts -file "$a12_CERT_FILE" -storepass "$a12_PASSWORD_JKS" -noprompt
	
	# crea cartella certs se non esiste
	mkdir -p /etc/certs/scuola
	
	# copia tutti i file del certificato in /etc/certs
	cp -rf -n * /etc/certs/scuola/

	# gestione permessi permette a tutti di leggere i file
	chmod -R 644 /etc/certs/scuola

    exit 0
else
    echo "letsencrypt ${a12_DOMAIN} failed."
    exit 1
fi