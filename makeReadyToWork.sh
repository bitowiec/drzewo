#!/bin/bash

DOT_FILE_BASE=$1

if ! command -v 7z &> /dev/null; then
    echo "Błąd: 7-Zip nie jest zainstalowany"
    exit 1
fi

# Sprawdzenie czy plik *.dot istnieje
if [[ -f "./${DOT_FILE_BASE}.dot" ]]; then
    echo "Błąd: Plik ./${DOT_FILE_BASE}.dot istnieje. Usuń go lub zmień nazwę"
    exit 1
fi

# Pobranie hasła od użytkownika (nie zapisuje się w historii)
#read -s -p "Podaj hasło do archiwum: " PASSWORD
if [[ ! -f "./pass.txt" ]]; then
    echo "Błąd: Plik ./pass.txt nie istnieje"
    exit 1
fi
PASSWORD=$(cat pass.txt)

echo $PASSWORD
echo

# Spakowanie obu plików do szyfrowanego archiwum AES256
echo "Tworzenie zaszyfrowanego archiwum..."
7z x -p"$PASSWORD" "${DOT_FILE_BASE}.7z"

if [[ $? -eq 0 ]]; then
    echo "Sukces! Archiwum ${DOT_FILE_BASE}.7z zostało rozpakowane."
    echo "Pliki źródłowe pozostawiono w katalogu bieżącym."

    mv "${DOT_FILE_BASE}.7z" "${DOT_FILE_BASE}_$(date +%s).7z"

    ls -lat

    echo "Gotowy do pracy"
else
    echo "Błąd podczas tworzenia archiwum"
    exit 1
fi
