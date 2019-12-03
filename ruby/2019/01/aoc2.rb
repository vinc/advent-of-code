res = ARGF.readlines.reduce(0) do |r, s|
  t = s.to_i
  loop do
    t = (t / 3).floor - 2
    break unless t > 0
    r += t
  end
  r
end

puts res
