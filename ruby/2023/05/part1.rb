seeds = []
cats = []
maps = {}

ARGF.each_line do |line|
  words = line.chomp.split
  case words[0]
  when "seeds:"
    seeds = words[1..].map(&:to_i)
  when /[a-z]/
    cat = words.first.split("-to-").last
    maps[cat] = []
    cats << cat
  when /[0-9]/
    dst, src, len = words.map(&:to_i)
    range = src...(src + len)
    offset = dst - src
    maps[cats.last] << [range, offset]
  end
end

locs = seeds.map do |num|
  cats.each do |cat|
    maps[cat].any? do |range, offset|
      num += offset if range.include? num
    end
  end
  num
end

p locs.min
