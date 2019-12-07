require "./computer.rb"

def amp_controller(program, settings)
  signals = [0, 0, 0, 0, 0, 0]
  (0..4).each do |i|
    computer = Computer.new(program.dup)
    inputs = [settings[i], signals[i]]
    outputs = []
    outputs << computer.run(inputs.shift) until computer.halted?
    signals[i + 1] = outputs.compact.pop
  end
  signals
end

#program = [3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0]
#settings = [4,3,2,1,0]
#signals = amp_controller(program, settings)
#puts "#{program} <#{settings} >#{signals}"

#program = [3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0]
#settings = [0,1,2,3,4]
#signals = amp_controller(program, settings)
#puts "#{program} <#{settings} >#{signals}"

#program = [3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0]
#settings = [1,0,4,3,2]
#signals = amp_controller(program, settings)
#puts "#{program} <#{settings} >#{signals}"

program = File.read(ARGV.shift).split(",").map(&:to_i)
max = 0
(0..4).each do |a|
  (0..4).each do |b|
    (0..4).each do |c|
      (0..4).each do |d|
        (0..4).each do |e|
          settings = [a, b, c, d, e]
          next if settings.uniq.count != 5

          signals = amp_controller(program, settings)
          if signals[5] > max
            max = signals[5]
            #puts "#{settings} --> #{signals}"
          end
        end
      end
    end
  end
end
puts max
