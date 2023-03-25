#!/bin/bash

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
