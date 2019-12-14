class Chemical
  attr_accessor :quantity, :name

  def initialize(str)
    quantity, name = str.split
    @quantity = quantity.to_i
    @name = name
  end
end

class Reaction
  attr_accessor :inputs, :output

  def initialize(str)
    inputs, output = str.split(" => ")

    @inputs = inputs.split(", ").map { |input| Chemical.new(input) }
    @output = Chemical.new(output)
  end
end

class NanoFactory
  attr_accessor :reactions

  def initialize(str)
    @reactions = {}
    str.each_line do |line|
      reaction = Reaction.new(line)
      @reactions[reaction.output.name] = [reaction.output.quantity, reaction.inputs]
    end
  end

  def cost(quantity, name, needed = {}, wasted = {})
    wasted[name] ||= 0
    needed[name] ||= 0
    reaction_quantity, inputs = @reactions[name]
    mult = [((quantity - wasted[name]) / reaction_quantity.to_f).ceil, 0].max
    if quantity < wasted[name]
      wasted[name] -= quantity
    else
      needed[name] -= wasted[name]
      wasted[name] = mult * reaction_quantity - needed[name] if name != "FUEL"
      inputs.each do |input|
        needed[input.name] ||= 0
        needed[input.name] += mult * input.quantity
        cost(input.quantity * mult, input.name, needed, wasted) if input.name != "ORE"
      end
    end
    needed[name] = 0
    needed["ORE"]
  end

  def max_fuel(n)
    (1..n).bsearch { |i| cost(i, "FUEL") > n } - 1
  end
end
