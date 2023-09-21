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

# Verificare se i file esistono
if [ ! -f "$a1_SSL_CERT_FILE" ]; then
  echo "File del certificato SSL non trovato"
  exit 1
fi

if [ ! -f "$a1_SSL_CERT_PK" ]; then
  echo "File della chiave privata SSL non trovato"
  exit 1
fi

if [ ! -f "$a1_SSL_CERT_CHAIN" ]; then
  echo "File della catena di certificati SSL non trovato"
  exit 1
fi

# Sostituire le righe nel file default-ssl.conf
sed -i "s/^\s*SSLEngine.*/SSLEngine on/" /etc/apache2/sites-available/default-ssl.conf
sed -i "s#^\s*SSLCertificateFile.*#SSLCertificateFile $a1_SSL_CERT_FILE#" /etc/apache2/sites-available/default-ssl.conf
sed -i "s#^\s*SSLCertificateKeyFile.*#SSLCertificateKeyFile $a1_SSL_CERT_PK#" /etc/apache2/sites-available/default-ssl.conf
sed -i "s#^\s*SSLCertificateChainFile.*#SSLCertificateChainFile $a1_SSL_CERT_CHAIN#" /etc/apache2/sites-available/default-ssl.conf

# inviare messaggio di notifica
echo "Wordpress in Apache2 SSL configurato"
