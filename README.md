Exemple d'utilisation
---------------------

### Compilation
```$ make```

### Exection
```$ make run```

### Nettoyage des binaires
```$ make clean```

### Nettoyage des objets seuls
```$ make clean-objects```

### Compilation de cible pour debug
```$ CFLAGS=-g make```

### Compilation de cible avec Clang plutot que GCC
```$ CC=clang make```

### Toujours utiliser Clang
dans un ficher de conf tel que .bashrc
```export CC=clang```

dans un terminal
```$ make```
