#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# Genera il contenuto del file sh
echo "#!/bin/bash" > "$a6_KEYCLOAK_BASE"/bin/start.sh
echo "export KEYCLOAK_ADMIN=$a6_KEYCLOAK_ADMIN" >> "$a6_KEYCLOAK_BASE"/bin/start.sh
echo "export KEYCLOAK_ADMIN_PASSWORD=$a6_KEYCLOAK_ADMIN_PASSWORD" >> "$a6_KEYCLOAK_BASE"/bin/start.sh
echo "./kc.sh -v start --https-port=$a6_HTTPS_PORT --https-key-store-file=$a6_HTTPS_KEY_STORE_FILE --https-key-store-password='$a6_HTTPS_KEY_STORE_PASSWORD'" >> "$a6_KEYCLOAK_BASE"/bin/start.sh

# Imposta i permessi di esecuzione del file sh
chmod +x "$a6_KEYCLOAK_BASE"/bin/start.sh