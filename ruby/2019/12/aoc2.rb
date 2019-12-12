require_relative "./lib.rb"

input = File.read(File.join(__dir__, "input"))
simulation = Simulation.new(input)
p simulation.cycles
