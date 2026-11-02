
open Token

type node =
  | Raw of token
  | Call of string * node list
  | MethodCall of string * string * node list