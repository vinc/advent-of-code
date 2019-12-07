require "./computer.rb"

def amp_controller(program, settings)
  computers = [
    Computer.new(program.dup),
    Computer.new(program.dup),
    Computer.new(program.dup),
    Computer.new(program.dup),
    Computer.new(program.dup)
  ]

  signals = [0, 0, 0, 0, 0, 0]

  (0..4).each do |i|
    computers[i].run(settings[i])
  end

  loop do
    break if computers.last.halted?

    (0..4).each do |i|
      computers[i].run(signals[i])
      signals[i + 1] = computers[i].run
    end
    break if computers.last.halted?
    signals[0] = signals[5]
    #puts
    #puts "+--= #{program}"
    #puts "|"
    #puts "+--< #{settings}"
    #puts "|"
    #puts "+--> #{signals[0..4]}"
  end
  signals.first
end

#program = [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]
#settings = [9,8,7,6,5]
#puts amp_controller(program, settings)

#program = [
#  3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,
#  1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,
#  56,1005,56,6,99,0,0,0,0,10
#]
#settings = [9,7,8,5,6]
#puts amp_controller(program, settings)

program = File.read(ARGV.shift).split(",").map(&:to_i)
max = 0
(5..9).each do |a|
  (5..9).each do |b|
    (5..9).each do |c|
      (5..9).each do |d|
        (5..9).each do |e|
          settings = [a, b, c, d, e]
          next if settings.uniq.count != 5

          signal = amp_controller(program, settings)
          if signal > max
            max = signal
          end
        end
      end
    end
  end
end
puts max
