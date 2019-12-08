n = 25 * 6
img = Array.new(n)
ARGF.read.chars.each_with_index do |c, i|
  case c
    when "0" then img[i % n] ||= " " # white
    when "1" then img[i % n] ||= "#" # black
    when "2" then img[i % n] ||= nil # transparent
  end
end
img.each_slice(25) { |line| puts line.join }
