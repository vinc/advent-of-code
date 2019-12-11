class Grid
  def initialize(str)
    @grid = str.split("\n").map { |line| line.split("") }
  end

  def asteroids
    @asteroids ||= begin
      res = []
      @grid.each_index do |y|
        @grid[y].each_index do |x|
          res << [x, y] if @grid[y][x] == "#"
        end
      end
      res.sort
    end
  end

  def count(x1, y1)
    asteroids.map { |x2, y2| Math.atan2(y2 - y1, x2 - x1) }.uniq.count
  end

  def best_location
    asteroids.max_by { |x, y| count(x, y) }
  end

  def vaporized_from(x1, y1)
    h = {}
    asteroids.each do |x2, y2|
      k = ((Math.atan2(y2 - y1, x2 - x1) * 180 / Math::PI) + 90) % 360
      (h[k] ||= []) << [x2, y2] unless x1 == x2 && y1 == y2
    end

    h = h.sort_by do |k, v|
      v.sort_by! do |x2, y2|
        (x2 - x1)**2 + (y2 - y1)**2
      end
      k
    end.to_h

    res = []
    while h.values.flatten.compact.count > 0
      h.each do |k, v|
        if v.count > 0
          res << v.shift
        end
      end
    end
    res
  end
end
