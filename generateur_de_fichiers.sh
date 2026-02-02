#!/bin/bash

# --- Configuration et Préparation ---
DEST="./tmp/transfert"
mkdir -p "$DEST"

echo "Génération des fichiers de test dans $DEST..."

# --- Calcul de la Température ---
# Lecture de la zone thermique 0
TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
TEMP_C=$((TEMP / 1000))

# --- Génération des fichiers CSV ---
echo "$(date +%Y-%m-%d);${TEMP_C}°C" > "$DEST/Fichier1.csv"

{
    echo "Technicien;toto"
    echo "$(date +%Y-%m-%d)"
} > "$DEST/Fichier2.csv"

touch "$DEST/Fichier3.csv"

# --- Génération du fichier Texte ---
{
    echo "Lorem ipsum dolor sit amet, consectetur elit."
    echo "Sed do eiusmod tempor incididunt ut labore p."
    echo "Ut enim ad minim veniam, quis nostrud exerc."
} > "$DEST/Fichier4.txt"

# --- Génération des fichiers Logs et Système ---
{
    echo "Utilisateur: $USER"
    echo "Date: $(date)"
} > "$DEST/Fichier5.log"

free -h > "$DEST/Fichier6.sys"

# --- Conclusion ---
echo "Tous les fichiers ont été générés avec succès."

ls -l "$DEST"
