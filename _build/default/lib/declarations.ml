
open Token

(*
This finds function declarations from tokens
so they can be used later on in the parser.
*)

let rec find_declarations tokens =
  match tokens with
  | [] -> []
  | Func :: Other " " :: Ident name :: rest -> name :: find_declarations rest
  | _ :: rest -> find_declarations rest
