h = Hash.new(0)
ARGF.read.split("\n").each_with_index do |line, i|
  win, own = line.split(": ").last.split(" | ").map { |s| s.split.map(&:to_i) }
  n = (win & own).count
  (h[i] += 1).times { (0...n).each { |j| h[i + j + 1] += 1 } }
end
p h.values.sum
