input = ARGF.read.split("\n").map { |line| line.split.map(&:to_i) }
l1 = input.map(&:first)
l2 = input.map(&:last)
puts l1.map { |x| x * l2.count(x) }.sum
