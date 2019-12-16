require_relative "./lib.rb"

input = File.read(File.join(__dir__, "input")).chomp
input = ([input] * 10_000).join

FFT.new(input).phase(100, offset: input[0..6].to_i) do |i, signal|
  puts format("% 4d: %s", i, signal)
end
