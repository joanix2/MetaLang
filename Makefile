# Fichiers sources
LEXER=lexer
PARSER=parser
TOKENS=tokens
AST=ast
MAIN=main

# Programme final
EXEC=lexer_program

# Compilateur OCaml
OCAMLC=ocamlc

# Cibles par défaut
all: $(EXEC)

# Compiler l'AST
$(AST).cmo: $(AST).ml
	$(OCAMLC) -c $(AST).ml

# Compiler tokens
$(TOKENS).cmo: $(TOKENS).ml $(TOKENS).mli
	$(OCAMLC) -c $(TOKENS).mli
	$(OCAMLC) -c $(TOKENS).ml	

# Générer parser.ml et parser.mli à partir de parser.mly
$(PARSER).ml $(PARSER).mli: $(PARSER).mly $(TOKENS).cmo
	menhir --ocamlc $(OCAMLC) --infer $(PARSER).mly

# Compiler le parser
$(PARSER).cmo: $(PARSER).ml $(PARSER).mli $(AST).cmo
	$(OCAMLC) -c $(PARSER).mli
	$(OCAMLC) -c $(PARSER).ml

# Générer lexer.ml à partir de lexer.mll
$(LEXER).ml: $(LEXER).mll $(PARSER).ml
	ocamllex $(LEXER).mll

# Compiler le lexer
$(LEXER).cmo: $(LEXER).ml $(TOKENS).cmo $(PARSER).cmo
	$(OCAMLC) -c $(LEXER).ml

# Compiler le main
$(MAIN).cmo: $(MAIN).ml $(LEXER).cmo $(PARSER).cmo $(AST).cmo $(TOKENS).cmo
	$(OCAMLC) -c $(MAIN).ml

# Lier et créer l'exécutable
$(EXEC): $(AST).cmo $(PARSER).cmo $(LEXER).cmo $(MAIN).cmo $(TOKENS).cmo
	$(OCAMLC) -o $(EXEC) $(AST).cmo $(PARSER).cmo $(LEXER).cmo $(MAIN).cmo $(TOKENS).cmo

# Nettoyer les fichiers générés
clean:
	rm -f *.cmo *.cmi $(LEXER).ml $(PARSER).ml $(PARSER).mli $(EXEC)
