# NOTE: I ran out of time before breakfast to finish this one

seeds = []
values = {}
keys = {}
from = ""
dest = ""
ARGF.each_line do |line|
  line = line.chomp
  case line
  when /seeds: /
    seeds = line[7..].split.map(&:to_i)
  when "a".."z"
    from, dest = line[0..-6].split("-to-")
    keys[from] = dest
    values[from] = []
    values[dest] = []
  when "0".."9"
    a, b, n = line.split.map(&:to_i)
    values[from] << Range.new(a, a + n)
    values[dest] << Range.new(b, b + n)
    puts "#{from}: #{a}..#{a + n}, #{dest}: #{b}..#{b + n}"
  end
end

dest = "seed"
until dest == "location"
  from = dest
  dest = keys[from]
  puts "#{from} -> #{dest}"
  # p values[from].count
  # p values[dest].count
  seeds.each do |seed| # FIXME
    values[from].each_with_index do |r1, i| # FIXME
      if r1.include? seed
        puts "#{seed} --> #{r1} (#{i})"
      end
    end
  end
end
