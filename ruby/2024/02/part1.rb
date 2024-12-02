n = ARGF.read.split("\n").select do |line|
  report = line.split.map(&:to_i)
  rule1 = [report, report.reverse].include? report.sort
  rule2 = report.each_cons(2).all? { |x, y| (1..3).include? (x - y).abs }
  rule1 && rule2
end.count
puts n
