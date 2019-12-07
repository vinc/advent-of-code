h = {}

ARGF.readlines.each do |l|
  a, b = l.chomp.split(")")
  h[b] = a
end

n = 0

h.keys.each do |k|
  while h[k]
    n += 1
    k = h[k]
  end
end

p n
