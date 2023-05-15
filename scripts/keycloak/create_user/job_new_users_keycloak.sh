#!/bin/bash

# firstName del file di input
cmd="/opt/keycloak/bin/create_user.sh"

# Verifica l'esistenza del file di input
input_file="/var/www/html/risorse/files/conf/new_users.txt"
if [ ! -f "$input_file" ]; then
  echo "Il file $input_file non esiste. Uscita dallo script."
  exit 1
fi

# Leggi il file di input riga per riga
while IFS=, read -r classe sezione firstName lastName || [[ -n $classe ]]; do
  # Esegui lo split della riga in base alla virgola e passa i parametri allo script crea_file.sh
  $cmd "$classe" "$sezione" "$firstName" "$lastName"
done < "$input_file"

# Rinomina il file di input in new_users.txt.done
mv "$input_file" "$input_file.done"
