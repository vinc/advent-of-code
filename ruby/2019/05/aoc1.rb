mem = File.read(ARGV.shift).split(",").map(&:to_i)

i = 0
n = mem.size
loop do
  value = format("%05i", mem[i])
  mode3 = value[0]
  mode2 = value[1]
  mode1 = value[2]

  opcode = value[3..4]
  param1 = mode1 == "1" ? mem[i + 1] : mem[mem[i + 1]]
  param2 = mode2 == "1" ? mem[i + 2] : mem[mem[i + 2]]

  case opcode
  when "01"
    mem[mem[i + 3]] = param1 + param2
    i += 4
  when "02"
    mem[mem[i + 3]] = param1 * param2
    i += 4
  when "03"
    mem[mem[i + 1]] = gets.chomp[0].to_i
    i += 2
  when "04"
    puts param1
    i += 2
  when "99"
    break
  end
  break if i >= n
end
