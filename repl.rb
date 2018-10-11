#!/usr/bin/env ruby

require './lib/ask-act.rb'
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

# vi: et:sw=2:ts=2
