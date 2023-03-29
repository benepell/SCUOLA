#!/bin/bash

# Caricare le variabili d'ambiente dal file env_vars.sh
source ../env_vars.sh

# Impostazione della politica delle password
mysql -u "${a4_USER}" -p"${a4_PASSWORD}" -e "SET GLOBAL validate_password.policy=LOW;"

# Controllo se il database esiste già e, in caso affermativo, lo elimino
mysql -u "${a4_USER}" -p"${a4_PASSWORD}" -e "DROP DATABASE IF EXISTS ${a4_DB_NAME};"

# Creazione del database
mysql -u "${a4_USER}" -p"${a4_PASSWORD}" -e "CREATE DATABASE ${a4_DB_NAME};"

# Controllo se l'utente esiste già e, in caso affermativo, lo elimino
mysql -u "${a4_USER}" -p"${a4_PASSWORD}" -e "SELECT User FROM mysql.user WHERE User='${a4_DB_USER}'" | grep "${a4_DB_USER}" && mysql -u "${a4_USER}" -p"${a4_PASSWORD}" -e "DROP USER '${a4_DB_USER}'@'localhost';"

# Creazione dell'utente
mysql -u "${a4_USER}" -p"${a4_PASSWORD}" -e "CREATE USER '${a4_DB_USER}'@'localhost' IDENTIFIED BY '${a4_DB_PASSWORD}';"

# Concessione dei privilegi all'utente
mysql -u "${a4_USER}" -p"${a4_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${a4_DB_NAME}.* TO '${a4_DB_USER}'@'localhost';"

# Aggiornamento dei privilegi
mysql -u "${a4_USER}" -p"${a4_PASSWORD}" -e "FLUSH PRIVILEGES;"

echo "Il database ${a4_DB_NAME} è stato creato e l'utente ${a4_DB_USER} è stato creato e gli sono stati concessi tutti i privilegi."

# sostituisci url con valore da scuola
sed -i 's#https://scuola.vrscuola.online:8443#${a4_URL}#g' data-wordpress.sql

# sostituisci scuola-elementare con valore da scuola per ora sospeso

# importa database 
mysql -u "${a4_USER}" -p"${a4_PASSWORD}" "${a4_DB_NAME}" < data-wordpress.sql

