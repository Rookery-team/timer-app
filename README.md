
# Timer-app  
  
Timer est une application enregistrant le temps de travail d'un utilisateur dans un projet.   
Timer-app englobe les répertoires [timer-back]() et [timer-front]().  
  
* **Interface d'administration** pour gérer les entités (utilisateurs, groupes, projets...)  
* **Interface utilisateur** avec un design moderne  
* **API** contenant des méthodes simples à utiliser  
  
  
## Comment ça fonctionne  
  
1. Timer-app a été optimisé pour une installation via Docker-compose et une configuration via un fichier de configuration (`.env`). Docker-compose va charger la configuration et chercher les images à télécharger dans `docker-compose.yml`.  
2. Si les dossiers `timer-back` et `timer-ui` ne sont pas présent, executer le script `start` présent dans le dossier `bin` (si vous avez un OS Unix-like : `start.sh`, si vous avez Microsoft Windows : `start.bat`). Celui-ci fera les clones des répertoires git dans le répertoire racine de `timer-app`.
3. Le script `build` permet de lancer docker-composer, soit les containers nécesaires pour le fonctionnement de l'application.
4. Des containers seront ensuite créé dont l'ensemble des containers est décrit dans la page de projet [Containers Docker]().
5. Une fois les containers lancés, les différents interfaces seront accessibles depuis les ports 80 (interface utilisateur) et 81 (interface d'administration et API). Phpmyadmin est aussi accessible depuis le port 8000.

## Table des matières
 
- [Installation](#installation)
    - [Via script](#via-script)
    - [Installation manuelle](#installation-manuelle)
- [License](#license)


## Installation

Cette installation a été testé sur un environnement Linux avec le noyau 5.4.

Quelque soit la manière d'installation, il est nécessaire d'installer Docker sur votre machine locale.


### Via script

Trois scripts sont actuellement proposés :
- **start** : télécharge les répertoires du projet tels que `timer-front` et `timer-back`.
- **build** : lance les containers docker.
- **clean** : nettoie ce qui a été fait dans le script *start*.

Quelque soit l'environnement que vous utilisez, les commandes doivent être lancé depuis le répertoire racine de `timer-app`.

### Installation manuelle

*A venir*
