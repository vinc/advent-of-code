class FFT
  PATTERN = [0, 1, 0, -1].freeze

  def initialize(input)
    @input = input
    @size = @input.size
  end

  def phase(n, offset: 0)
    @signal = @input.dup
    n.times do |step|
      @size.times.each { |i| @signal.setbyte(i, 48 + output(i + 1)) }
      yield(step + 1, @signal.slice(offset, 8)) if block_given?
    end
    @signal.slice(offset, 8)
  end

  def output(n)
    pattern = repeat_pattern(n)
    @size.times.reduce(0) do |s, i|
      s + @signal[i].to_i * pattern[i]
    end.abs % 10
  end

  def repeat_pattern(n)
    @repeat_pattern ||= []
    @repeat_pattern[n] ||= begin
      repeat = PATTERN.map { |d| [d] * n }.flatten
      (@size + 1).times.map do |i|
        repeat[i % repeat.size]
      end.slice(1, @size)
    end
  end
end
