def check(line)
  puzzle = { red: 12, green: 13, blue: 14 }
  id = line.split(":").first.split.last.to_i
  line.split(": ").last.split("; ").each do |g|
    g.split(", ").each do |c|
      v, k = c.split
      return 0 if v.to_i > puzzle[k.to_sym]
    end
  end
  id
end

p ARGF.read.split("\n").map { |s| check(s) }.sum
