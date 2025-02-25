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
source ../../env_vars.sh

# Verificare se il file .war esiste
if [ ! -f "$a13_WAR_FILE" ]; then
  echo "File .war non trovato"
  exit 1
fi

# Copiare il file .war nella directory webapps di Tomcat
cp "$a13_WAR_FILE" "$a13_TOMCAT_WEBAPPS_DIR/"

#restart tomcat
sudo systemctl restart tomcat9

# attendo 30 secondi
sleep 30

# Trovare il file application.properties
a13_PROPERTIES_FILE="$a13_TOMCAT_WEBAPPS_DIR/$a13_APP_NAME/WEB-INF/classes/application.properties"

# Verificare se il file application.properties esiste
if [ ! -f "$a13_PROPERTIES_FILE" ]; then
  echo "File application.properties non trovato"
  exit 1
fi

# Modificare i parametri nel file application.properties
sed -i "s|^keycloak.resource=.*|keycloak.resource=$a13_KEYCLOAK_RESOURCE|" "$a13_PROPERTIES_FILE"
sed -i "s|^keycloak.credentials.secret=.*|keycloak.credentials.secret=$a13_KEYCLOAK_CREDENTIALS_SECRET|" "$a13_PROPERTIES_FILE"
sed -i "s|^spring.datasource.url=.*|spring.datasource.url=$a13_DB_URL|" "$a13_PROPERTIES_FILE"
sed -i "s|^spring.datasource.username=.*|spring.datasource.username=$a13_DB_USERNAME|" "$a13_PROPERTIES_FILE"
sed -i "s|^spring.datasource.password=.*|spring.datasource.password=$a13_DB_PASSWORD|" "$a13_PROPERTIES_FILE"
sed -i "s|^spring.datasource.driver-class-name=.*|spring.datasource.driver-class-name=$a13_DB_DRIVER_CLASS|" "$a13_PROPERTIES_FILE"
sed -i "s|^spring.thymeleaf.prefix=.*|spring.thymeleaf.prefix=$a13_THYMELEAF_PREFIX|" "$a13_PROPERTIES_FILE"
sed -i "s|^spring.thymeleaf.suffix=.*|spring.thymeleaf.suffix=$a13_THYMELEAF_SUFFIX|" "$a13_PROPERTIES_FILE"
