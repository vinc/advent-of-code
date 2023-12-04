def count(line)
  win, own = line.split(": ").last.split(" | ").map { |s| s.split.map(&:to_i) }
  n = (win & own).count
  n > 0 ? 2 ** (n - 1) : 0
end
p ARGF.read.split("\n").map { |line| count(line) }.sum
