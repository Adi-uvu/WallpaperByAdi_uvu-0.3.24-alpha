#!/bin/bash

ROOT_UID=0
DEST_DIR=""
DESKTOP_ENV=""

# Kolory ANSI do tęczowego tekstu
RED='\033[0;31m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
RESET='\033[0m'  # Resetowanie koloru

# Tabela kolorów w pionie
COLORS=($RED $ORANGE $YELLOW $GREEN $CYAN $BLUE $PURPLE)

# ASCII Art
TEXT=(
"              _ _                    "
"     /\\      | (_)                   "
"    /  \\   __| |_  _   ___   ___   _ "
"   / /\\ \\ / _\` | || | | \\ \\ / / | | |"
"  / ____ \\ (_| | || |_| |\\ V /| |_| |"
" /_/    \\_\\__,_|_| \\__,_| \\_/  \\__,_|"
"               ______                "
"              |______|               "
)

# Wyświetlanie ASCII Art z kolorami pionowymi
for (( i=0; i<${#TEXT[@]}; i++ )); do
  LINE="${TEXT[$i]}"
  for (( j=0; j<${#LINE}; j++ )); do
    CHAR="${LINE:$j:1}"
    COLOR=${COLORS[$((j % ${#COLORS[@]}))]}
    echo -ne "${COLOR}${CHAR}${RESET}"
  done
  echo ""
done

# Funkcja do wykrywania środowiska graficznego
detect_desktop_env() {
  case "$XDG_CURRENT_DESKTOP" in
    "GNOME" | "X-Cinnamon" | "Budgie" | "Budgie:GNOME" | "Unity")
      DESKTOP_ENV="GTK"
      ;;
    "KDE" | "Lxqt")
      DESKTOP_ENV="QT"
      ;;
    "Cutefish")
      DESKTOP_ENV="fish"
      ;;
    "XFCE")
      DESKTOP_ENV="xfce"
      ;;
    "MATE")
      DESKTOP_ENV="mate"
      ;;
    "Unity:Unity7:ubuntu")
      DESKTOP_ENV="ubuntu-unity"
      ;;
    "UKUI")
      DESKTOP_ENV="ukui"
      ;;
    *)
      echo "Nie można wykryć środowiska graficznego GTK lub QT..."
      exit 1
      ;;
  esac
}

# Sprawdzanie, czy skrypt jest uruchamiany jako root
if [ "$UID" -ne "$ROOT_UID" ]; then
  echo "Ten skrypt wymaga uprawnien roota. Użyj sudo do uruchomienia skryptu."
  exit 1
fi

# Funkcja do kopiowania plików z katalogu build/wallpaper-0.3.24-ex
copy_ex_files() {
  case "$DESKTOP_ENV" in
    "GTK")
      DEST_DIR="/usr/share/backgrounds"
      cp -pr build/wallpaper-0.3.24-ex $DEST_DIR/wallpaper-0.3.24
      DEST_DIR="/usr/share/gnome-background-properties"
      cp -rT main/gtk $DEST_DIR
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane (protokół GTK)"
      ;;
    "QT")
      DEST_DIR="/usr/share/wallpapers"
      cp -pr build/wallpaper-0.3.24-ex $DEST_DIR/wallpaper-0.3.24
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół QT)"
      ;;
    "fish")
      DEST_DIR="/usr/share/backgrounds/cutefishos"
      cp -r build/wallpaper-0.3.24-ex/* "$DEST_DIR/"
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół Fish[QT])"
      ;;
    "xfce")
      DEST_DIR="/usr/share/xfce4/backdrops"
      cp -r build/wallpaper-0.3.24-ex/* "$DEST_DIR/"
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół XFCE[GTK])"
      ;;
    "mate")
      DEST_DIR="/usr/share/backgrounds"
      cp -pr build/wallpaper-0.3.24-ex $DEST_DIR/wallpaper-0.3.24
      DEST_DIR="/usr/share/mate-background-properties"
      cp -rT main/gtk $DEST_DIR
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół GTK)"
      ;;
    "ubuntu-unity")
      DEST_DIR="/usr/share/backgrounds/ubuntu-unity"
      cp -pr build/wallpaper-0.3.24-ex $DEST_DIR/wallpaper-0.3.24
      DEST_DIR="/usr/share/gnome-background-properties"
      cp -rT main/unity $DEST_DIR
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół GTK)"
      ;;
    "ukui")
      DEST_DIR="/usr/share/backgrounds"
      cp -pr build/wallpaper-0.3.24-ex $DEST_DIR/wallpaper-0.3.24
      DEST_DIR="/usr/share/ukui-background-properties"
      cp -rT main/gtk $DEST_DIR
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół UKUI[QT])"
      ;;
    *)
      echo "Nieobsługiwane środowisko graficzne."
      exit 1
      ;;
  esac
}

# Wykrywanie środowiska graficznego
detect_desktop_env

# Sprawdzanie opcji -ex
if [ "$1" = "-ex" ]; then
  copy_ex_files
  exit 0
fi

# Wykonywanie operacji na podstawie wykrytego środowiska
case "$DESKTOP_ENV" in
  "GTK")
    DEST_DIR="/usr/share/backgrounds"
    cp -pr build/wallpaper-0.3.24 $DEST_DIR/wallpaper-0.3.24
    DEST_DIR="/usr/share/gnome-background-properties"
    cp -rT main/gtk $DEST_DIR
    echo "Pliki zostały pomyślnie skopiowane (protokół GTK)."
    ;;
  "QT")
    DEST_DIR="/usr/share/wallpapers"
    cp -pr build/wallpaper-0.3.24 $DEST_DIR/wallpaper-0.3.24
    echo "Pliki zostały pomyślnie skopiowane... (protokół QT)."
    ;;
  "fish")
    DEST_DIR="/usr/share/backgrounds/cutefishos"
    cp -r build/wallpaper-0.3.24/* "$DEST_DIR/"
    echo "Pliki zostały pomyślnie skopiowane... (protokół Fish[QT])."
    ;;
  "xfce")
    DEST_DIR="/usr/share/xfce4/backdrops"
    cp -r build/wallpaper-0.3.24/* "$DEST_DIR/"
    echo "Pliki zostały pomyślnie skopiowane... (protokół XFCE[GTK])."
    ;;
  "mate")
    DEST_DIR="/usr/share/backgrounds"
    cp -pr build/wallpaper-0.3.24 $DEST_DIR/wallpaper-0.3.24
    DEST_DIR="/usr/share/mate-background-properties"
    cp -rT main/gtk $DEST_DIR
    echo "Pliki zostały pomyślnie skopiowane... (protokół GTK)."
    ;;
  "ubuntu-unity")
    DEST_DIR="/usr/share/backgrounds/ubuntu-unity"
    cp -pr build/wallpaper-0.3.24 $DEST_DIR/wallpaper-0.3.24
    DEST_DIR="/usr/share/gnome-background-properties"
    cp -rT main/unity $DEST_DIR
    echo "Pliki zostały pomyślnie skopiowane... (protokół GTK)."
    ;;
  "ukui")
    DEST_DIR="/usr/share/backgrounds"
    cp -pr build/wallpaper-0.3.24 $DEST_DIR/wallpaper-0.3.24
    DEST_DIR="/usr/share/ukui-background-properties"
    cp -rT main/gtk $DEST_DIR
    echo "Pliki zostały pomyślnie skopiowane... (protokół UKUI[QT])."
    ;;
  *)
    echo "Nieobsługiwane środowisko graficzne."
    exit 1
    ;;
esac