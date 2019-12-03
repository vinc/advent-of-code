dump = ARGF.read.split(",").map(&:to_i)

(0..100).each do |noun|
  (0..100).each do |verb|
    mem = dump.dup
    mem[1] = noun
    mem[2] = verb

    i = 0
    n = mem.size

    loop do
      case mem[i]
      when 1
        mem[mem[i + 3]] = mem[mem[i + 1]] + mem[mem[i + 2]]
      when 2
        mem[mem[i + 3]] = mem[mem[i + 1]] * mem[mem[i + 2]]
      when 99
        break
      end
      i += 4
      break if i >= n
    end

    if mem[0] == 19690720
      #puts "noun = #{noun}"
      #puts "verb = #{verb}"
      #puts mem.join(",")
      puts 100 * noun + verb
      exit
    end
  end
end
