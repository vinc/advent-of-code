grid = []

ARGF.readlines.each do |line|
  x = 0
  y = 0
  wire = {}
  steps = 0
  line.split(",").each do |part|
    d = part[0]
    n = part[1..].to_i
    while n > 0
      steps += 1
      case d
        when "U" then y += 1
        when "R" then x += 1
        when "D" then y -= 1
        when "L" then x -= 1
      end
      n -= 1
      wire[[x, y]] = steps
    end
  end
  grid << wire
end

p (grid[0].keys & grid[1].keys).map { |k| grid[0][k] + grid[1][k] }.sort.first
