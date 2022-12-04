def score(c)
  b = c.first.ord
  b - (b > 96 ? 96 : 38)
end
items = ARGF.read.split("\n")

puts items.map { |s| n = s.size / 2; score(s[0...n].chars & s[n..].chars) }.sum

puts items.each_slice(3).map { |a, b, c| score(a.chars & b.chars & c.chars) }.sum
