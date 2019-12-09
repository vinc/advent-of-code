require "test/unit"
require_relative "./computer.rb"

class TestDay02Part1 < Test::Unit::TestCase
  def test_1
    program = [1,0,0,0,99]
    computer = Computer.new(program)
    computer.run
    assert_equal([2,0,0,0,99], computer.dump.first(program.size))
  end

  def test_2
    program = [2,3,0,3,99]
    computer = Computer.new(program)
    computer.run
    assert_equal([2,3,0,6,99], computer.dump.first(program.size))
  end

  def test_3
    program = [2,4,4,5,99,0]
    computer = Computer.new(program)
    computer.run
    assert_equal([2,4,4,5,99,9801], computer.dump.first(program.size))
  end

  def test_4
    program = [1,1,1,4,99,5,6,0,99]
    computer = Computer.new(program)
    computer.run
    assert_equal([30,1,1,4,2,5,6,0,99], computer.dump.first(program.size))
  end
end

class TestDay05Part1 < Test::Unit::TestCase
  def test_1
    program = [3,9,8,9,10,9,4,9,99,-1,8]
    assert_equal(0, Computer.new(program.dup).run([7]).first)
    assert_equal(1, Computer.new(program.dup).run([8]).first)
    assert_equal(0, Computer.new(program.dup).run([9]).first)
  end

  def test_2
    program = [3,9,7,9,10,9,4,9,99,-1,8]
    assert_equal(1, Computer.new(program.dup).run([7]).first)
    assert_equal(0, Computer.new(program.dup).run([8]).first)
    assert_equal(0, Computer.new(program.dup).run([9]).first)
  end

  def test_3
    program = [3,3,1108,-1,8,3,4,3,99]
    assert_equal(0, Computer.new(program.dup).run([7]).first)
    assert_equal(1, Computer.new(program.dup).run([8]).first)
    assert_equal(0, Computer.new(program.dup).run([9]).first)
  end

  def test_4
    program = [3,3,1107,-1,8,3,4,3,99]
    assert_equal(1, Computer.new(program.dup).run([7]).first)
    assert_equal(0, Computer.new(program.dup).run([8]).first)
    assert_equal(0, Computer.new(program.dup).run([9]).first)
  end
end

class TestDay09Part1 < Test::Unit::TestCase
  def test_1
    program = [
       109,   1,
       204,  -1,
      1001, 100,  1, 100,
      1008, 100, 16, 101,
      1006, 101,  0,
        99
    ]
    computer = Computer.new(program.dup)
    outputs = computer.run
    assert_equal(program, outputs)
  end

  def test_2
    program = [1102,34915192,34915192,7,4,7,99,0]
    computer = Computer.new(program.dup)
    outputs = computer.run
    assert_equal(16, outputs.first.to_s.size)
  end

  def test_3
    program = [104,1125899906842624,99]
    computer = Computer.new(program.dup)
    outputs = computer.run
    assert_equal(program[1], outputs.first)
  end
end
