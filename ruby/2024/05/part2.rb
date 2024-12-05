rules, pages = ARGF.read.split("\n\n").map { |s| s.split("\n") }
rules.map! { |l| l.split("|").map(&:to_i) }
pages.map! { |l| l.split(",").map(&:to_i) }
pages.reject! do |page|
  rules.all? do |a, b|
    i = page.index a
    j = page.index b
    if i.nil? || j.nil?
      true
    else
      i < j
    end
  end
end

def order(pages, rules)
  pages.each do |page|
    rules.each do |a, b|
      i = page.index a
      j = page.index b
      next if i.nil? || j.nil?
      page[i], page[j] = page[j], page[i] unless i < j
    end
  end
end

count = 0
loop do
  old = count
  pages = order(pages, rules)
  count = pages.sum { |page| page[page.size / 2] }
  puts count
  break if old == count
end
puts count
