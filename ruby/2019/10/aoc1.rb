require_relative "./lib.rb"

grid = Grid.new(ARGF.read)

p grid.count(*grid.best_location)
