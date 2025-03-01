#!/bin/bash

DB_PATH=$1

create_table() {
    echo -n "Enter Table Name: "
    read table_name

    local table_path="$DB_PATH/$table_name"

    if [[ -f "$table_path" ]]; then
        echo "Table already exists!"
        return
    fi

    echo -n "Enter Number of Columns: "
    read col_count

    if ! [[ "$col_count" =~ ^[1-9][0-9]*$ ]]; then
        echo "Invalid number of columns!"
        return
    fi

    local columns=()
    local datatypes=()
    local primary_key=""

    for ((i = 1; i <= col_count; i++)); do
        echo -n "Enter Column $i Name: "
        read col_name
        echo -n "Enter Data Type for $col_name (string/int): "
        read col_type

        if [[ "$col_type" != "string" && "$col_type" != "int" ]]; then
            echo "Invalid Data Type!"
            return
        fi

        columns+=("$col_name")
        datatypes+=("$col_type")
    done

    echo -n "Enter Primary Key Column: "
    read primary_key

    if [[ ! " ${columns[@]} " =~ " $primary_key " ]]; then
        echo "Invalid Primary Key!"
        return
    fi

    echo "${columns[*]}" > "$table_path"
    echo "${datatypes[*]}" >> "$table_path"
    echo "$primary_key" >> "$table_path"

    echo "Table '$table_name' created successfully."
}

list_tables() {
    echo "Available Tables in Database:"
    ls "$DB_PATH"
}

drop_table() {
    echo -n "Enter Table Name to Drop: "
    read table_name

    local table_path="$DB_PATH/$table_name"

    if [[ -f "$table_path" ]]; then
        rm "$table_path"
        echo "Table '$table_name' deleted successfully."
    else
        echo "Table does not exist!"
    fi
}

insert_into_table() {
    echo -n "Enter Table Name: "
    read table_name

    local table_path="$DB_PATH/$table_name"

    if [[ ! -f "$table_path" ]]; then
        echo "Table does not exist!"
        return
    fi

    IFS=' ' read -r -a columns < "$table_path"
    IFS=' ' read -r -a datatypes < "$table_path"
    read -r primary_key < <(sed -n '3p' "$table_path")

    local values=()
    for ((i = 0; i < ${#columns[@]}; i++)); do
        echo -n "Enter ${columns[$i]} (${datatypes[$i]}): "
        read value

        if [[ "${datatypes[$i]}" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
            echo "Invalid data type for ${columns[$i]}"
            return
        fi

        values+=("$value")
    done

    if grep -q "^${values[0]} " "$table_path"; then
        echo "Error: Primary Key must be unique!"
        return
    fi

    echo "${values[*]}" >> "$table_path"
    echo "Row inserted successfully."
}

select_from_table() {
    echo -n "Enter Table Name: "
    read table_name

    local table_path="$DB_PATH/$table_name"

    if [[ ! -f "$table_path" ]]; then
        echo "Table does not exist!"
        return
    fi

    column -t -s ' ' "$table_path"
}

while true; do
    echo -e "\n===== Table Management ====="
    echo "1) Create Table"
    echo "2) List Tables"
    echo "3) Drop Table"
    echo "4) Insert into Table"
    echo "5) Select From Table"
    echo "6) Back to Main Menu"
    echo -n "Enter your choice: "
    read choice

    case $choice in
        1) create_table ;;
        2) list_tables ;;
        3) drop_table ;;
        4) insert_into_table ;;
        5) select_from_table ;;
        6) exit 0 ;;
        *) echo "Invalid choice!" ;;
    esac
done
