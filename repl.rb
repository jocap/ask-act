#!/usr/bin/env ruby

require './lib/ask-act.rb'
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
