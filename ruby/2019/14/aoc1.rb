require_relative "./lib.rb"

input = File.read(File.join(__dir__, "input"))
factory = NanoFactory.new(input)
p factory.ore_needed_for(1, "FUEL")
