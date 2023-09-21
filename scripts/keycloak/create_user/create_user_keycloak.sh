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

# valori default
server="https://keycloak.vrscuola.it:9443"
credUser="admin"
credPass="vrscuola!!!"
realm="scuola"
kc="/opt/keycloak/bin/kcadm.sh"

# Parametri di input
classe=$1
section=$2
firstName=$3
lastName=$4

# email predefinita
dominio="@vrscuola.it"

# Genera l'username
username="$classe-$section-$firstName-$lastName"

# Genera la password
password="$firstName-$lastName"

# Stampa l'username a video
echo "Username: $username"

# Esegui un comando per verificare il login
$kc get realms

# Controlla lo stato di uscita del comando precedente
if [ $? -eq 0 ]; then
    echo "Login effettuato con successo!"
else
    echo "Errore durante il login."
	# necessario login su keycloak
	$kc config credentials --server $server --realm master --user $credUser --password $credPass
fi

# crea utente keycloak
$kc create users -r $realm -s username=$username -s firstName=$firstName -s lastName=$lastName -s enabled=true -i 

# genera password utente 
$kc set-password -r $realm --username $username --new-password $password
