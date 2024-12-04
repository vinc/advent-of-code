rows = ARGF.read.split("\n")
n = rows.size
m = rows.first.size
count = 0
(0...n).each do |i|
  (0...m).each do |j|
    next if rows[i][j] != "X"
    (-1..1).each do |di|
      (-1..1).each do |dj|
        next if di == 0 && dj == 0
        %w[M A S].each_with_index do |c, k|
          a = i + di * (k + 1)
          b = j + dj * (k + 1)
          break if a < 0 || a >= n
          break if b < 0 || b >= m
          break if rows[a][b] != c
          count += 1 if c == "S"
        end
      end
    end
  end
end
puts count
