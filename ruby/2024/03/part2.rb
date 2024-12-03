puts ARGF.read
         .gsub(/don't\(\).*?do\(\)/m, "")
         .gsub(/don't\(\).*/m, "")
         .scan(/mul\((\d+),(\d+)\)/)
         .map { |l| l.map(&:to_i).reduce(&:*) }
         .sum
