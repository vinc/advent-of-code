def check(grid)
  n = grid.size
  m = grid.first.size
  count = 0
  (0...n).each do |i|
    (0...m).each do |j|
      next if grid[i][j] != "A"
      next if i == 0 || j == 0 || i == n - 1 || j == m - 1
      next if grid[i - 1][j - 1] != "M"
      next if grid[i + 1][j - 1] != "M"
      next if grid[i - 1][j + 1] != "S"
      next if grid[i + 1][j + 1] != "S"
      count += 1
    end
  end
  count
end

def rotate(grid, n)
  n == 0 ? grid : rotate(grid.transpose.map(&:reverse), n - 1)
end

grid = ARGF.read.split("\n").map(&:chars)
puts 4.times.sum { |i| check(rotate(grid, i)) }
