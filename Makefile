# Variables
ECHO = @echo
DYNAMIC_COMMAND_NAME = dynamicCommandName
SRC_MD = $(wildcard *.md)
SYSTEM = Ubuntu

# Commande par défaut
.DEFAULT_GOAL := test

# Commande help
help :
	@echo 'Help'

# Commande test
test :
	@echo 'Test'

# Commande combine qui fait appel à help puis test
combine : help test

# Commande combine qui fait appel à help puis test puis exécute deux commandes
combineAndExecute : help test
	@echo 'Combine OK'
	@echo 'ADD commande'

# Commande combine qui fait appel à help puis test puis exécute une commande puis appel combine pour finir par exécuter une commande
combineAndExecuteWithCallOtherTarget : help test
	@echo 'Combine OK'
	$(MAKE) combine
	@echo 'ADD commande'

# Commande dynamique
dynamicCommand:
	$(ECHO) 'Print d'un texte'

# Commande avec un nom dynamique
$(DYNAMIC_COMMAND_NAME):
	$(ECHO) 'Print d'un texte d'une commande dynamique'
	$(ECHO) 'Exécution de la commande : $@'

# Lister tous les fichiers .md
listMdFiles:
	$(ECHO) '$(SRC_MD)'

# Utilisation d'une condition
whatIsTheSystem:
ifeq ($(SYSTEM), Ubuntu)
	$(ECHO) 'Le système est Ubuntu'
else
	$(ECHO) 'Le système est $(SYSTEM)'
endif
