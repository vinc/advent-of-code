require_relative "./lib.rb"

input = File.read(File.join(__dir__, "input"))
simulation = Simulation.new(input)
simulation.steps(1000)
p simulation.total_energy
