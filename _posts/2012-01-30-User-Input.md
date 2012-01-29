---
layout: wiki
menu:
  - "Clear the input buffer"
  - "Suppress evaluation output"
  - "Show the contents of the input buffer"
  - "Amend lines of input"
  - "Editing the input buffer with an editor"
  - "Replay history"
  - "Play files and methods as input"
  - "The _in_ and _out_ cache"
---

### Overview

Unlike some REPLs, where a single mistake can force you to reenter the whole expression, or worse still - get stuck in an endless read loop - Pry has a number of features designed to make entering input a less frustrating experience.

### Clear the input buffer

Sometimes the parsing process can go wrong while entering a multi-line expression, and the read loop will never terminate. Entering the `!` character on a line by itself will clear the input buffer and break out of the read loop. Doing this will enable normal input to resume on the next line. The contents of the input buffer will be lost, however.

Example:

{% highlight ruby %}
pry(main)> def hello
pry(main)*   puts "hello"
pry(main)* !
Input buffer cleared!
pry(main)>
{% endhighlight %}

### Suppress evaluation output
{% include back_to_top.html %}

Put a `;` at the end of a line to suppress the printing of output. This is useful when doing calculations which generate long output you are not interested in seeing. The `_` variable and the `_out_` list do get updated with the contents of the output, even if it is not printed. You can thus still access the generated results this way for further processing.

Example:

{% highlight ruby %}
pry(main)> "test" * 1000000;
pry(main)> _.size
=> 4000000
pry(main)>
{% endhighlight %}

### Show the contents of the input buffer
{% include back_to_top.html %}

When entering long multi-line expressions it can be useful to see the Ruby code you've entered so far. The `show-input` command will display the contents of the input buffer with syntax highlighting and line numbers. This command can be very useful when combined with the `amend-line` and `play` commands.

Example:

{% highlight ruby %}
pry(main)> def poem
pry(main)*   puts "I remember silver hours and sunlight by the rivers"
pry(main)*   puts "And our kisses standing on the spicy plains"
pry(main)* show-input
1: def poem
2:   puts "I remember silver hours and sunlight by the rivers"
3:   puts "And our kisses standing on the spicy plains"
pry(main)*
{% endhighlight %}

### Amend lines of input
{% include back_to_top.html %}

When entering multi-line expressions sometimes a mistake may be made on an earlier line. Using amend-line you can specify which line in the input buffer you wish to replace with a corrected version. The syntax for replacing a line is `amend-line N replacement code` where `N` is the number of the line (or range of lines using `A..B` syntax) you wish to replace. The `amend-line` command is usually used in concert with `show-input` command (discussed above).

Example:

{% highlight ruby %}
pry(main)> def hello
pry(main)*   puts "hello #{name}"
pry(main)* amend-line 1 def hello(name)
1: def hello(name)
2:   puts "hello #{name}"
{% endhighlight %}

Aside from replacing lines, `amend-line` also allows you to delete lines. Simply pass `!` as the replacement code and the line(s) will instead be deleted.

Aliases: `%`

Example:

{% highlight ruby %}
pry(main)> def goodbye
pry(main)*   puts "good evening"
pry(main)*   puts "au revoir"
pry(main)* amend-line 2..3 !
1: def goodbye
pry(main)*
{% endhighlight %}

As a further time saving feature, if the line number is neglected then
it is the preceding line that is amended.

### Editing the input buffer with an editor
{% include back_to_top.html %}

