require "test/unit"
require_relative "./lib.rb"

class TestDay16 < Test::Unit::TestCase
  def test_1
    input = "12345678"
    signal = FFT.new(input)
    assert_equal([1,  0, -1,  0,  1,  0, -1,  0], 8.times.map { |i| signal.repeating_pattern(1, i) })
    assert_equal([0,  1,  1,  0,  0, -1, -1,  0], 8.times.map { |i| signal.repeating_pattern(2, i) })
    assert_equal("48226158", signal.phase(1))
    assert_equal("34040438", signal.phase(2))
    assert_equal("03415518", signal.phase(3))
  end

  def test_2
    assert_equal("24176176", FFT.new("80871224585914546619083218645595").phase(100))
    assert_equal("73745418", FFT.new("19617804207202209144916044189917").phase(100))
    assert_equal("52432133", FFT.new("69317163492948606335995924319873").phase(100))
    assert_equal(  "43213329", FFT.new("69317163492948606335995924319873").phase(100, offset: 2))
  end

  def test_3
    input = (["03036732577212944063491565474664"] * 10_000).join
    assert_equal("84462026", FFT.new(input).phase(100, offset: input[0..6].to_i))

    input = (["02935109699940807407585447034323"] * 10_000).join
    assert_equal("78725270", FFT.new(input).phase(100, offset: input[0..6].to_i))

    input = (["03081770884921959731165446850517"] * 10_000).join
    assert_equal("53553731", FFT.new(input).phase(100, offset: input[0..6].to_i))
  end
end
