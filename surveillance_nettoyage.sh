#!/bin/bash
# ******************************************************
# Nom: surveillance_nettoyage.sh
# Description: Scan, filtrage et nettoyage du dossier transfert
# ******************************************************
SOURCE="/tmp/transfert"
QUARANTAINE="/tmp/quarantaine"

# Création des dossiers s'ils n'existent pas
if [ ! -d "$SOURCE" ]; then
  mkdir -p "$SOURCE"
fi

if [ ! -d "$QUARANTAINE" ]; then
  mkdir -p "$QUARANTAINE"
fi

echo "Analyse du dossier $SOURCE en cours..."

for fichier in "$SOURCE"/*
do
  # Sécurité : Vérifier si le dossier est
  [ -e "$fichier" ] || continue # passe au fichier suivant

  # On récupère juste le nom du fichier (sans le chemin /tmp/transfert/)
  NOM_FICH=$(basename "$fichier")

  # Test de l'extension : Si ce n'est pas un .csv
  if [[ ! "$NOM_FICH" == *.csv ]]; then
    echo "Alerte : $NOM_FICH n'est pas un CSV. Déplacement en quarantaine."
    mv "$fichier" "$QUARANTAINE/"
    continue # passe au fichier suivant
  fi

  # Test de la taille : Si le fichier .csv est vide (0 octet)
  if [ ! -s "$fichier" ]; then
    echo "Nettoyage : $NOM_FICH est vide. Suppression."
    rm "$fichier"
  else
    echo "Validation : $NOM_FICH est conforme (format CSV et non vide)."
  fi
done

echo "Traitement terminé."