#!/bin/bash
# Nom: transfert_csv.sh
# Description: Scan, filtrage et archivage sécurisé dans le home des techniciens

SOURCE="./tmp/transfert"
QUARANTAINE="./tmp/quarantaine"

# 1. Vérification des dossiers de base [cite: 42, 43, 46]
mkdir -p "$SOURCE" "$QUARANTAINE"

for fichier in "$SOURCE"/*
do
    [ -e "$fichier" ] || continue
    NOM_FICH=$(basename "$fichier")

    # 2. Filtrage (Nettoyage et Quarantaine) [cite: 28, 29]
    if [[ ! "$NOM_FICH" == *.csv ]]; then
        mv "$fichier" "$QUARANTAINE/"
        continue
    fi

    if [ ! -s "$fichier" ]; then
        rm "$fichier"
        continue
    fi

    # 3. Traitement Intelligent [cite: 74, 75, 76]
    # Extraction du nom (2ème colonne, ligne 1) et passage en minuscules [cite: 87]
    NOM_TECH=$(head -n 1 "$fichier" | cut -d';' -f2 | tr '[:upper:]' '[:lower:]')

    if [ -n "$NOM_TECH" ]; then
        # Création de l'utilisateur s'il n'existe pas [cite: 76, 85]
        if ! id "$NOM_TECH" &>/dev/null; then
            sudo useradd -m "$NOM_TECH"
        fi

        # 4. Archivage Sécurisé [cite: 78, 79]
        CIBLE="/home/$NOM_TECH/Commandes"
        sudo mkdir -p "$CIBLE"
        
        # Déplacement et droits 
        sudo mv "$fichier" "$CIBLE/"
        sudo chmod 600 "$CIBLE/$NOM_FICH"
        sudo chown "$NOM_TECH":"$NOM_TECH" "$CIBLE/$NOM_FICH"
        
        echo "Fichier $NOM_FICH archivé pour $NOM_TECH."
    fi
done
