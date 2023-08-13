# PEX-Makefile

## Installation de make

- `sudo apt-get install make`

## Fichier principal

Make fonctionne avec un seul fichier, celui-ci permet de regrouper toutes les commandes utiles du projet.

Le fichier doit être à la racine du projet et porter le nom de **Makefile** (attention, il n'y a pas d'extension).

## Le principe

Vulgairement, Make va permettre de lancer des "commandes shell".

Pour créer la commande `make test` il faut définir la **cible** puis la **commande**

```Makefile
# exemple
<cible>:
	<commande>

# Ma commande Make
test :
	@echo 'Test'
```

!! Par défaut **Make** prompt la commande exécuté, faire commencer la commande par un `@` pour éviter ce comportement.
!! ATTENTION : l'indentation se fait avec une vraie tabulation et non des espaces.

## Faire référence à une ou plusieurs commandes existantes

```Makefile
# exemple
<cible>: <dépendance>
	<commande>

# Commande help
help :
	@echo 'Help'

# Commande test
test :
	@echo 'Test'

# Commande combine qui fait appel à help puis test
combine : help test
```

## On peut mixer la combinaison et l'exécution d'une ou plusieurs commandes

```Makefile
# Commande combine qui fait appel à help puis test puis exécute deux commandes
combineAndExecute : help test
	@echo 'Combine OK'
	@echo 'ADD commande'
```

On peut faire référence à une autre cible entre nos commandes.

```Makefile
# Commande combine qui fait appel à help puis test puis exécute une commande puis appel combine pour finir par exécuter une commande
combineAndExecuteWithCallOtherTarget : help test
	@echo 'Combine OK'
	$(MAKE) combine
	@echo 'ADD commande'
```

## Commande par défaut

Par défaut la commande `make` déclenchera la première commande initialisée dans le fichier.

Il est possible de définir une commande par défaut qui n'est pas forcément la première du fichier.

```Makefile
# Définition de la commande par défaut
.DEFAULT_GOAL := test

# Commande help
help :
	@echo 'Help'

# Commande test, utilisé par défaut
test :
	@echo 'Test'
```

## Les variables

Il est possible de créer des variables pour rendre dynamique notre fichier.

```Makefile
# exemple
NAME = value

# Initialisation de la variable
ECHO = @echo

# Utilisation
dynamicCommand:
	$(ECHO) 'Print d'un texte'
```

!! ATTENTION : le caractère `@` est présent dans la variable, s'il ne l'est pas, que l'on souhaite de pas prompt la commande et que la variable est défini au début de la ligne de commande, il faudra utiliser la syntaxe `@-$(VARIABLE_NAME) ...`.

Le nom d'une commande peut également être contenu dans une variable.

```Makefile
DYNAMIC_COMMAND_NAME = dynamicCommandName

$(DYNAMIC_COMMAND_NAME):
	$(ECHO) 'Print d'un texte d'une commande dynamique'
```

## Les variables spéciales

- `$@` Référence au nom de la cible

    ```Makefile
    $(DYNAMIC_COMMAND_NAME):
    	$(ECHO) 'Exécution de la commande : $@'
    ```

- `$<` Référence au nom de la première dépendance
- `$^` Liste des dépendances
- `$?` Liste des dépendances plus récentes que la cible
- `$*` Référence au nom du fichier, sans son extension

## Lister les fichiers par leurs extensions

Il est possible de lister les fichiers en utilisant une syntaxe particulière.

```Makefile
# Récupération des fichiers .md
SRC_MD = $(wildcard *.md)

listMdFiles:
	$(ECHO) '$(SRC_MD)'
```

## Conditions

Il est possible de créer des conditions dans l'exécution d'une cible.

```Makefile
SYSTEM = Ubuntu

whatIsTheSystem:
ifeq ($(SYSTEM), Ubuntu)
	$(ECHO) 'Le système est Ubuntu'
else
	$(ECHO) 'Le système est $(SYSTEM)'
endif
```

## Et bien plus encore

Voir la [documentation officiel](https://www.gnu.org/software/make/manual/make.html)
