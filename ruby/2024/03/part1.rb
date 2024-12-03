puts ARGF.read.scan(/mul\((\d+),(\d+)\)/).map { |l| l.map(&:to_i).reduce(&:*) }.sum
