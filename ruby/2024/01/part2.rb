a, b = ARGF.read.split.map(&:to_i).each_slice(2).to_a.transpose
puts a.map { |x| x * b.count(x) }.sum
