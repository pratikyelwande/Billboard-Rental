@echo off
:: Database setup script for multiple SQL files

:: Set database details
set DB_NAME=billboard_rental
set USERNAME=root
set PASSWORD=root
set SQL_FILES_DIR=C:\Users\Pratik\Downloads\Database

:: Check if MySQL is installed
mysql --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo MySQL is not installed or not added to the system PATH.
    pause
    exit /b
)

:: Create the database (if it doesn't exist)
echo Creating database %DB_NAME%...
mysql -u %USERNAME% -p%PASSWORD% -e "CREATE DATABASE IF NOT EXISTS %DB_NAME%;"

:: Import all SQL files in the directory
echo Importing database tables from %SQL_FILES_DIR%...
for %%f in ("%SQL_FILES_DIR%\*.sql") do (
    echo Importing %%f...
    mysql -u %USERNAME% -p%PASSWORD% %DB_NAME% < "%%f"
    
    if %ERRORLEVEL% neq 0 (
        echo Failed to import %%f.
        pause
        exit /b
    )
)

echo All SQL files imported successfully.
pause
