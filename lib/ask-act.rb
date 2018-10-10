#!/usr/bin/env ruby

class NextIteration < StandardError
end

class AskAct
  def initialize
    @act_on = Hash.new
    @rescue = Hash.new
  end

  def ask(&block)
    @ask = block
    self
  end

  def act(&block)
    @act = block
    self
  end

  def on(value, &block)
    @act_on[value] = block
    self
  end

  def rescue(e, &block)
    @rescue[e] = block
    self
  end

  def run
    while true
      begin
        begin
          input = @ask.call
        rescue Exception => e
          do_rescue(e.class)
        end
        do_act(input)
      rescue NextIteration
        next
      rescue StopIteration
        break
      end
    end
    self
  end

  def break
    raise StopIteration
  end

  def next
    raise NextIteration
  end

  private

  def do_act(value)
    if @act_on.key? value
      @act_on[value].call(value)
    else
      @act.call(value)
    end
  end

  def do_rescue(e)
    if @rescue.key? e
      @rescue[e].call
    else
      raise e
    end
  end
end
