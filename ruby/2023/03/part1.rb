grid = ARGF.read.split("\n")
nums = []
sym = false
num = ""
n = grid[0].size - 1
m = grid.size - 1
p grid
(0..m).each do |y|
  if num.size > 0
    nums << num.to_i if sym
    num = ""
    sym = false
  end
  (0..n).each do |x|
    c = grid[y][x]
    puts "c='#{c}', num='#{num}', sym=#{sym}"
    case c
    when "0".."9"
      num << c
    else
      if num.size > 0
        nums << num.to_i if sym
        num = ""
        sym = false
      end
      next
    end

    (-1..1).each do |dx|
      (-1..1).each do |dy|
        i = x + dx
        j = y + dy
        puts "i=#{x}#{'+' if dx > -1}#{dx}=#{i}, j=#{y}#{'+' if dy > -1}#{dy}=#{j}"
        next if i < 0 || i >= grid[0].size
        next if j < 0 || j >= grid.size
        next if i == x && j == y
        c = grid[j][i]
        puts "c='#{c}'"
        case c
        when "0".."9"
          next
        when "."
          next
        else
          sym = true
        end
      end
    end
  end
end

p nums.sum
