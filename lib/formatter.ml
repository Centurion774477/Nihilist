
open Ast

let rec ast_walker (nodes : node list) : string list =
  (* get arguments as a string from the node list *)
  let format_args args = String.concat ", " (ast_walker args) in
  
  match nodes with
  | [] -> []
  (* bang function call; no arguments *)
  | Call (name, []) :: rest -> (name ^ "()") :: ast_walker rest

  (* normal function call  *)
  | Call (name, args) :: rest ->
    (name ^ "(" ^ format_args args ^ ")") :: ast_walker rest

  (* bang method call *)
  | MethodCall (name, mthd, []) :: rest -> (name ^ "." ^ mthd ^ "()") :: ast_walker rest

  (* normal method call *)
  | MethodCall (name, mthd, args) :: rest ->
    (name ^ "." ^ mthd ^ "(" ^ format_args args ^ ")") :: ast_walker rest

  (* function declaration *)
  | Raw Func :: Raw (Ident name) :: rest -> ("func " ^ name) :: ast_walker rest
  | Raw token :: rest -> (Token.to_source token) :: ast_walker rest
