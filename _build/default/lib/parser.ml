
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
  (* Method call with bang — string.downcase! *)
  | Ident var :: Dot :: Ident mthd :: Bang :: rest ->
    MethodCall (var, mthd, []) :: parse rest declarations

  (* Function call with args *)
  | Ident name :: rest when List.mem name declarations ->
    let (args, remaining) = collect_args rest [] in
    Call (name, args) :: parse remaining declarations

  (* Method call with args — string.contains "substring" *)
  | Ident var :: Dot :: Ident mthd :: rest ->
    let (args, remaining) = collect_args rest [] in
    MethodCall (var, mthd, args) :: parse remaining declarations

  (* function call with bang — loveFinland! *)
  | Ident name :: Bang :: rest ->
    Call (name, []) :: parse rest declarations

  (* function declarations *)
  | Func :: Other " " :: Ident name :: rest -> Raw Func :: Raw (Other " ") :: Raw (Ident name) :: parse rest declarations
    
  (* catchall *)
  | token :: rest -> Raw token :: parse rest declarations
  
    