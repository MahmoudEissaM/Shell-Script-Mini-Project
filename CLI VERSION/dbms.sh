#!/bin/bash

DB_PATH="DataBase"

mkdir -p "$DB_PATH"

create_database() {
    echo -n "Enter Database Name: "
    read db_name
    if [[ -d "$DB_PATH/$db_name" ]]; then
        echo "Database already exists!"
    else
        mkdir "$DB_PATH/$db_name"
        echo "Database '$db_name' created successfully."
    fi
}

list_databases() {
    echo "Available Databases:"
    ls "$DB_PATH"
}

drop_database() {
    echo -n "Enter Database Name to Drop: "
    read db_name
    if [[ -d "$DB_PATH/$db_name" ]]; then
        rm -r "$DB_PATH/$db_name"
        echo "Database '$db_name' deleted successfully."
    else
        echo "Database does not exist!"
    fi
}

connect_database() {
    echo -n "Enter Database Name to Connect: "
    read db_name
    if [[ -d "$DB_PATH/$db_name" ]]; then
        echo "Connected to Database: $db_name"
        ./tables.sh "$DB_PATH/$db_name"
    else
        echo "Database does not exist!"
    fi
}

while true; do
    echo -e "\n===== DBMS ====="
    echo "1) Create Database"
    echo "2) List Databases"
    echo "3) Connect To Database"
    echo "4) Drop Database"
    echo "5) Exit"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1) create_database ;;
        2) list_databases ;;
        3) connect_database ;;
        4) drop_database ;;
        5) exit 0 ;;
        *) echo "Invalid choice, please try again." ;;
    esac
done
