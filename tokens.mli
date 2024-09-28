(* tokens.mli *)

type token =
  (* Mots-clés *)
  | CONST
  | PERMISSIONS
  | MODEL
  | INIT

  (* Identificateurs *)
  | IDENT of string

  (* Symboles *)
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

  (* Littéraux *)
  | STRING of string
  | HEX_NUMBER of string
  | NUMBER of int

  (* Fin de fichier *)
  | EOF
