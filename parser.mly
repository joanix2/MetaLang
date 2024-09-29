%{
(* Importer le module AST pour construire les structures syntaxiques *)
open Ast
open Tokens
%}

%token CONST PERMISSIONS MODEL INIT
%token <string> IDENT
%token <string> STRING
%token <int> NUMBER
%token <string> HEX_NUMBER
%token LBRACE RBRACE LBRACKET RBRACKET LPAREN RPAREN COLON SEMICOLON EQUAL EQEQ COMMA
%token EOF

%start program
%type <Ast.program> program

%%

program:
  | decl_list EOF { $1 }

decl_list:
  | decl { [$1] }
  | decl_list decl { $1 @ [$2] }

decl:
  | CONST LBRACE const_decls RBRACE { Const ($3) }
  | PERMISSIONS LBRACE permissions_decls RBRACE { Permissions ($3) }
  | MODEL LBRACE model_decls RBRACE { Model ($3) }
  | INIT LBRACE init_decls RBRACE { Init ($3) }

const_decls:
  | IDENT EQUAL STRING SEMICOLON { [{ const_name = $1; const_value = $3 }] }
  | const_decls IDENT EQUAL STRING SEMICOLON { $1 @ [{ const_name = $2; const_value = $4 }] }

permissions_decls:
  | IDENT COLON HEX_NUMBER SEMICOLON { [{ name = $1; code = $3 }] }
  | permissions_decls IDENT COLON HEX_NUMBER SEMICOLON { $1 @ [{ name = $2; code = $4 }] }

model_decls:
  | IDENT COLON STRING SEMICOLON { [{ name = $1; typ = $3 }] }
  | model_decls IDENT COLON STRING SEMICOLON { $1 @ [{ name = $2; typ = $4 }] }

init_decls:
  | IDENT EQUAL IDENT SEMICOLON { [{ init_name = $1; init_value = $3 }] }
  | init_decls IDENT EQUAL IDENT SEMICOLON { $1 @ [{ init_name = $2; init_value = $4 }] }
