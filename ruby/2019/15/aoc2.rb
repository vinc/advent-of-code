require "set"
require "rainbow/refinement"
require_relative "./computer.rb"
using Rainbow

class OutsideError < StandardError
end

class Node
  attr_accessor :parent, :children, :x, :y, :goal

  def initialize(x, y, goal: false)
    @goal = goal
    @x = x
    @y = y
    @children = Set.new
  end

  def depth
    d = 0
    n = self
    while n.parent
      d += 1
      n = n.parent
    end
    d
  end

  def hash
    100 * y + x
  end

  def eql?(other)
    other.class == self.class && other.hash == self.hash
  end

  def inspect
    "<x=#{x} y=#{y} children=#{children}>"
  end
end

def bfs(node, grid)
  max_depth = 0
  queue = []
  queue.push([node, 0])

  while queue.size != 0
    n, d = queue.shift
    grid[n.y][n.x] = "o"
    puts draw_grid(grid)
    max_depth = d if d > max_depth
    n.children.each do |child|
      queue.push([child, d + 1])
    end
  end
  max_depth
end

def draw_grid(grid, border = true)
  border = false
  res = ""
  res += "+" + "-" * grid[0].size + "+\n" if border
  grid.each_index do |y|
    res += "|" if border
    res += grid[y].each_index.map do |x|
      case grid[y][x]
        when "D" then "D".bold.green
        when "X" then "X".bold.orange
        when "#" then "#"
        when "." then "."
        when "O", "o" then "O".bold.red
        else " "
      end
    end.join
    res += "|" if border
    res += "\n"
  end
  res += "+" + "-" * grid[0].size + "+" if border
  res + "\n"
end

grid = Array.new(41).map { Array.new(41) }
# north=1 east=4 south=2 west=3
move_commands = [1, 4, 2, 3]
dir_names = %w[north east south west]
dirs = [[-1, 0], [0, 1], [1, 0], [0, -1]]
dir = 0
y = 21
x = 21
root = Node.new(x, y)
node = root
discovered_nodes = {}
x_min = x
x_max = x
y_min = y
y_max = y
program = File.read(File.join(__dir__, "input")).split(",").map(&:to_i)
computer = Computer.new(program.dup)
# computer.debug = true
steps = 0
found = false
time_to_fill = 0
grid[y][x] = "X"
until computer.halted?
  computer.run do |outputs|
    steps += 1
    #puts format("x=%d, y=%d, dir=%s, outputs=%s", x, y, dir_names[dir], outputs)
    until outputs.empty?
      status = outputs.shift

      grid[y][x] = "D" unless "XO".include?(grid[y][x] || " ")
      # puts draw_grid(grid) # if status == 2 || steps % 10000 == 0
      # p root

      #puts bfs(root) if found # && steps % 1000 == 0
      if found && steps % 1000 == 0
        fill = grid.dup.map(&:dup)
        depth = bfs(root, fill)
        time_to_fill = depth if depth > time_to_fill
        puts [depth, time_to_fill].join(" / ")
        exit if time_to_fill == 328
      end

      dy, dx = dirs[dir]
      if status == 0
        grid[y + dy][x + dx] ||= "#"
      else
        grid[y][x] = "." unless "XO".include?(grid[y][x])
        new_node = Node.new(x, y)
        if discovered_nodes.include?(new_node)
          new_node = discovered_nodes[new_node]
        else
          node.children.add(new_node)
          new_node.parent = node
          discovered_nodes[new_node] = node
        end
        node = new_node
        y += dy
        x += dx
        #p [x_min, x_max, y_min, y_max] if x > x_max || x < x_min || y > y_max || y < y_min
        x_max = x if x > x_max
        x_min = x if x < x_min
        y_max = y if y > y_max
        y_min = y if y < y_min
        raise OutsideError if x < 0 || y < 0
        if status == 2
          found = true
          root = Node.new(x, y, goal: true)
          node = root
          discovered_nodes = {}
          begin
            grid[y][x] = "O"
          rescue
            raise OutsideError
          end
        end
      end

      #dir = rand(dirs.size)

      left = (dir - 1) % dirs.size
      dy, dx = dirs[left]
      if grid[y + dy][x + dx] != "#"
        dir = left
      else
        dy, dx = dirs[dir]
        if grid[y + dy][x + dx] == "#"
          dir = (dir + 1) % dirs.size
        end
      end
    end
    # sleep 1
    move_commands[dir]
  rescue OutsideError
    puts "Hit the outside!"
    puts format("x=%d, y=%d, dir=%s, outputs=%s", x, y, dir, outputs)
    p [x_min, x_max, y_min, y_max]
    puts draw_grid(grid)
    exit
  end
end
