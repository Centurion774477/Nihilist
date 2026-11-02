
open Nihilist

let read_file (file : string) : string =
  match In_channel.with_open_text file In_channel.input_all with
  | contents -> contents
  | exception Sys_error message ->
    Printf.printf "An error occured %s\n" message;
    exit 1

let write_out file data =
  match Out_channel.with_open_gen [Open_append; Open_creat; Open_text] 0o644 file (fun channel ->
    Out_channel.output_string channel data) with
  | () -> ()
  | exception Sys_error message ->
    Printf.printf "An error occured %s\n" message;
    exit 1
  


(* Run nihilist: dune exec nihilist -- compile ../../test.txt *)
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

let tokens = file
  |> read_file
  |> Lexer.tokenize
in

let declarations = Declarations.find_declarations tokens in

let result =
  Parser.parse tokens declarations
  |> Formatter.ast_walker
  |> String.concat "\n"
in

print_string result


