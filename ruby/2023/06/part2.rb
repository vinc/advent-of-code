t, d = ARGF.read.lines.map { |s| s.gsub(/\s+/, "").split(":").last.to_i }
p (0..t).count { |h| (t - h) * h > d }
