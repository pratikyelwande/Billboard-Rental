#!/bin/bash

# Database setup script for multiple SQL files

# Set database details
DB_NAME="billboard_rental"
USERNAME="root"
PASSWORD="your_password"  # Replace with your actual MySQL root password
SQL_FILES_DIR="/home/pratik/Downloads/Database"  # Adjust the path as necessary

# Check if MySQL is installed
if ! command -v mysql &> /dev/null; then
    echo "MySQL is not installed or not in the system PATH."
    exit 1
fi

# Create the database (if it doesn't exist)
echo "Creating database $DB_NAME..."
mysql -u "$USERNAME" -p"$PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Import all SQL files in the directory
echo "Importing database tables from $SQL_FILES_DIR..."
for sql_file in "$SQL_FILES_DIR"/*.sql; do
    if [ -f "$sql_file" ]; then
        echo "Importing $sql_file..."
        mysql -u "$USERNAME" -p"$PASSWORD" "$DB_NAME" < "$sql_file"
        
        if [ $? -ne 0 ]; then
            echo "Failed to import $sql_file."
            exit 1
        fi
    else
        echo "No SQL files found in $SQL_FILES_DIR."
    fi
done

echo "All SQL files imported successfully."
