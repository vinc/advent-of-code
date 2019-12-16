require "test/unit"
require_relative "./lib.rb"

class TestDay16 < Test::Unit::TestCase
  def test_1
    input = "12345678"
    signal = FFT.new(input)
    assert_equal([1,  0, -1,  0,  1,  0, -1,  0], signal.repeat_pattern(1))
    assert_equal([0,  1,  1,  0,  0, -1, -1,  0], signal.repeat_pattern(2))
    assert_equal("48226158", signal.phase(1))
    assert_equal("34040438", signal.phase(2))
    assert_equal("03415518", signal.phase(3))
  end

  def test_2
    assert(FFT.new("80871224585914546619083218645595").phase(100).start_with?("24176176"))
    assert(FFT.new("19617804207202209144916044189917").phase(100).start_with?("73745418"))
    assert(FFT.new("69317163492948606335995924319873").phase(100).start_with?("52432133"))
  end
end
