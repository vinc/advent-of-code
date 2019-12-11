require "test/unit"
require_relative "./lib.rb"

class TestDay10 < Test::Unit::TestCase
  def test_1
    grid = Grid.new <<~MAP
      .#..#
      .....
      #####
      ....#
      ...##
    MAP

    assert_equal(8, grid.count(3, 4))
    assert_equal([3, 4], grid.best_location)
  end

  def test_2
    grid = Grid.new <<~MAP
      ......#.#.
      #..#.#....
      ..#######.
      .#.#.###..
      .#..#.....
      ..#....#.#
      #..#....#.
      .##.#..###
      ##...#..#.
      .#....####
    MAP

    assert_equal([5, 8], grid.best_location)
    assert_equal(33, grid.count(5, 8))
  end

  def test_3
    grid = Grid.new <<~MAP
      #.#...#.#.
      .###....#.
      .#....#...
      ##.#.#.#.#
      ....#.#.#.
      .##..###.#
      ..#...##..
      ..##....##
      ......#...
      .####.###.
    MAP

    assert_equal([1, 2], grid.best_location)
    assert_equal(35, grid.count(1, 2))
  end

  def test_4
    grid = Grid.new <<~MAP
      .#..#..###
      ####.###.#
      ....###.#.
      ..###.##.#
      ##.##.#.#.
      ....###..#
      ..#.#..#.#
      #..#.#.###
      .##...##.#
      .....#.#..
    MAP

    assert_equal([6, 3], grid.best_location)
    assert_equal(41, grid.count(6, 3))
  end

  def test_5
    grid = Grid.new <<~MAP
      .#..##.###...#######
      ##.############..##.
      .#.######.########.#
      .###.#######.####.#.
      #####.##.#.##.###.##
      ..#####..#.#########
      ####################
      #.####....###.#.#.##
      ##.#################
      #####.##.###..####..
      ..######..##.#######
      ####.##.####...##..#
      .#####..#.######.###
      ##...#.##########...
      #.##########.#######
      .####.#.###.###.#.##
      ....##.##.###..#####
      .#.#.###########.###
      #.#.#.#####.####.###
      ###.##.####.##.#..##
    MAP

    assert_equal([11, 13], grid.best_location)
    assert_equal(210, grid.count(11, 13))

    # part 2
    vaporized = grid.vaporized_from(11, 13)
    assert_equal([11, 12], vaporized[0])
    assert_equal([12, 1], vaporized[1])
    assert_equal([9, 6], vaporized[198])
    assert_equal([8, 2], vaporized[199])
    assert_equal([10, 9], vaporized[200])
    assert_equal([11, 1], vaporized[298])
  end

  def test_6
    grid = Grid.new <<~MAP
      .#....#####...#..
      ##...##.#####..##
      ##...#...#.#####.
      ..#.....#...###..
      ..#.#.....#....##
    MAP

    vaporized = grid.vaporized_from(8, 3)
  end
end
