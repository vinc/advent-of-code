n = 25 * 6
min0 = min1 = min2 = n + 1
cur0 = cur1 = cur2 = 0
ARGF.read.chars.each_with_index do |c, i|
  if i > 0 && i % n == 0
    if cur0 < min0
      min0 = cur0
      min1 = cur1
      min2 = cur2
    end
    cur0 = cur1 = cur2 = 0
  end
  case c
    when "0" then cur0 += 1
    when "1" then cur1 += 1
    when "2" then cur2 += 1
  end
end
puts min1 * min2
