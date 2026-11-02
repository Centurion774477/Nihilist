
open Token
open Ast

let rec collect_args tokens args =
  match tokens with
  | [] -> (List.rev args, [])
  | Other "\n" :: rest -> (List.rev args, rest)
  | token :: rest -> collect_args rest (Raw token :: args)

let rec parse tokens declarations =
  match tokens with
  | [] -> []
  | Ident var :: Dot :: Ident mthd :: Bang :: rest ->
    MethodCall (var, mthd, []) :: parse rest declarations
  | Ident name :: rest when List.mem name declarations ->
    let (args, remaining) = collect_args rest [] in
    Call (name, args) :: parse remaining declarations
  | Ident var :: Dot :: Ident mthd :: rest ->
    let (args, remaining) = collect_args rest [] in
    MethodCall (var, mthd, args) :: parse remaining declarations
  | Ident name :: Bang :: rest ->
    Call (name, []) :: parse rest declarations
  | token :: rest -> Raw token :: parse rest declarations
  
    