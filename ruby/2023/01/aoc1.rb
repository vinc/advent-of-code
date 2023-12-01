p ARGF.read.split.map { |s| s.scan(/\d/).values_at(0, -1).join.to_i }.sum
