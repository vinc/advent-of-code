class FFT
  PATTERN = [0, 1, 0, -1].freeze

  def initialize(input)
    @input = input
    @size = @input.size
  end

  def phase(n, offset: 0)
    @signal = @input.dup
    n.times do |step|
      (offset...@size).each do |i|
        @signal.setbyte(i, 48 + output(i + 1))
      end
      yield(step + 1, @signal.slice(offset, 8)) if block_given?
    end
    @signal.slice(offset, 8)
  end

  def output(n, offset: 0)
    (offset...@size).reduce(0) do |s, i|
      s + @signal[i].to_i * repeating_pattern(n, i)
    end.abs % 10
  end

  def repeating_pattern(n, i)
    PATTERN[((i + 1) / n) % PATTERN.size]
  end
end
