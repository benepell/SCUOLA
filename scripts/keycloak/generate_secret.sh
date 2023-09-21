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

# Autenticarsi come amministratore
ACCESS_TOKEN=$(curl -s -X POST "${a8_KEYCLOAK_URL}/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=${a8_ADMIN_USERNAME}&password=${a8_ADMIN_PASSWORD}&grant_type=password&client_id=admin-cli" | jq -r '.access_token')

# Generare un nuovo secret
NEW_SECRET=$(curl -s -X POST "${a8_KEYCLOAK_URL}/admin/realms/${a8_REALM_NAME}/clients/${a8_CLIENT_ID}/client-secret" \
  -H "Authorization: Bearer ${a8_ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"expiration": 0}')

echo "Il nuovo secret per il client ${a8_CLIENT_ID} è: ${a8_NEW_SECRET}"

# Ottenere il client ID del client
CLIENT=$(curl -s -X GET "${a8_KEYCLOAK_URL}/admin/realms/${a8_REALM_NAME}/clients?clientId=${a8_CLIENT_ID}" \
  -H "Authorization: Bearer ${a8_ACCESS_TOKEN}" \
  -H "Content-Type: application/json")

CLIENT_ID=$(echo "${a8_CLIENT}" | jq -r '.[0].id')

# Aggiornare il client secret
curl -s -X PUT "${a8_KEYCLOAK_URL}/admin/realms/${a8_REALM_NAME}/clients/${a8_CLIENT_ID}/client-secret" \
  -H "Authorization: Bearer ${a8_ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{\"value\":\"${a8_NEW_SECRET}\",\"temporary\":false}"
