
open Nihilist

let read_file (file : string) : string =
  match In_channel.with_open_text file In_channel.input_all with
  | contents -> contents
  | exception Sys_error message ->
      Printf.printf "An error occured %s\n" message;
      exit 1

let write_out data file =
  match Out_channel.with_open_gen [Open_creat; Open_text] 0o644 file (fun channel ->
    Out_channel.output_string channel data) with
  | () -> ()
  | exception Sys_error message ->
      Printf.printf "An error occured %s\n" message;
      exit 1
  


(* Run nihilist: dune exec nihilist -- compile ../../test.txt *)
let () =
  if Array.length Sys.argv < 2 then begin
    (* help message *)
    {|
    Hey! Welcome to Nihilist!
    In short, Nihilist is a preprocessor for KrabbaScript
    that lets you use much more relaxed syntax than KrabbaScript.

    The main feature is omitting parens with functions:

    `add a, b` compiles to something like `add(a, b)`


    Here's a list of the commands:

    nihilism -> view my writing on Nihilism

    * you probably want this: *
    compile <file>   -> compile a nihilist file to KrabbaScript
    | this will output to <file>.ks by default — you can specify an output file by passing it in:
    | compile finland.nihilist finland.ks

    |} |> print_endline;
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
    |> String.concat ""
  in

  print_string result;

  (* get output file from either the user or from the existing file *)
  let replace_ext name ext =
  match String.rindex_opt name '.' with
  | Some i -> String.sub name 0 i ^ ext
  | None -> name ^ ext
  in

  let output_file =
    try Sys.argv.(3)
    with Invalid_argument _ -> replace_ext file ".ks"
  in

  print_endline "Output file:";
  print_endline output_file

  (* write_out result output_file *)

