
# Nihilist

Nihilist is a preprocessor for [KrabbaScript](https://github.com/KrabbaTek/krabbascript) designed to let you write (relatively) relaxed and laid back code without having to go out of your way and conform to harmful conventions.

The main feature of Nihilist right now is paren insertion, which lets you omit parens on function calls (and function declaration in the future).

Therefore, you can write: `add 2, 2` instead of `add(2, 2)`

Nihilist will also receive some other features in the future to let you write cleaner code like type inference — writing `func add(a, b) ...` instead of `func add (a: I32, b: I32) -> I32 ...`

One thing to note is that you can write normal KrabbaScript in Nihilist — it would be antithetical for me to say otherwise — but just note that nihilist code is not valid krabbascript.

# But why compile to KrabbaScript?

> Why does Nihilist target KrabbaScript? Why not just make your own language?

I really do like the syntax of KrabbaScript, but there's some parts of it that I just cannot stand.

For example, writing `Std.print("Hey!")` instead of `Std.print "Hey!"` is extremely annoying.

I plan for Nihilist to provide beautiful alternatives to all the warts of KrabbaScript, allowing you to skip the painful areas while still using everything that's great about KrabbaScript.

# Commands

The main command you'll be using is `compile` — you can also omit a command and it will default to this.

This will receive an input file (I suggest using a .nihilist extension) and an output file.
If you don't argue an output file then the output will be written to your input file but with a .ks extension.

For example:

`nihilist compile test.nihilist`

The output will be written to `test.ks`.

You can also use the `nihilism` command to read my writing on Nihilism.

# Internals

I'm not going to touch on the internals of Nihilist here, but check out `nihilist_guide.md` for that, as well as information on how to run Nihilist.

<hr>

Nihilist would not exist if it weren't for [Yehor Khytryy](https://github.com/khytryy) and his work with [KrabbaScript](https://github.com/KrabbaTek/krabbascript); please consider taking a look at his work.

Cheers.