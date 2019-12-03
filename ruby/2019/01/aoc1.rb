puts ARGF.readlines.reduce(0) { |r, s| r + (s.to_i / 3).floor - 2 }
