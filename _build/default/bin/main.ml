
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
  let tokens = Sys.argv.(1)
  |> read_file
  |> Lexer.tokenize
  in
  List.iter (fun token -> print_endline (Token.to_string token)) tokens