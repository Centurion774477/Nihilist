
type token =
  | Ident of string
  | Bang (* ! *)
  | LParen
  | Dot (* . *)
  | RParen
  | Comma
  | Func
  | StringLiteral of string
  | Other of string (* Literally ANY other value, symbol, operator, etc. *)

(* Basically only for debugging tokens *)
let to_string token =
  match token with
  | Bang -> "Bang"
  | LParen -> "LParen"
  | RParen -> "RParen"
  | Dot -> "Dot"
  | Comma -> "Comma"
  | Ident s -> "Ident(" ^ s ^ ")"
  | Func -> "Function declaration"
  | StringLiteral s -> "Literal(" ^ s ^ ")"
  | Other s -> "Other(" ^ s ^ ")"
