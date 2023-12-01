def decode(s)
  %w[one 1 two 2 three 3 four 4 five 5 six 6 seven 7 eight 8 nine 9].each_slice(2) do |a, b|
    s.gsub!(a, [a, b, a].join)
  end
  s
end

puts ARGF.read.split.map { |l| decode(l).scan(/\d/).values_at(0, -1).join.to_i }.sum
