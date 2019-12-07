h = {}

ARGF.readlines.each do |l|
  a, b = l.chomp.split(")")
  h[b] = a
end

def parents(h, k)
  res = []
  while h[k]
    res << h[k]
    k = h[k]
  end
  res
end

t1 = parents(h, "YOU")
t2 = parents(h, "SAN")

n = 0
t1.each do |a|
  m = 0
  t2.each do |b|
    if a == b
      p n + m
      exit
    end
    m += 1
  end
  n += 1
end
