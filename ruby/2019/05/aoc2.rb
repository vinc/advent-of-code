mem = File.read(ARGV.shift).split(",").map(&:to_i)

i = 0
n = mem.size
loop do
  value = format("%05i", mem[i])
  mode3 = value[0].to_i
  mode2 = value[1].to_i
  mode1 = value[2].to_i
  opcode = value[3..4].to_i
  param1 = mode1 == 1 ? mem[i + 1].to_i : mem[mem[i + 1].to_i].to_i
  param2 = mode2 == 1 ? mem[i + 2].to_i : mem[mem[i + 2].to_i].to_i
  param3 = mode3 == 1 ? mem[i + 3].to_i : mem[mem[i + 3].to_i].to_i

  case opcode
  when 1 # add
    mem[mem[i + 3]] = param1 + param2
    i += 4
  when 2 # mult
    mem[mem[i + 3]] = param1 * param2
    i += 4
  when 3 # input
    mem[mem[i + 1]] = gets.chomp[0].to_i
    i += 2
  when 4 # ouput
    puts param1
    i += 2
  when 5 # jump-if-true
    i = param1 != 0 ? param2 : i + 3
  when 6 # jump-if-false
    i = param1 == 0 ? param2 : i + 3
  when 7 # less-than
    mem[mem[i + 3]] = param1 < param2 ? 1 : 0
    i += 4
  when 8 # equal
    mem[mem[i + 3]] = param1 == param2 ? 1 : 0
    i += 4
  when 99 # exit
    break
  end
  break if i >= n
end
