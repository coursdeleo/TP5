# TP5 - Surveillance de Zone d'Échange 🛡️

[![Bash Shell](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![System](https://img.shields.io/badge/System-Debian%20/%20Raspberry%20Pi%20OS-A81D33.svg)](https://www.debian.org/)

## 📝 Description du projet
Ce projet, réalisé dans le cadre du **BTS CIEL**, met en place un script "Gardien" pour l'entreprise **GigaFret**. Le système surveille un dossier d'échange, valide les fichiers CSV entrants, gère les utilisateurs système et archive les données de manière sécurisée.

## ⚙️ Fonctionnalités
* **Filtrage automatique** : Déplacement des fichiers intrus (non .csv) en quarantaine et suppression des fichiers vides.
* **Gestion des identités** : Extraction du nom du technicien depuis le contenu du fichier et création automatique du compte utilisateur UNIX s'il n'existe pas.
* **Archivage sécurisé** : Déplacement des fichiers validés dans le répertoire personnel du technicien avec des permissions restreintes (`chmod 600`).

## 📂 Structure du dépôt
| Fichier | Description |
| :--- | :--- |
| `transfert_csv.sh` | Script principal de surveillance et d'archivage intelligent. |
| `generateur_de_fichiers.sh` | Script de test générant des fichiers aux formats variés (température, logs, etc.). |
| `surveillance_nettoyage.sh` | Script dédié au nettoyage initial (quarantaine et suppression). |
| `gestion_techniciens.sh` | Module spécifique pour l'administration des utilisateurs. |

## 🚀 Installation et Utilisation

### 1. Préparation
Clonez le dépôt et rendez les scripts exécutables :
```bash
chmod +x *.sh
