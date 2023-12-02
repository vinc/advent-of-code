def power(line)
  h = {}
  line.split(": ").last.split("; ").each do |g|
    g.split(", ").each do |c|
      v, k = c.split
      h[k] = [h[k] || 0, v.to_i].max
    end
  end
  h.values.reduce(&:*)
end

p ARGF.read.split("\n").map { |s| power(s) }.sum
