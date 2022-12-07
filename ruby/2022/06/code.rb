input = ARGF.read
input.chars.each_cons(4).find_index { |a| a.uniq.count == 4 } + 4
input.chars.each_cons(14).find_index { |a| a.uniq.count == 14 } + 14
