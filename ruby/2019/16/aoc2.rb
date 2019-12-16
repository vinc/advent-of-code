require_relative "./lib.rb"

input = File.read(File.join(__dir__, "input"))
input = ([input] * 10_000).join

FFT.new(input).phase(100) do |i, signal|
  puts format("% 4d: %s...", i, signal[0..7])
end
