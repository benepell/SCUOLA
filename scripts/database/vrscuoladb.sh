#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# Impostazione della politica delle password
mysql -u "${a3_USER}" -p"${a3_PASSWORD}" -e "SET GLOBAL validate_password.policy=${a3_PASSWORD_POLICY};"

# Controllo se il database esiste già e, in caso affermativo, lo elimino
mysql -u "${a3_USER}" -p"${a3_PASSWORD}" -e "DROP DATABASE IF EXISTS ${a3_DB_NAME};"

# Creazione del database
mysql -u "${a3_USER}" -p"${a3_PASSWORD}" -e "CREATE DATABASE ${a3_DB_NAME};"

# Controllo se l'utente esiste già e, in caso affermativo, lo elimino
mysql -u "${a3_USER}" -p"${a3_PASSWORD}" -e "SELECT User FROM mysql.user WHERE User='${a3_DB_USER}'" | grep "${a3_DB_USER}" && mysql -u "${a3_USER}" -p"${a3_PASSWORD}" -e "DROP USER '${a3_DB_USER}'@'localhost';"

# Creazione dell'utente
mysql -u "${a3_USER}" -p"${a3_PASSWORD}" -e "CREATE USER '${a3_DB_USER}'@'localhost' IDENTIFIED BY '${a3_DB_PASSWORD}';"

# Concessione dei privilegi all'utente
mysql -u "${a3_USER}" -p"${a3_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${a3_DB_NAME}.* TO '${a3_DB_USER}'@'localhost';"

# Aggiornamento dei privilegi
mysql -u "${a3_USER}" -p"${a3_PASSWORD}" -e "FLUSH PRIVILEGES;"

echo "Il database ${a3_DB_NAME} è stato creato e l'utente ${a3_DB_USER} è stato creato e gli sono stati concessi tutti i privilegi."
