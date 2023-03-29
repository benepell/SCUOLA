#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

echo "KEYSTORE_FILE: $a15_KEYSTORE_FILE"
# Verificare se il file esiste
if [ ! -f "$a15_KEYSTORE_FILE" ]; then
  echo "File del keystore JKS non trovato"
  exit 1
fi

# Sostituire la riga del connettore nel file server.xml
sed -i "s#keystoreFile=\"[^\"]*\"#keystoreFile=\"$a15_KEYSTORE_FILE\"#g; s#keystorePass=\"[^\"]*\"#keystorePass=\"$a15_KEYSTORE_PASSWORD\"#g" /var/lib/tomcat9/conf/server.xml
