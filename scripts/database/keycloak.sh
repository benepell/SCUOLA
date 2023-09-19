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

# Impostazione della politica delle password
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "SET GLOBAL validate_password.policy=${a2_PASSWORD_POLICY};"

# Controllo se il database esiste già e, in caso affermativo, lo elimino
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "DROP DATABASE IF EXISTS ${a2_DB_NAME};"

# Creazione del database
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "CREATE DATABASE ${a2_DB_NAME};"

# Controllo se l'utente esiste già e, in caso affermativo, lo elimino
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "SELECT User FROM mysql.user WHERE User='${a2_DB_USER}'" | grep "${a2_DB_USER}" && mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "DROP USER '${a2_DB_USER}'@'localhost';"

# Creazione dell'utente
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "CREATE USER '${a2_DB_USER}'@'localhost' IDENTIFIED BY '${a2_DB_PASSWORD}';"

# Concessione dei privilegi all'utente
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${a2_DB_NAME}.* TO '${a2_DB_USER}'@'localhost';"

# Controllo se l'utente in sola lettura esiste già e, in caso affermativo, lo elimino
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "SELECT User FROM mysql.user WHERE User='${a2_DB_USER_READ_ONLY}'" | grep "${a2_DB_USER_READ_ONLY}" && mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "DROP USER '${a2_DB_USER_READ_ONLY}'@'localhost';"

# Creazione dell'utente in sola lettura
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "CREATE USER '${a2_DB_USER_READ_ONLY}'@'localhost' IDENTIFIED BY '${a2_DB_PASSWORD_READ_ONLY}';"

# Concessione dei privilegi all'utente in sola lettura
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "GRANT SELECT ON ${a2_DB_NAME}.* TO '${a2_DB_USER_READ_ONLY}'@'localhost';"

# Aggiornamento dei privilegi
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" -e "FLUSH PRIVILEGES;"

# sostituisci client con valore da scuola TODO sospeso per ora
#sed -i 's/client/$SQL_SCUOLA/g' data-keycloak.sql

# importa database 
mysql -u "${a2_USER}" -p"${a2_PASSWORD}" "${a2_DB_NAME}"  < data-keycloak.sql

echo "Il database ${a2_DB_NAME} è stato creato e l'utente ${a2_DB_USER} è stato creato e gli sono stati concessi tutti i privilegi, e l'utente ${a2_DB_USER_READ_ONLY} è stato creato e gli sono stati concessi i privilegi di SELECT."
