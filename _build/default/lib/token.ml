
type token =
  | Ident of string
  | Bang (* ! *)
  | LParen
  | Dot (* . *)
  | RParen
  | Comma
  | Func
  | Other of string (* Literally ANY other word, symbol, operator, etc. *)

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
  | Other s -> "Other(" ^ s ^ ")"
