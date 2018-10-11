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
  .on(nil) { |loop| puts; loop.break } # ^D
  .rescue(Interrupt) { |loop| puts; loop.next } # ^C
  .run
```

1. **ask** describes how to ask and get an input from the user.
2. **act** describes how to act on any input from the user.
3. **on**(value) describes how to act on some specific input, overriding the default **act**.
4. **rescue**(exception) describes how to handle an exception in the loop.
5. **run** starts the loop.

**act** blocks are passed two variables -- (1) the value returned
from the **ask** block and (2) a special *loop* variable -- while
**on** and **rescue** blocks are passed only the loop variable.

The loop variable has two methods called **break** and **next**.
These translate to using Ruby’s `break` and `next` statements within
the loop.
