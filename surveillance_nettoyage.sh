#!/bin/bash
# Nom: surveillance_nettoyage.sh
# Emplacement: TP5/surveillance_nettoyage.sh

# Chemins relatifs au dossier courant (TP5)
SOURCE="./transfert"
QUARANTAINE="./quarantaine"

# Création des dossiers s'ils n'existent pas [cite: 42, 43, 46]
mkdir -p "$SOURCE"
mkdir -p "$QUARANTAINE"

echo "Analyse du dossier $SOURCE en cours..."

for fichier in "$SOURCE"/*
do
  # Sécurité : Vérifier si le fichier existe [cite: 54]
  [ -e "$fichier" ] || continue 

  NOM_FICH=$(basename "$fichier")

  # 1. Test de l'extension : Si ce n'est pas un .csv -> Quarantaine [cite: 57, 59]
  if [[ ! "$NOM_FICH" == *.csv ]]; then
    echo "Alerte : $NOM_FICH n'est pas un CSV. Déplacement en quarantaine."
    mv "$fichier" "$QUARANTAINE/"
    continue 
  fi

  # 2. Test de la taille : Si le fichier .csv est vide -> Suppression [cite: 64, 65]
  if [ ! -s "$fichier" ]; then
    echo "Nettoyage : $NOM_FICH est vide. Suppression."
    rm "$fichier"
  else
    echo "Validation : $NOM_FICH est conforme."
  fi
done

echo "Traitement terminé."
