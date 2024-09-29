%{
(* Importer le module AST pour construire les structures syntaxiques *)
open Ast
%}

%token CONST PERMISSIONS MODEL INIT
%token IDENT STRING NUMBER HEX_NUMBER
%token LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN COLON SEMICOLON EQUAL EQEQ COMMA
%token EOF

%start program
%type <Ast.program> program

%%

(* Grammaire du langage *)

program:
  | decl_list EOF { $1 } (* Un programme est une liste de déclarations *)

decl_list:
  | decl { [$1] }
  | decl_list decl { $2 :: $1 }

decl:
  | CONST LBRACE const_decls RBRACE { Const ($3) }
  | PERMISSIONS LBRACE permissions_decls RBRACE { Permissions ($3) }
  | MODEL LBRACE model_decls RBRACE { Model ($3) }
  | INIT LBRACE init_decls RBRACE { Init ($3) }

const_decls:
  | IDENT EQUAL STRING SEMICOLON { [{ name = $1; value = $3 }] }
  | const_decls IDENT EQUAL STRING SEMICOLON { { name = $2; value = $4 } :: $1 }

permissions_decls:
  | IDENT COLON HEX_NUMBER SEMICOLON { [{ name = $1; code = $3 }] }
  | permissions_decls IDENT COLON HEX_NUMBER SEMICOLON { { name = $2; code = $4 } :: $1 }

model_decls:
  | IDENT COLON STRING SEMICOLON { [{ name = $1; typ = $3 }] }
  | model_decls IDENT COLON STRING SEMICOLON { { name = $2; typ = $4 } :: $1 }

init_decls:
  | IDENT EQUAL IDENT SEMICOLON { [{ name = $1; value = $3 }] }
  | init_decls IDENT EQUAL IDENT SEMICOLON { { name = $2; value = $4 } :: $1 }
