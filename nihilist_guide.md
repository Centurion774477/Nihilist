
# Introduction

Hey! This guide explains how to navigate Nihilist's codebase.

This is primarily meant for people trying to contribute, fork, or otherwise work with the code of Nihilist.
If you're just looking for a description of Nihilist, then you should be reading the readme instead.

# Nihilist

First, I have to give some context on what Nihilist is from a code perspective, not from a philosophy perspective.

Nihilist takes your "wrong" code and turns it into "right" code
— it will lex, parse (generate an Abstract Syntax Tree), and generate new code from an input file.

Another key part of Nihilist is the function declaration finder (found in declarations.ml)
which supplies the parser with a list of functions defined in the program.

"Why do we need a function declaration finder? That's quite a weird split to make." — Yeah, but think of the constraints I'm working with here:
we do not have a runtime; we cannot run any of the code, and writing my own KrabbaScript compiler in OCaml is not feasible.

Ironically, my parser is dependent on function declarations — otherwise the complexity would increase dramatically. 
I'll go into more detail on why in the parser section.

The function declaration finder doesn't need any technical explanation it receives raw tokens and outputs a list of function names.

# Lexer

If you've already taken a peek into the lexer, you might have thought to yourself: "Weird. This is extremely simple." — and you'd be right!
Nihilist's lexer is very simple because we only really care about a few data types:
- Bang (exclamation mark)
- Parens (left and right)
- dots/periods
- commas
- function declarations
- identifiers

Everything else — symbols, operators, keywords — get consolidated into Other.

I couldn't find any good reason to declare separate tokens for every keyword and operator like in the KrabbaScript compiler, so I took this route.

Besides that, the lexer does what any other lexer should do — there's not much need to explain that.

The files belonging to the lexer are lexer.ml (of course) and token.ml.

