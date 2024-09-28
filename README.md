### Compilation et Exécution

Pour compiler et exécuter ces fichiers, suivez ces étapes :

1. **Générer le fichier `lexer.ml`** :

```bash
ocamllex lexer.mll
```

2. **Compiler les fichiers** :

Pour compiler tout, exécutez simplement :

```bash
make
```

Pour nettoyer les fichiers intermédiaires (comme `.cmo`, `.cmi`), exécutez :

```bash
make clean
```

3. **Lier les fichiers et exécuter** :

```bash
ocamlc -o lexer_program tokens.cmo lexer.cmo main.cmo
./lexer_program
```
