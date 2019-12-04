count = 0
(245182..790572).each do |num|
  chars = num.to_s.chars
  has_double = false
  is_increasing = true
  (0..4).each do |i|
    if chars[i + 1] < chars[i]
      is_increasing = false
      break
    end
    has_double = true if chars[i] == chars[i + 1]
  end
  count += 1 if is_increasing && has_double
end
p count
