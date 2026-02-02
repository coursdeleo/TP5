#!/bin/bash
# ******************************************************
# Nom: gestion_techniciens.sh
# Description: Extrait le nom du technicien et crée l'utilisateur s'il n'existe pas
# ******************************************************

SOURCE="./tmp/transfert"

# Vérifier si le dossier source existe
if [ ! -d "$SOURCE" ]; then
  echo "Erreur : Le dossier $SOURCE n'existe pas."
  exit 1
fi

echo "Début de la vérification des techniciens..."

for fichier in "$SOURCE"/*.csv
do
  # Sécurité : vérifier que le fichier existe et n'est pas vide
  if [ -s "$fichier" ]; then
    
    # Extraction du nom du technicien (2ème colonne de la 1ère ligne)
    # On utilise head pour la ligne 1 et cut pour séparer après le ";"
    NOM_TECH=$(head -n 1 "$fichier" | cut -d ';' -f 2)

    # Vérifier que la variable NOM_TECH n'est pas vide
    if [ -n "$NOM_TECH" ]; then
      
      # Vérifier si l'utilisateur existe déjà sur le système
      if id "$NOM_TECH" &>/dev/null; then
        echo "Fichier $(basename "$fichier") : L'utilisateur '$NOM_TECH' existe déjà."
      else
        echo "Fichier $(basename "$fichier") : Utilisateur '$NOM_TECH' inconnu. Création..."
        
        # Création de l'utilisateur avec son répertoire home (-m)
        sudo useradd -m "$NOM_TECH"
        
        if [ $? -eq 0 ]; then
          echo "Succès : L'utilisateur '$NOM_TECH' a été créé."
        else
          echo "Erreur : Impossible de créer l'utilisateur '$NOM_TECH'."
        fi
      fi
    else
      echo "Alerte : Impossible d'extraire un nom dans $(basename "$fichier")."
    fi
  fi
done

echo "Opération terminée."
