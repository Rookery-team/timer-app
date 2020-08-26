


# Timer-app  

<img src="http://lorempixel.com/615/913/" align="right"
     alt="Timer-app logo" width="120" height="178">  

Timer est une application enregistrant le temps de travail d'un utilisateur dans un projet.   
Timer-app englobe les répertoires [timer-back]() et [timer-front]().  
  
* **Interface d'administration** pour gérer les entités (utilisateurs, groupes, projets...)  
* **Interface utilisateur** avec un design moderne  
* **API** contenant des méthodes simples à utiliser  
  
  
## Comment ça fonctionne  
  
1. L'application a été optimisé pour être installé via GNU Make et Docker compose. Un fichier de configuration `.env` sera lu par ces derniers afin d'avoir un fonctionnement optimal (cf [Configuration](#Configuration)). A travers la commande `make`, une panoplie de commandes est proposée permettant de manipuler l'ensemble du projet. La commande `make run` étant la commande qui permet l'installation et la mise en service de l'application (cf [Installation par étape](#Installation-par-étape)).
2. Une fois l'installation lancée, les répertoires `timer-back` et `timer-front` seront clonés et les containers  Docker faisant fonctionner ces répertoires seront construites. Ces containers auront, pour certains, des commandes qui seront lancées dans le but d'installer les dépendences nécessaires pour le projet et de construire les fichiers publiques (ici, dans le répertoire `public` ou `dist`).
3. Après que l'installation soit finie, les containers sont mis en service. Si aucun problème n'a été rencontré, l'application sera accessible à ces adresses :
	- [http://localhost:8000](http://localhost:8000)
	- [http://localhost:8001](http://localhost:8001)
	- [http://localhost:8080](http://localhost:8080)

## Table des matières
 
- [Installation](#Installation)
    - [Pré-requis](#Pre-requis)
    - [Installation tout-en-un](#Installation-tout-en-un)
    - [Installation par étape](#Installation-par-étape)
    - [Lancer l'application](#Lancer-lapplication)
- [Configuration](#Configuration)
- [Tests](#Tests)
- [Contribuer](#Contribuer)
- [Signaler un bug](#Signaler-un-bug)
- [License](#License)


## Installation

L'installation a été testé sur un environnement Linux avec le noyau 5.4 et macOS sous la version Catalina. 

### Pré-requis

Vous retrouverez ici les outils dont vous aurez besoin pour installer le projet.

* git
    * __Windows__ : [Voir Git4Windows](https://gitforwindows.org/)
* make
    * __Windows__ : [Solutions pour installer GNU Make sur Windows](https://stackoverflow.com/a/32127632)
* docker-compose
    * __Linux/Mac/Windows 10 Professionnal__ : [Installer Docker](https://www.docker.com/get-started)
    * __Windows 10__ : [Installer Docker Toolbox](https://github.com/docker/toolbox/releases)
    
Pour vérifier les pré-requis, vous pouvez lancer la commande suivante :
```bash
for cmd in make docker-compose git; do which $cmd > /dev/null || echo "Veuillez installer $cmd"; done
```

### Installation tout-en-un

```bash
git clone https://github.com/ipssi-timer/timer-app.git timehub
make run
```

Si vous une erreur survient après l'execution de la commande, suivez [l'installation par étape](#Installation-par-étape) (section ci-dessous) afin de localiser le problème. Une fois le problème localisé, consulter la section [Signaler un bug](#signaler-un-bug).


### Installation par étape

* [Clonage des répertoires](#Clonage-des-repertoires)
* [Copie du fichier de configuration](#Copie-du-fichier-de-configuration)
* [Construction de l'application](#Construction-de-lapplication)
* [Installation des dépendences](#Installation-des-dépendences)
* [Migrations de la base de données](#Migrations-de-la-base-de-données)
* [Jeux de données](#Jeux-de-données)

#### Clonage des répertoires

```bash
make clone
```

Pour une installation manuelle sans la commande `make`, vous pouvez utiliser les commandes suivantes :


```bash
git clone https://github.com/ipssi-timer/timer-front.git
git clone https://github.com/ipssi-timer/timer-back.git
```

#### Copie du fichier de configuration

```bash
cp -f .env timer-back/.env
```

#### Construction de l'application

```bash
make build
```

Pour une installation manuelle sans la commande `make`, vous pouvez utiliser les commandes suivantes :


```bash
docker-compose build --pull
```

#### Installation des dépendences

```bash
make dependencies
```

#### Migrations de la base de données

```bash
make migrations
```

#### Jeux de données

```bash
make fixtures
```

### Lancer l'application

```bash
make serve
```

## Configuration

Le fichier de configuration `.env` doit se situer dans le répertoire racine de l'application. Pour l'obtenir, vous devez copier le fichier `.env.example` en `.env`.

#### Environnement 

```
# Utilisateur (et son groupe) pouvant manipuler les fichiers
ENV_USER=
ENV_USER_GROUP=
```

#### Git

```
# Permet le clonage HTTPS
GIT_USER=
GIT_PASSWORD=
```

#### Symfony

```
APP_ENV=dev
APP_SECRET=c74b32b60a6b7a67e116cc9ad161e256

# Ne pas toucher (sauf en cas de nécessité)
MYSQL_HOST=timer-database
MYSQL_PORT=3306
MYSQL_DATABASE=ipssi-timer
MYSQL_USER=ipssi-timer-user
MYSQL_PASSWORD=s3cr3t
MYSQL_ROOT_PASSWORD=r00t_s3cr3t

DATABASE_URL=mariadb://${MYSQL_USER}:${MYSQL_PASSWORD}@${MYSQL_HOST}:3306/${MYSQL_DATABASE}
```

#### Docker

```
# Evite les erreurs de type "timeout" avec composer
COMPOSER_MEMORY_LIMIT=-1
```

## Tests

*A venir*

## Contribuer

*A venir*

## Signaler un bug

Vous pouvez signaler votre bug en [ouvrant une issue]().

## Licence

*A venir*
