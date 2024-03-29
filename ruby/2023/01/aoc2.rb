DIGITS = %w[one 1 two 2 three 3 four 4 five 5 six 6 seven 7 eight 8 nine 9].freeze

def sub(str)
  DIGITS.each_slice(2) { |a, b| str.gsub!(a, [a, b, a].join) }
  str
end

puts ARGF.read.split.map { |l| sub(l).scan(/\d/).values_at(0, -1).join.to_i }.sum
