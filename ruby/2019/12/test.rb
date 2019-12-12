require "test/unit"
require_relative "./lib.rb"

class TestDay12 < Test::Unit::TestCase
  def test_part_1
    input = <<~INPUT
      <x=-1, y=0, z=2>
      <x=2, y=-10, z=-7>
      <x=4, y=-8, z=8>
      <x=3, y=5, z=-1>
    INPUT

    simulation = Simulation.new(input)

    assert_equal("pos=<x= -1, y=  0, z=  2>, vel=<x=  0, y=  0, z=  0>", simulation.moons[0].to_s)
    assert_equal("pos=<x=  2, y=-10, z= -7>, vel=<x=  0, y=  0, z=  0>", simulation.moons[1].to_s)
    assert_equal("pos=<x=  4, y= -8, z=  8>, vel=<x=  0, y=  0, z=  0>", simulation.moons[2].to_s)
    assert_equal("pos=<x=  3, y=  5, z= -1>, vel=<x=  0, y=  0, z=  0>", simulation.moons[3].to_s)

    simulation.steps(1)

    assert_equal("pos=<x=  2, y= -1, z=  1>, vel=<x=  3, y= -1, z= -1>", simulation.moons[0].to_s)
    assert_equal("pos=<x=  3, y= -7, z= -4>, vel=<x=  1, y=  3, z=  3>", simulation.moons[1].to_s)
    assert_equal("pos=<x=  1, y= -7, z=  5>, vel=<x= -3, y=  1, z= -3>", simulation.moons[2].to_s)
    assert_equal("pos=<x=  2, y=  2, z=  0>, vel=<x= -1, y= -3, z=  1>", simulation.moons[3].to_s)

    simulation.steps(9)

    assert_equal("pos=<x=  2, y=  1, z= -3>, vel=<x= -3, y= -2, z=  1>", simulation.moons[0].to_s)
    assert_equal("pos=<x=  1, y= -8, z=  0>, vel=<x= -1, y=  1, z=  3>", simulation.moons[1].to_s)
    assert_equal("pos=<x=  3, y= -6, z=  1>, vel=<x=  3, y=  2, z= -3>", simulation.moons[2].to_s)
    assert_equal("pos=<x=  2, y=  0, z=  4>, vel=<x=  1, y= -1, z= -1>", simulation.moons[3].to_s)

    assert_equal(179, simulation.total_energy)
  end

  def test_part_2
    # Example 1
    input = <<~INPUT
      <x=-1, y=0, z=2>
      <x=2, y=-10, z=-7>
      <x=4, y=-8, z=8>
      <x=3, y=5, z=-1>
    INPUT

    simulation = Simulation.new(input)
    assert_equal(2772, simulation.cycles)

    # Example 2
    input = <<~INPUT
      <x=-8, y=-10, z=0>
      <x=5, y=5, z=10>
      <x=2, y=-7, z=3>
      <x=9, y=-8, z=-3>
    INPUT

    simulation = Simulation.new(input)
    assert_equal(4686774924, simulation.cycles)
  end
end
