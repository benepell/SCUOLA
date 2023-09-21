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

# Cerca e sostituisci i valori nel file keycloak.conf
sed -i "s/^db-username=.*/db-username=$a5_DB_USERNAME/" "$a5_KEYCLOAK_BASE"/conf/keycloak.conf
sed -i "s/^db-password=.*/db-password=$a5_DB_PASSWORD/" "$a5_KEYCLOAK_BASE"/conf/keycloak.conf
sed -i "s|^db-url=.*|db-url=$a5_DB_URL|" "$a5_KEYCLOAK_BASE"/conf/keycloak.conf
sed -i "s|^hostname=.*|hostname=$a5_HOSTNAME|" "$a5_KEYCLOAK_BASE"/conf/keycloak.conf