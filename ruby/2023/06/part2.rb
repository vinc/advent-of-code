ts, ds = ARGF.read.lines.map { |s| s.gsub(/\s+/, "").split(":").last.split.map(&:to_i) }
games = ts.zip(ds).map do |time, dist|
  (0..time).filter do |hold|
    (time - hold) * hold > dist
  end.count
end
p games.flatten.reduce(&:*)
