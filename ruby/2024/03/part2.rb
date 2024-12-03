puts ARGF.read
         .gsub(/don't\(\)(?:.*?do\(\)|.*$)/m, "")
         .scan(/mul\((\d+),(\d+)\)/)
         .map { |x, y| x.to_i * y.to_i }
         .sum
