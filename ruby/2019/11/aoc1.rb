require_relative "./computer.rb"

program = File.read(File.join(__dir__, "input")).split(",").map(&:to_i)
computer = Computer.new(program.dup)

dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]]
word = %w[N W S E]
turn = 0
pos = [0, 0]
panels = {}
until computer.halted?
  panels[pos.dup] ||= 0
  c = computer.exec(panels[pos])
  panels[pos.dup] = c
  d = computer.exec
  case d
  when 0
    turn = (turn - 1) % 4
  when 1
    turn = (turn + 1) % 4
  end
  dir = dirs[turn]
  pos[0] += dir[0]
  pos[1] += dir[1]
end

width = 120
height = 120
grid = Array.new(height).map { Array.new(width, 0) }

panels.each do |(x, y), c|
  grid[-y + height / 2][x + width / 2] = c
end

grid.each do |line|
  puts line.map { |c| c == 0 ? "." : "#" }.join
end

p panels.count
