
# Nihilist

Nihilist is a preprocessor for [KrabbaScript](https://github.com/KrabbaTek/krabbascript) designed to let you write (relatively) relaxed and laid back code without having to go out of your way and conform to harmful conventions.

The main and most notable feature of Nihilist right now is paren insertion, which lets you omit parens on function calls (and function declaration in the future).

Therefore, you can write: `add 2, 2` instead of `add(2, 2)`

Nihilist will also receive some other features in the future to let you write cleaner and less redundant code.

One thing to note is that you can write normal KrabbaScript in Nihilist — it would be antithetical for me to say otherwise — but just note that nihilist code is not valid krabbascript.

# But why compile to KrabbaScript?

> Why does Nihilist target KrabbaScript? Why not just make your own language?

I really do like the syntax of KrabbaScript, but there's some parts of it that I just cannot stand.

For example, writing `Std.print("Hey!")` instead of `Std.print "Hey!"` is extremely annoying.

Or, writing:

```
func void() {
    # ...
}
```

instead of just

```
func void {
    # ...
}
```

I plan for Nihilist to provide beautiful alternatives to all (or atleast most) of the warts of KrabbaScript, allowing you to skip the painful areas while still using everything that's great about KrabbaScript.

# Commands

The main command you'll be using is `compile` — you can also omit a command and it will default to this.

This will receive an input file (I suggest using a .nihilist extension) and an output file.
If you don't argue an output file then the output will be written to your input file but with a .ks extension.

For example:

`nihilist compile test.nihilist`

The output will be written to `test.ks`.

You can also use the `nihilism` command to read my writing on Nihilism.

# Features

As you will soon see, the main features of Nihilist are purely cosmetic.

I.e., no keywords or structural language features are added.

## Omitting parens in method & function calls

Like I showed earlier, you can omit parentheses in your method and function calls.

One thing to know about is Nihilist can only infer your function calls when they are defined in the same file.

Therefore, if you define a function in another file — or if the function is from a library/module — then you cannot omit parens.

That is not a problem with method calls, however.

You can learn more about this system in nihilist_guide.md.

```
add 2, 2
```

Another thing to know is that you can only omit parens at the top level — you cannot write:

```
add 2, add 2, 2
```

Any nested functions need to be wrapped in parens, for example:

```
add 2, add(2, 2)
```

## Omitting parens in zero-arity function declarations

If you're declaring a function that takes no arguments — has an arity of zero — then you can drop the parens:

```
func void {
    # ...
}
```

This will become:

```
func void() {
    # ...
}
```

## Question mark method & function calls

When calling a method or function with an arity of zero — no arguments — you can add a question mark to the end:

```
array.empty?
```

```
logged_in?
```

## Automatic Semicolon Insertion

This isn't something you can toggle on and off or customize in any way, but it's something to know about.

You can omit semicolons in your Nihilist code because of the ASI. For example:

```
add 2, 2
```

Becomes:

```
add(2, 2);
```

No need to use the `format` command or `--format` flag in the KrabbaScript compiler.

<hr>

Another thing to know is that Nihilist will not throw an error, unless somehow you encounter a runtime error with the code.

That means if you define a function with an arity of two and only pass one argument, Nihilist will happily compile it and you'll
only realize your mistake when you build the code with KrabbaScript.

<hr>

Nihilist is not without its problems, so don't expect all these features to go off without a hitch.

I apologize in advance for any problems Nihilist may cause you — I'm trying my hardest to fix them.

# Internals

I'm not going to touch on the internals of Nihilist here, but check out `nihilist_guide.md` for that, as well as information on how to run Nihilist.

<hr>

Nihilist would not exist if it weren't for [Yehor Khytryy](https://github.com/khytryy) and his work with [KrabbaScript](https://github.com/KrabbaTek/krabbascript); please consider taking a look at his work.

Cheers.