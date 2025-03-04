#!/bin/bash

DB_PATH="DataBase"
mkdir -p "$DB_PATH"

create_database() {
    db_name=$(zenity --entry --title="Create Database" --text="Enter database name:" --width=400 --height=200)
    if [[ -z "$db_name" ]]; then return; fi

    if [[ -d "$DB_PATH/$db_name" ]]; then
        zenity --error --text="Database already exists!" --width=400 --height=200
    else
        mkdir "$DB_PATH/$db_name"
        zenity --info --text="Database '$db_name' created successfully." --width=400 --height=200
    fi
}

list_databases() {
    dbs=$(ls "$DB_PATH")
    if [[ -z "$dbs" ]]; then dbs="No databases found"; fi
    zenity --list --title="Available Databases" --column="Database Name" $dbs --width=500 --height=300
}

drop_database() {
    db_name=$(zenity --entry --title="Delete Database" --text="Enter database name:" --width=400 --height=200)
    if [[ -z "$db_name" ]]; then return; fi

    if [[ -d "$DB_PATH/$db_name" ]]; then
        rm -r "$DB_PATH/$db_name"
        zenity --info --text="Database '$db_name' deleted successfully." --width=400 --height=200
    else
        zenity --error --text="Database not found!" --width=400 --height=200
    fi
}

connect_database() {
    db_name=$(zenity --entry --title="Connect to Database" --text="Enter database name:" --width=400 --height=200)
    if [[ -z "$db_name" ]]; then return; fi

    if [[ -d "$DB_PATH/$db_name" ]]; then
        zenity --info --text="Connected to database: $db_name" --width=400 --height=200
        ./gui_tables.sh "$DB_PATH/$db_name"
    else
        zenity --error --text="Database not found!" --width=400 --height=200
    fi
}

while true; do
    choice=$(zenity --list --title="Database Management" --column="Option" \
        "Create Database" "List Databases" "Connect to Database" "Delete Database" "Exit" --width=500 --height=300)

    case $choice in
        "Create Database") create_database ;;
        "List Databases") list_databases ;;
        "Connect to Database") connect_database ;;
        "Delete Database") drop_database ;;
        "Exit") exit 0 ;;
        *) zenity --error --text="Invalid selection!" --width=400 --height=200 ;;
    esac
done

