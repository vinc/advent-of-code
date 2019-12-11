require_relative "./lib.rb"

grid = Grid.new(ARGF.read)
x, y = grid.vaporized_from(*grid.best_location).at(199)
p x * 100 + y
