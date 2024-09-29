# Makefile

# Fichiers sources
LEXER=lexer
PARSER=parser
AST=ast
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

# Générer parser.ml et parser.mli à partir de parser.mly
$(PARSER).ml $(PARSER).mli: $(PARSER).mly
	menhir --ocamlc $(OCAMLC) --infer $(PARSER).mly

# Compiler les fichiers .mli et .ml
$(AST).cmo: $(AST).ml
	$(OCAMLC) -c $(AST).ml

$(PARSER).cmo: $(PARSER).ml $(PARSER).mli $(AST).cmo
	$(OCAMLC) -c $(PARSER).mli
	$(OCAMLC) -c $(PARSER).ml

$(LEXER).cmo: $(LEXER).ml $(PARSER).cmo
	$(OCAMLC) -c $(LEXER).ml

$(MAIN).cmo: $(MAIN).ml $(LEXER).cmo $(PARSER).cmo $(AST).cmo
	$(OCAMLC) -c $(MAIN).ml

# Lier et créer l'exécutable
$(EXEC): $(AST).cmo $(PARSER).cmo $(LEXER).cmo $(MAIN).cmo
	$(OCAMLC) -o $(EXEC) $(AST).cmo $(PARSER).cmo $(LEXER).cmo $(MAIN).cmo

# Nettoyer les fichiers générés
clean:
	rm -f *.cmo *.cmi $(LEXER).ml $(PARSER).ml $(PARSER).mli $(EXEC)
