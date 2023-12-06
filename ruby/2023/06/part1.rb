ts, ds = ARGF.read.lines.map { |s| s.split(":").last.split.map(&:to_i) }
p ts.zip(ds).map { |t, d| (0..t).count { |h| (t - h) * h > d } }.reduce(&:*)
