#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# Autenticarsi come amministratore
ACCESS_TOKEN=$(curl -s -X POST "${a7_KEYCLOAK_URL}/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=${a7_ADMIN_USERNAME}&password=${a7_ADMIN_PASSWORD}&grant_type=password&client_id=admin-cli" | jq -r '.access_token')

# Ottenere il client ID del client
CLIENT=$(curl -s -X GET "${a7_KEYCLOAK_URL}/admin/realms/${a7_REALM_NAME}/clients?clientId=${a7_CLIENT_ID}" \
  -H "Authorization: Bearer ${a7_ACCESS_TOKEN}" \
  -H "Content-Type: application/json")

CLIENT_ID=$(echo "${a7_CLIENT}" | jq -r '.[0].id')

# Modificare il client ID
curl -s -X PUT "${a7_KEYCLOAK_URL}/admin/realms/${a7_REALM_NAME}/clients/${a7_CLIENT_ID}" \
  -H "Authorization: Bearer ${a7_ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{\"clientId\":\"${a7_NEW_CLIENT_ID}\",\"enabled\":true}"
