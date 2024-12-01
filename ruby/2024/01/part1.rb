a, b = ARGF.read.split.map(&:to_i).each_slice(2).to_a.transpose.map(&:sort)
puts a.zip(b).map { |x, y| (x - y).abs }.sum
