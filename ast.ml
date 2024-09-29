(* ast.ml *)

type const_decl = {
  name: string;
  value: string;
}

type permissions_decl = {
  name: string;
  code: string;
}

type model_decl = {
  name: string;
  typ: string;
}

type init_decl = {
  name: string;
  value: string;
}

(* Déclaration principale pour contenir chaque type de déclaration *)
type decl =
  | Const of const_decl list
  | Permissions of permissions_decl list
  | Model of model_decl list
  | Init of init_decl list

(* Type pour l'ensemble du programme *)
type program = decl list
