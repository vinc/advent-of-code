require_relative "./lib.rb"

input = File.read(File.join(__dir__, "input")).chomp
FFT.new(input).phase(100) do |i, signal|
  puts format("% 4d: %s", i, signal)
end
