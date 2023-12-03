# NOTE: First draft, ugly code
grid = ARGF.read.split("\n")
nums = []
gear = []
n = grid[0].size - 1
m = grid.size - 1
(0..m).each do |y|
  (0..n).each do |x|
    next unless grid[y][x] == "*"

    (-1..1).each do |dx|
      (-1..1).each do |dy|
        i = x + dx
        j = y + dy
        next if i < 0 || i >= grid[0].size
        next if j < 0 || j >= grid.size
        next if i == x && j == y
        c = grid[j][i]
        case c
        when "0".."9"
          k = i - 1
          while k >= 0
            c = grid[j][k]
            case c
            when "0".."9"
              k -= 1
            else
              break
            end
          end
          k += 1
          num = ""
          while k < grid[0].size
            c = grid[j][k]
            case c
            when "0".."9"
              num << c
              k += 1
            else
              break
            end
          end
          gear << num.to_i
        end
      end
    end
    gear = gear.uniq
    nums << gear[0] * gear[1] if gear.size == 2
    gear = []
  end
end
p nums.sum
