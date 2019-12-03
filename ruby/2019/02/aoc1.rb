code = ARGF.read.split(",").map(&:to_i)

i = 0
n = code.length

loop do
  case code[i]
  when 1
    code[code[i + 3]] = code[code[i + 1]] + code[code[i + 2]]
  when 2
    code[code[i + 3]] = code[code[i + 1]] * code[code[i + 2]]
  when 99
    break
  end
  i += 4
  break if i >= n
end

puts code.join(",")
