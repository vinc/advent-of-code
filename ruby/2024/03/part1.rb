puts ARGF.read
         .scan(/mul\((\d+),(\d+)\)/)
         .map { |x, y| x.to_i * y.to_i }
         .sum
