require_relative "./computer.rb"

program = File.read(File.join(__dir__, "input")).split(",").map(&:to_i)
computer = Computer.new(program.dup)
inputs = [2]
outputs = computer.run(inputs)

outputs.compact.each do |output|
  puts output
end
