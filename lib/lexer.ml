
open Token

let tokenize (source : string) : token list =
  let index = ref 0 in
  let tokens = ref [] in

  let peek () =
    String.get source !index
  in

  let advance () =
    index := !index + 1
  in

  let emit token =
    tokens := token :: !tokens;
    advance ()
  in

  (* emit a token without advancing *)
  let only_emit token = tokens := token :: !tokens; in

  let is_ident_char c = match c with
  | 'a'..'z' | 'A'..'Z' | '0'..'9' | '_' -> true
  | _ -> false
in

  while !index < String.length source do
    match peek () with
    | '!' -> emit Bang
    | '(' -> emit LParen
    | ')' -> emit RParen
    | '.' -> emit Dot
    | ',' -> emit Comma
    | 'a'..'z' | 'A'..'Z' | '_' ->
      (* consume all characters to construct a string *)
      let buf = Buffer.create 16 in
      while is_ident_char (peek ()) do
        Buffer.add_char buf (peek ());
        advance ()
      done;

      only_emit (Token.Ident (Buffer.contents buf))
      
    | c   -> emit (Token.Other (String.make 1 c))
  done;

  List.rev !tokens