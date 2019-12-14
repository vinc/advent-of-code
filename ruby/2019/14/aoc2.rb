require_relative "./lib.rb"

input = File.read(File.join(__dir__, "input"))
factory = NanoFactory.new(input)
p factory.max_fuel(1000000000000)
