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
    if chars[i] == chars[i + 1]
      next if i > 0 && chars[i - 1] == chars[i]
      next if i < 4 && chars[i + 1] == chars[i + 2]
      has_double = true
    end
  end
  count += 1 if is_increasing && has_double
end
p count
