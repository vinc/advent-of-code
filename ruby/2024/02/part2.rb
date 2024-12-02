def check(r)
  rule1 = [r, r.reverse].include? r.sort
  rule2 = r.each_cons(2).all? { |x, y| (1..3).include? (x - y).abs }
  rule1 && rule2
end

n = ARGF.read.split("\n").select do |line|
  report = line.split.map(&:to_i)
  n = report.size
  check(report) || (0..n).any? do |i|
    r = report.clone
    r.delete_at(i)
    check(r)
  end
end.count
puts n
