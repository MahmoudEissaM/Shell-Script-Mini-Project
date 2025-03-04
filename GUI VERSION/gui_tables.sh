#!/bin/bash

DB_PATH=$1

create_table() {
    table_name=$(zenity --entry --title="Create Table" --text="Enter table name:" --width=400 --height=200)
    if [[ -z "$table_name" ]]; then return; fi

    table_path="$DB_PATH/$table_name"

    if [[ -f "$table_path" ]]; then
        zenity --error --text="Table already exists!" --width=400 --height=200
        return
    fi

    col_count=$(zenity --entry --title="Number of Columns" --text="Enter number of columns:" --width=400 --height=200)
    if ! [[ "$col_count" =~ ^[1-9][0-9]*$ ]]; then
        zenity --error --text="Invalid column count!" --width=400 --height=200
        return
    fi

    columns=()
    datatypes=()
    for ((i=1; i<=col_count; i++)); do
        col_name=$(zenity --entry --title="Column Name" --text="Enter column $i name:" --width=400 --height=200)
        col_type=$(zenity --list --title="Data Type" --column="Type" "string" "int" --width=400 --height=200)
        
        columns+=("$col_name")
        datatypes+=("$col_type")
    done

    primary_key=$(zenity --entry --title="Primary Key" --text="Enter primary key column:" --width=400 --height=200)
    if [[ ! " ${columns[@]} " =~ " $primary_key " ]]; then
        zenity --error --text="Invalid primary key!" --width=400 --height=200
        return
    fi

    echo "${columns[*]}" > "$table_path"
    echo "${datatypes[*]}" >> "$table_path"
    echo "$primary_key" >> "$table_path"

    zenity --info --text="Table '$table_name' created successfully." --width=400 --height=200
}

list_tables() {
    tables=$(ls "$DB_PATH")
    if [[ -z "$tables" ]]; then tables="No tables found"; fi
    zenity --list --title="Available Tables" --column="Table Name" $tables --width=500 --height=300
}

drop_table() {
    table_name=$(zenity --entry --title="Delete Table" --text="Enter table name:" --width=400 --height=200)
    if [[ -z "$table_name" ]]; then return; fi

    table_path="$DB_PATH/$table_name"

    if [[ -f "$table_path" ]]; then
        rm "$table_path"
        zenity --info --text="Table '$table_name' deleted successfully." --width=400 --height=200
    else
        zenity --error --text="Table not found!" --width=400 --height=200
    fi
}

insert_into_table() {
    table_name=$(zenity --entry --title="Insert Data" --text="Enter table name:" --width=400 --height=200)
    if [[ -z "$table_name" ]]; then return; fi

    table_path="$DB_PATH/$table_name"

    if [[ ! -f "$table_path" ]]; then
        zenity --error --text="Table not found!" --width=400 --height=200
        return
    fi

    IFS=' ' read -r -a columns < "$table_path"
    IFS=' ' read -r -a datatypes < "$table_path"

    values=()
    for ((i=0; i<${#columns[@]}; i++)); do
        value=$(zenity --entry --title="Insert Data" --text="Enter ${columns[$i]} (${datatypes[$i]}):" --width=400 --height=200)
        
        if [[ "${datatypes[$i]}" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
            zenity --error --text="Invalid data type for column ${columns[$i]}!" --width=400 --height=200
            return
        fi

        values+=("$value")
    done

    echo "${values[*]}" >> "$table_path"
    zenity --info --text="Data inserted successfully." --width=400 --height=200
}

select_from_table() {
    table_name=$(zenity --entry --title="View Data" --text="Enter table name:" --width=400 --height=200)
    if [[ -z "$table_name" ]]; then return; fi

    table_path="$DB_PATH/$table_name"

    if [[ ! -f "$table_path" ]]; then
        zenity --error --text="Table not found!" --width=400 --height=200
        return
    fi

    content=$(column -t -s " " "$table_path" | sed 's/^/"/;s/$/"/' | tr '\n' ' ')
    zenity --list --title="Table Data: $table_name" --column="Data" $content --width=600 --height=400
}

while true; do
    choice=$(zenity --list --title="Table Management" --column="Option" \
        "Create Table" "List Tables" "Delete Table" "Insert Data" "View Data" "Back" --width=500 --height=300)

    case $choice in
        "Create Table") create_table ;;
        "List Tables") list_tables ;;
        "Delete Table") drop_table ;;
        "Insert Data") insert_into_table ;;
        "View Data") select_from_table ;;
        "Back") exit 0 ;;
        *) zenity --error --text="Invalid selection!" --width=400 --height=200 ;;
    esac
done

