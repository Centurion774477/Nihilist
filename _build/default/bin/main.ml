
open Nihilist

let read_file (file : string) : string =
  match In_channel.with_open_text file In_channel.input_all with
  | contents -> contents
  | exception Sys_error message ->
    Printf.printf "An error occured %s\n" message;
    exit 1

(* Run nihilist: dune exec nihilist -- ../../test.txt *)

let () =
  if Array.length Sys.argv < 2 then begin
    print_endline "Please provide a file to process.";
    print_endline "Usage: nihilist <file>";
    exit 1
  end;

  let command = Sys.argv.(1) in

  (* print my writing on nihilism *)
  if command = "nihilism" then begin
    read_file "nihilism.txt"
    |> print_endline;
    exit 0
  end;

  let file = 
    try Sys.argv.(2)
    with Invalid_argument _ ->
    print_endline "Please provide a file to process.";
    exit 1
  in

  (* debug tokens *)
  let tokens = file
  |> read_file
  |> Lexer.tokenize
  in
  List.iter (fun token -> print_endline (Token.to_string token)) tokens;

  (* debug declarations *)
  let declarations = tokens
  |> Declarations.find_declarations
  in

  print_endline "declarations:";
  List.iter (fun declaration -> print_endline declaration) declarations

