#!/bin/bash

DOT_FILE_BASE=$1

# Sprawdzenie czy wymagane narzędzia są zainstalowane
if ! command -v dot &> /dev/null; then
    echo "Błąd: Graphviz (dot) nie jest zainstalowany"
    exit 1
fi

if ! command -v 7z &> /dev/null; then
    echo "Błąd: 7-Zip nie jest zainstalowany"
    exit 1
fi

# Sprawdzenie czy plik *.dot istnieje
if [[ ! -f "./${DOT_FILE_BASE}.dot" ]]; then
    echo "Błąd: Plik ./${DOT_FILE_BASE}.dot nie istnieje"
    exit 1
fi

# Generowanie PNG z DOT
echo "Generowanie *.png..."
dot -Tpng "./${DOT_FILE_BASE}.dot" -o "${DOT_FILE_BASE}.png"

if [[ $? -ne 0 ]]; then
    echo "Błąd podczas generowania PNG"
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
7z a -t7z -mhe=on -m0=lzma2 -mx=9 -mfb=273 -ms=on -mmt=on \
    -p"$PASSWORD" "${DOT_FILE_BASE}.7z" \
    "./${DOT_FILE_BASE}.dot" "./${DOT_FILE_BASE}.png"

if [[ $? -eq 0 ]]; then
    echo "Sukces! Archiwum ${DOT_FILE_BASE}.7z zostało utworzone (AES-256)."
    echo "Pliki źródłowe pozostawiono w katalogu bieżącym."
    echo "Usunięto pliki źródłowe"

    rm "./${DOT_FILE_BASE}.dot" "./${DOT_FILE_BASE}.png"

    ls -lat

    echo "Pozostało zakomitować (TODO)"
else
    echo "Błąd podczas tworzenia archiwum"
    exit 1
fi
