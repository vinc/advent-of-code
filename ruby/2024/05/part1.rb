rules, pages = ARGF.read.split("\n\n").map { |s| s.split("\n") }
rules.map! { |l| l.split("|").map(&:to_i) }
pages.map! { |l| l.split(",").map(&:to_i) }
pages.select! do |page|
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
puts pages.sum { |page| page[page.size / 2] }
