require "rainbow/refinement"

using Rainbow

class Computer
  attr_accessor :debug

  def initialize(program)
    @waiting = false
    @halted = false
    @base = 0
    @ip = 0
    @mem = Array.new(1 << 20, 0)
    @debug = false
    program.each_with_index { |v, i| @mem[i] = v }
  end

  def dump
    @mem
  end

  def halted?
    @halted
  end

  # Run the program with the inputs and return the outputs
  def run(&block)
    outputs = []
    outputs << exec(outputs, &block) until halted?
    yield(outputs.compact)
  end

  # Execute instructions with the input until the program halt
  # or output something that will be returned.
  def exec(outputs, &block)
    until @ip >= @mem.size
      opcode, param1, param2, param3 = next_instruction
      case opcode
      when 1 # add
        puts "--> #{[opcode, param1, param2, param3]}" if debug
        @mem[param3] = @mem[param1] + @mem[param2]
        @ip += 4
      when 2 # mult
        puts "--> #{[opcode, param1, param2, param3]}" if debug
        @mem[param3] = @mem[param1] * @mem[param2]
        @ip += 4
      when 3 # input
        puts "--> #{[opcode, param1]}".bold.orange if debug
        @mem[param1] = yield(outputs)
        @ip += 2
        outputs = []
      when 4 # ouput
        puts "--> #{[opcode, param1]}".bold.green if debug
        @ip += 2
        return @mem[param1]
      when 5 # jump-if-true
        puts "--> #{[opcode, param1, param2]}" if debug
        @ip = @mem[param1] != 0 ? @mem[param2] : @ip + 3
      when 6 # jump-if-false
        puts "--> #{[opcode, param1, param2]}" if debug
        @ip = @mem[param1] == 0 ? @mem[param2] : @ip + 3
      when 7 # less-than
        puts "--> #{[opcode, param1, param2, param3]}" if debug
        @mem[param3] = @mem[param1] < @mem[param2] ? 1 : 0
        @ip += 4
      when 8 # equal
        puts "--> #{[opcode, param1, param2, param3]}" if debug
        @mem[param3] = @mem[param1] == @mem[param2] ? 1 : 0
        @ip += 4
      when 9
        puts "--> #{[opcode, param1]}" if debug
        @base += @mem[param1]
        @ip += 2
      when 99 # exit
        puts "--> #{[opcode]}".bold.red if debug
        break
      else
        puts "invalid opcode"
        break
      end
    end
    @halted = true
    nil
  end

  def next_instruction
    value = format("%05i", @mem[@ip])
    opcode = read_opcode(value)
    param1 = read_param(value, 1)
    param2 = read_param(value, 2)
    param3 = read_param(value, 3)
    [opcode, param1, param2, param3]
  end

  def read_opcode(value)
    opcode = value[3..4].to_i
  end

  def read_param(value, i)
    mode = value[3 - i].to_i
    case mode
    when 0 # position mode
      @mem[@ip + i]
    when 1 # immedate mode
      @ip + i
    when 2 # relative mode
      @mem[@ip + i] + @base
    end
  end
end
