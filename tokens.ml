(* tokens.ml *)

type token =
  | CONST
  | PERMISSIONS
  | MODEL
  | INIT
  | IDENT of string
  | LBRACE        (* { *)
  | RBRACE        (* } *)
  | LBRACKET      (* [ *)
  | RBRACKET      (* ] *)
  | LPAREN        (* ( *)
  | RPAREN        (* ) *)
  | COMMA         (* , *)
  | COLON         (* : *)
  | SEMICOLON     (* ; *)
  | EQUAL         (* = *)
  | EQEQ          (* == *)
  | STRING of string
  | HEX_NUMBER of string
  | NUMBER of int
  | EOF
