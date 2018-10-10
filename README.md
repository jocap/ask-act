# ask-act

`ask-act` is a Ruby library that makes it easy to build read-eval-print
loops (REPL).  Here's a canonical example, demonstrating every
method of the `AskAct` class:

```ruby
require 'ask-act'
require 'readline'

repl = AskAct.new

prefix = ARGV.join(' ')
prompt = "#{prefix} > "

repl
  .ask { Readline.readline(prompt, true) }
  .act { |command| system "#{prefix} #{command}" }
  .on(nil) { puts; repl.break } # ^D
  .rescue(Interrupt) { puts; repl.next } # ^C
  .run
```

1. **ask** describes how to ask and get an input from the user.
2. **act** describes how to act on any input from the user.
3. **on** describes how to act on some specific input, overriding the default **act**.
4. **rescue** describes how to handle an exception in the loop.
5. **run** starts the loop.

The **break** and **next** methods translate to using Ruby’s `break`
and `next` statements within the loop.
