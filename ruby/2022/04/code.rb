input = ARGF.read.split("\n")
p input.count { |x| a, b = x.split(",").map { |x| i, j = x.split("-").map(&:to_i); i..j }; a.cover?(b) || b.cover?(a) }
p input.count { |x| a, b = x.split(",").map { |x| i, j = x.split("-").map(&:to_i); i..j }; (a.to_a & b.to_a).any? }
