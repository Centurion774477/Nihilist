
open Nihilist

let read_file (file : string) : string =
  match In_channel.with_open_text file In_channel.input_all with
  | contents -> contents
  | exception Sys_error message ->
      Printf.printf "An error occured %s\n" message;
      exit 1

let write_out data file =
  try
    Out_channel.with_open_text file (fun channel ->
      Out_channel.output_string channel data)
  with Sys_error message ->
    Printf.printf "An error occurred %s\n" message;
    exit 1
  

(* 
tokenize, 
find declarations,
parse, and generate code.
*)
let compile file output =
  let tokens = file
    |> read_file
    |> Lexer.tokenize
  in

  print_endline "Tokens:";

  tokens
  |> List.map Token.to_string
  |> List.iter print_endline;

  let declarations = Declarations.find_declarations tokens in
    print_endline "Declarations:"; List.iter print_endline declarations;

    Parser.parse tokens declarations
    |> Formatter.ast_walker
    |> String.concat ""

  


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
    compile <file> -> compile a nihilist file to KrabbaScript
    | this will output to <file>.ks by default — you can specify an output file by passing it in:
    | compile finland.nihilist finland.ks

    Or, you can just omit any sort of command and it will default to `compile`.
    |} |> print_endline;
    exit 1
  end;

  let is_filename s = String.contains s '.' in

  let command = Sys.argv.(1) in

  let file =
    if is_filename command then command
    else
      try Sys.argv.(2)
      with Invalid_argument _ ->
        print_endline "Please provide a file to process.";
        exit 1
  in

  (* get output file from either the user or from the existing file *)
  let replace_ext name ext =
    match String.rindex_opt name '.' with
    | Some integer -> String.sub name 0 integer ^ ext
    | None -> name ^ ext
  in

  let output_file =
    if is_filename command then
      try Sys.argv.(2)
      with Invalid_argument _ -> replace_ext file ".ks"
    else
      try Sys.argv.(3)
      with Invalid_argument _ -> replace_ext file ".ks"
  in

  (* 
    if no command was passed then default to compiling 
    
    nihilist file.nihilist output.ks

    command would become 'file.nihilist', which is how we tell if the user omitted the command.
  *)
  if command |> is_filename || command = "compile" then begin
    let formatted_lines = compile file output_file in
    write_out formatted_lines output_file
  end;

  (* 
  parse commands normally
  — transform this into a `match .. with` block when more commands are added
  *)

  (* print my writing on nihilism *)
  if command = "nihilism" then begin
    read_file "nihilism.txt"
    |> print_endline;
    exit 0
  end;

