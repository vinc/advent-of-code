input = ARGF.read.split("\n").map { |line| line.split.map(&:to_i) }
l1 = input.map(&:first).sort
l2 = input.map(&:last).sort
puts l1.zip(l2).map { |a, b| (a - b).abs }.sum
