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

# firstName del file di input
cmd="/opt/keycloak/bin/create_user.sh"

# Verifica l'esistenza del file di input
input_file="/var/www/html/risorse/files/conf/create_users.txt"
if [ ! -f "$input_file" ]; then
  echo "Il file $input_file non esiste. Uscita dallo script."
  exit 1
fi

tmp="/var/www/html/risorse/files/conf/create_users"
mv "$input_file" "$tmp"

# Leggi il file di input riga per riga
while IFS=, read -r classe sezione firstName lastName || [[ -n $classe ]]; do
  # Esegui lo split della riga in base alla virgola e passa i parametri allo script crea_file.sh
  cmd_with_params="$cmd \"$username\" \"$password\" \"$group\" \"$firstName\" \"$lastName\""
  eval $cmd_with_params

done < "$tmp"
ext=".txt.done"
# Rinomina il file di input in new_users.txt.done
mv "$tmp" "$tmp$ext"
