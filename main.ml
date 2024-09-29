(* main.ml *)
open Lexing
open Tokens
open Lexer
open Printf

(* Fonction pour lire le contenu d'un fichier *)
let read_file filename =
  let chan = open_in filename in
  let len = in_channel_length chan in
  let content = really_input_string chan len in
  close_in chan;
  content

(* Fonction pour afficher les tokens un par un *)
let rec print_tokens lexbuf =
  match lexer lexbuf with
  | EOF -> print_endline "End of File"
  | token ->
      Printf.printf "Token: %s\n" (
        match token with
        | CONST -> "CONST"
        | PERMISSIONS -> "PERMISSIONS"
        | MODEL -> "MODEL"
        | INIT -> "INIT"
        | IDENT id -> Printf.sprintf "IDENT(%s)" id
        | STRING s -> Printf.sprintf "STRING(%s)" s
        | HEX_NUMBER h -> Printf.sprintf "HEX_NUMBER(%s)" h
        | NUMBER n -> Printf.sprintf "NUMBER(%d)" n
        | LBRACE -> "LBRACE"
        | RBRACE -> "RBRACE"
        | LBRACKET -> "LBRACKET"
        | RBRACKET -> "RBRACKET"
        | LPAREN -> "LPAREN"
        | RPAREN -> "RPAREN"
        | COMMA -> "COMMA"
        | COLON -> "COLON"
        | SEMICOLON -> "SEMICOLON"
        | EQUAL -> "EQUAL"
        | EQEQ -> "EQEQ"
        | _ -> "UNKNOWN"
      );
      print_tokens lexbuf

(* Fonction pour lire le fichier source et gérer les erreurs de parsing *)
let parse_with_error lexbuf =
  try Parser.program Lexer.lexer lexbuf
  with
  | Parser.Error ->
    let pos = lexbuf.lex_curr_p in
    Printf.eprintf "Syntax error at line %d, character %d\n"
      pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1);
    exit (-1)

(* Fonction principale *)
let () =
  if Array.length Sys.argv < 2 then
    Printf.printf "Usage: %s <filename>\n" Sys.argv.(0)
  else
    let filename = Sys.argv.(1) in
    let input = read_file filename in
    let lexbuf = from_string input in
    
    (* Si vous voulez afficher les tokens *)
    (* print_tokens lexbuf; *)

    (* Si vous voulez parser et afficher le succès *)
    let ast = parse_with_error lexbuf in
    Printf.printf "Parsed successfully.\n"
