puts ARGF.read.split.map { |l| l.scan(/\d/).values_at(0, -1).join.to_i }.sum
