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
