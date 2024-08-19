#!/bin/bash

ROOT_UID=0
DEST_DIR=""
DESKTOP_ENV=""

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

# Wyświetlanie ASCII Art
for LINE in "${TEXT[@]}"; do
  echo "$LINE"
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
      cp -pr build/wallpaper-0.3.24-ex/* $DEST_DIR/wallpaper-0.3.24
      DEST_DIR="/usr/share/gnome-background-properties"
      cp -rT main/gtk $DEST_DIR
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane (protokół GTK)"
      ;;
    "QT")
      DEST_DIR="/usr/share/wallpapers"
      cp -pr build/wallpaper-0.3.24-ex/* $DEST_DIR/wallpaper-0.3.24
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół QT)"
      ;;
    "fish")
      DEST_DIR="/usr/share/backgrounds/cutefishos"
      cp -r build/wallpaper-0.3.24-ex/* $DEST_DIR/wallpaper-0.3.24
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół Fish[QT])"
      ;;
    "xfce")
      DEST_DIR="/usr/share/xfce4/backdrops"
      cp -r build/wallpaper-0.3.24-ex/* "$DEST_DIR/"
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół XFCE[GTK])"
      ;;
    "mate")
      DEST_DIR="/usr/share/backgrounds"
      cp -pr build/wallpaper-0.3.24-ex/* $DEST_DIR/wallpaper-0.3.24
      DEST_DIR="/usr/share/mate-background-properties"
      cp -rT main/gtk $DEST_DIR
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół GTK)"
      ;;
    "ubuntu-unity")
      DEST_DIR="/usr/share/backgrounds/ubuntu-unity"
      cp -pr build/wallpaper-0.3.24-ex/* $DEST_DIR/wallpaper-0.3.24
      DEST_DIR="/usr/share/gnome-background-properties"
      cp -rT main/unity $DEST_DIR
      echo "Pliki rozrzeżone zostały pomyślnie skopiowane... (protokół GTK)"
      ;;
    "ukui")
      DEST_DIR="/usr/share/backgrounds"
      cp -pr build/wallpaper-0.3.24-ex/* $DEST_DIR/wallpaper-0.3.24
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
    cp -r build/wallpaper-0.3.24/* $DEST_DIR/wallpaper-0.3.24
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
