{
(* lexer.ml avec gestion des erreurs incluant la ligne et la colonne *)
open Parser
open Lexing
exception Error of string

(* Fonction pour obtenir la position actuelle du lexer (ligne et colonne) *)
let print_position lexbuf =
  let pos = lexbuf.lex_curr_p in
  Printf.sprintf "line %d, character %d"
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

(* Fonction pour mettre à jour la position du lexer lors d'un saut de ligne *)
let newline lexbuf =
  let pos = lexbuf.lex_curr_p in
  lexbuf.lex_curr_p <- { pos with pos_lnum = pos.pos_lnum + 1; pos_bol = pos.pos_cnum }
}


rule token = parse
  | [' ' '\t']                { token lexbuf }  (* Ignorer les espaces blancs *)
  | "\n"                      { newline lexbuf; token lexbuf }  (* Gérer les sauts de ligne *)
  | "//" [^'\n']* '\n'        { newline lexbuf; token lexbuf }  (* Ignorer les commentaires *)
  | "const"                   { CONST }
  | "permissions"             { PERMISSIONS }
  | "model"                   { MODEL }
  | "init"                    { INIT }
  | "=="                      { EQEQ }
  | "="                       { EQUAL }
  | ":"                       { COLON }
  | ";"                       { SEMICOLON }
  | ","                       { COMMA }
  | "{"                       { LBRACE }
  | "}"                       { RBRACE }
  | "["                       { LBRACKET }
  | "]"                       { RBRACKET }
  | "("                       { LPAREN }
  | ")"                       { RPAREN }
  | "0x" ['0'-'9''A'-'F''a'-'f']+ as hex_num { HEX_NUMBER hex_num }
  | ['0'-'9']+ as num         { NUMBER (int_of_string num) }
  | "\"" [^'"']* "\"" as str   { STRING (String.sub str 1 (String.length str - 2)) }
  | ['A'-'Z''a'-'z''_']['A'-'Z''a'-'z''0'-'9''_''\'''.']* as id { IDENT id }
  | eof                       { EOF }
  | _ as char                 {
      let pos = print_position lexbuf in
      raise (Error (Printf.sprintf "Unknown character '%c' at %s" char pos))
    }
{
(* Fonction principale du lexer *)
let lexer lexbuf = token lexbuf
}
