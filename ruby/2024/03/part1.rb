puts ARGF.read.scan(/mul\((\d+),(\d+)\)/).sum { |x, y| x.to_i * y.to_i }
