class Computer
  def initialize(program)
    @mem = program
    @ip = 0
    @halted = false
  end

  def halted?
    @halted
  end

  def run(input = nil)
    n = @mem.size
    loop do
      value = format("%05i", @mem[@ip])
      mode3 = value[0].to_i
      mode2 = value[1].to_i
      mode1 = value[2].to_i
      opcode = value[3..4].to_i
      param1 = mode1 == 1 ? @mem[@ip + 1].to_i : @mem[@mem[@ip + 1].to_i].to_i
      param2 = mode2 == 1 ? @mem[@ip + 2].to_i : @mem[@mem[@ip + 2].to_i].to_i
      param3 = mode3 == 1 ? @mem[@ip + 3].to_i : @mem[@mem[@ip + 3].to_i].to_i

      case opcode
      when 1 # add
        @mem[@mem[@ip + 3]] = param1 + param2
        @ip += 4
      when 2 # mult
        @mem[@mem[@ip + 3]] = param1 * param2
        @ip += 4
      when 3 # input
        @mem[@mem[@ip + 1]] = input
        @ip += 2
        return
      when 4 # ouput
        @ip += 2
        return param1
      when 5 # jump-if-true
        @ip = param1 != 0 ? param2 : @ip + 3
      when 6 # jump-if-false
        @ip = param1 == 0 ? param2 : @ip + 3
      when 7 # less-than
        @mem[@mem[@ip + 3]] = param1 < param2 ? 1 : 0
        @ip += 4
      when 8 # equal
        @mem[@mem[@ip + 3]] = param1 == param2 ? 1 : 0
        @ip += 4
      when 99 # exit
        break
      end
      break if @ip >= n
    end
    @halted = true
    nil
  end
end

def test_computer
  program = File.read(File.join(__dir__, "../05/input")).split(",").map(&:to_i)
  computer = Computer.new(program.dup)
  inputs = [1]
  print "#{inputs} --> "
  outputs = []
  outputs << computer.run(inputs.shift) until computer.halted?
  print "#{outputs.compact} == [.., 5577461] ?\n"

  computer = Computer.new(program.dup)
  inputs = [5]
  print "#{inputs} --> "
  outputs = []
  outputs << computer.run(inputs.shift) until computer.halted?
  print "#{outputs.compact} == [7161591] ?"
end