When the [`edit`](https://github.com/pry/pry/wiki/Editor-Integration#wiki-Edit_command) command is invoked (with no arguments) in a non-empty
input buffer, your editor will open a temporary file with the buffer contents. When you later save and exit the editor, the input
buffer will be replaced with the contents of the temp file.

This is great for when you're entering long input, which can become
unwieldy in a REPL. It is also an alternative to [`amend-line`](https://github.com/pry/pry/wiki/User-Input#wiki-Amend_line) as you can
correct any input errors while in the editor.

Example: We invoke an editor in an input buffer and rearrange the lines and add a new one

{% highlight ruby %}
pry(main)> def lorca
pry(main)*   puts "because dawn will throw fistfuls of ants at me"
pry(main)*   puts "cover me at dawn in a veil"
pry(main)* edit
pry(main)* show-input
1: def lorca
2:   puts "cover me at dawn in a veil"
3:   puts "because dawn will throw fistfuls of ants at me"
4:   puts "and sprinkle my shoes with hard-water so the pincers of the scorpion slide"
pry(main)* 
{% endhighlight %}

### Replay history
{% include back_to_top.html %}

A line (or multiple lines) of Readline history can be replayed by
using the `hist --replay` command. The `hist` command will be
discussed in more detail in the [history section](https://github.com/pry/pry/wiki/History), but here is a simple example of its use:

Example:

{% highlight ruby %}
pry(main)> hist --tail 5
4870: puts "hello world"
4871: puts "goodbye cruel world"
4872: puts "evening sir"
4873: 5 + 4
4874: hist --tail 5
pry(main)> hist --replay 4870..4871
hello world
=> nil
goodbye cruel world
=> nil
pry(main)>
{% endhighlight %}

### Play files and methods as input
{% include back_to_top.html %}

The `play` command enables you to replay code from files and methods as if they were entered directly in the Pry REPL. When `play` is passed the `-m` switch a valid method name must be given (in `ri` method syntax), when the `-m` switch is combined with the `--open` switch then the entire method is replayed except for the final line, effectively leaving it 'open' for modification using `amend-line`. Alternatively when the `-f` switch is used a valid file name must be provided. The optional `--lines A..B` option can be supplied which selects the line (or range of lines) to play from the given source.

This command is quite powerful and there are many use-cases. Some include:

Stitching together new methods from bits and pieces of other methods:

{% highlight ruby %}
pry(main)> def get_input
pry(main)*   puts "enter something:"
pry(main)*   var = $stdin.gets
pry(main)* end;
pry(main)> def greeting
pry(main)*   puts "how are you today?"
pry(main)* end;
pry(main)> def stitched_method
pry(main)* play -m greeting --lines 2
pry(main)* play -m get_input --lines 3
pry(main)* show-input
1: def stitched_method
2:   puts "how are you today?"
3:   var = $stdin.gets
pry(main)*   puts "that's great you're feeling #{var.chomp}!"
pry(main)* end;
pry(main)> show-method stitched_method

From: (pry) @ line 25:
Number of lines: 5

def stitched_method
  puts "how are you today?"
  var = $stdin.gets
  puts "that's great you're feeling #{var.chomp}!"
end
{% endhighlight %}

Extract lines of code out of a file you're browsing:

{% highlight ruby %}
pry(main)> cat FAQ.md -l -s 18 -e 25
18: ```ruby
19: begin
20:   require 'awesome_print' 
21:   Pry.config.print = proc { |output, value| output.puts value.ai }
22: rescue LoadError => err
23:   puts "no awesome_print :("
24: end
25: ```
pry(main)> play -f #{_file_} --lines 19..24
no awesome_print :(
=> nil
pry(main)> 
{% endhighlight %}

Note that in the above we are interpolating the [special local](https://github.com/pry/pry/wiki/Special-Locals#wiki-Last_file_and_dir) `_file_`
into the `play` command: see more on interpolation [here](https://github.com/pry/pry/wiki/Command-system#wiki-Command_interpolation)

We have just scratched the surface of what's possible with
the `play` command - the combination of `play`, `amend-line` and
`show-input` form a trilogy of commands that work together to support
some very powerful possibilities. Other possibilities including:
transplanting methods from one context to another, and re-opening
methods (using `play -m meth --open`) for easy monkey-patching
directly in Pry.

### The \_in\_ and \_out\_ cache
{% include back_to_top.html %}

Input expressions and output results are automatically stored in array-like data structures
accessible from the `_in_` and `_out_` locals respectively. 

For more information see the [Special locals](https://github.com/pry/pry/wiki/Special-Locals#wiki-In_and_out) section.
