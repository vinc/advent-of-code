require_relative "./computer.rb"

def tile(id)
  case id
    when 0 then " "
    when 1 then "#"
    when 2 then "X"
    when 3 then "-"
    when 4 then "o"
  end
end

screen = Array.new(25).map { Array.new(80, " ") }

program = File.read(File.join(__dir__, "input")).split(",").map(&:to_i)
computer = Computer.new(program.dup)
outputs = computer.run
outputs.each_slice(3) do |x, y, t|
  screen[y][x] = tile(t)
end

screen.each do |line|
  puts line.join
end

p screen.flatten.select { |t| t == "X" }.count
