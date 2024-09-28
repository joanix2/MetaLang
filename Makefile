# Makefile

# Fichiers sources
LEXER=lexer
TOKENS=tokens
MAIN=main

# Programme final
EXEC=lexer_program

# Compilateur OCaml
OCAMLC=ocamlc

# Cibles par défaut
all: $(EXEC)

# Générer lexer.ml à partir de lexer.mll
$(LEXER).ml: $(LEXER).mll
	ocamllex $(LEXER).mll

# Compiler les fichiers .mli et .ml
$(TOKENS).cmo: $(TOKENS).ml $(TOKENS).mli
	$(OCAMLC) -c $(TOKENS).mli
	$(OCAMLC) -c $(TOKENS).ml

$(LEXER).cmo: $(LEXER).ml $(TOKENS).cmo
	$(OCAMLC) -c $(LEXER).ml

$(MAIN).cmo: $(MAIN).ml $(TOKENS).cmo $(LEXER).cmo
	$(OCAMLC) -c $(MAIN).ml

# Lier et créer l'exécutable
$(EXEC): $(TOKENS).cmo $(LEXER).cmo $(MAIN).cmo
	$(OCAMLC) -o $(EXEC) $(TOKENS).cmo $(LEXER).cmo $(MAIN).cmo

# Nettoyer les fichiers générés
clean:
	rm -f *.cmo *.cmi $(LEXER).ml $(EXEC)