#----------#
# Makefile #
#----------#

# Petit tuto des familles: https://gl.developpez.com/tutoriel/outil/makefile/

## Info:

# Setter une variable :
# VAR = value
# Ajouter a une variable :
# VAR += value
# Setter une variable si elle n'est pas deja settee :
# VAR ?= value
#
# Variables speciales importantes :
# $@ la cible
# $< le premier prerequise
# $^ tout les prerequise
#
# Creer une target :
# TARGET: PREREQUISE
# <tab>ACTIONS



## Definition de variables :

# Nom de notre executable
BIN?=main

# Nom du compilateur
CC?=gcc

# Type d'extensions (.c, .cpp, .cc, etc...)
EXT?=c

# Liaison avec des bibliotheques (math, pthread, etd...)
LINKS?=

## Generation de valeurs a partir du repertoir courant
SRCS=$(shell find . -name "*."$(EXT))
DIRS=$(shell find ./* -type d)
OBJS=$(patsubst %.$(EXT),%.o,$(SRCS))
INCS=$(addprefix -I, $(DIRS))

# Set des flags de compilation
CFLAGS+=-std=c99 -Wall $(INCS)

# Set des flags de liaison
LDFLAGS+=$(addprefix -l, $(LINKS))

# Regles de non interferences
.PHONY: all run clean

# Cibles principale: On clean, puis on cree le binaire principale
all: clean $(BIN)

# Compilation de toute les sources
$(EXT).o: $(SRCS)
	$(CC) $(CFLAGS) -c $^

# Compilation de la cible principale, apres avoir compile toute les sources
$(BIN): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(shell find . -name $(notdir "*.o")) $(LDFLAGS)


# Execution de la cible principale
run: all
	./$(BIN)

# Nettoyage de tout les fichiers objet (finissant par .o)
clean-objects:
	-$(addprefix rm -v , $(addsuffix ; , $(shell find . -type f -name $(notdir "*.o"))))

# Nettoyage du binaire
clean: clean-objects
	-$(addprefix rm -v , $(addsuffix ; , $(shell find . -type f -executable -name $(BIN))))


## Gratuit en plus, si installe :

# Test de la syntax avec CPP check
static-check: $(BIN)
	cppcheck --enable=all --std=c99 $^

# Test de la memoire avec valgrind
mem-check: $(BIN)
	valgrind --leak-check=full ./$^
