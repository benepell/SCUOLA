#!/bin/bash

# Copyright (c) 2023, Benedetto Pellerito
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

# Genera il contenuto del file sh
echo "#!/bin/bash" > "$a6_KEYCLOAK_BASE"/bin/start.sh
echo "export KEYCLOAK_ADMIN=$a6_KEYCLOAK_ADMIN" >> "$a6_KEYCLOAK_BASE"/bin/start.sh
echo "export KEYCLOAK_ADMIN_PASSWORD=$a6_KEYCLOAK_ADMIN_PASSWORD" >> "$a6_KEYCLOAK_BASE"/bin/start.sh
echo "./kc.sh -v start --https-port=$a6_HTTPS_PORT --https-key-store-file=$a6_HTTPS_KEY_STORE_FILE --https-key-store-password='$a6_HTTPS_KEY_STORE_PASSWORD'" >> "$a6_KEYCLOAK_BASE"/bin/start.sh

# Imposta i permessi di esecuzione del file sh
chmod +x "$a6_KEYCLOAK_BASE"/bin/start.sh