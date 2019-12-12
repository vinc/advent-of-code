class Simulation
  attr_accessor :moons

  class Moon
    attr_accessor :position, :velocity
    attr_accessor :initial_position, :initial_velocity

    def initialize(position)
      @position = position
      @velocity = [0, 0, 0]
      @initial_position = @position.dup
      @initial_velocity = @velocity.dup
    end

    def to_s
      pos = format("pos=<x=%3d, y=%3d, z=%3d>", *position)
      vel = format("vel=<x=%3d, y=%3d, z=%3d>", *velocity)
      [pos, vel].join(", ")
    end

    def potential_energy
      position.map(&:abs).sum
    end

    def kinetic_energy
      velocity.map(&:abs).sum
    end
  
    def total_energy
      potential_energy * kinetic_energy
    end
  end

  def initialize(str)
    @moons = []
    str.each_line do |line|
      @moons << Moon.new(line.scan(/-?\d+/).map(&:to_i))
    end
  end

  def steps(n)
    n.times do
      apply_gravity
      apply_velocity
    end
  end

  def apply_gravity
    moons.each do |a|
      moons.each do |b|
        next if a == b

        (0..2).each do |i|
          if a.position[i] < b.position[i]
            a.velocity[i] += 1
          elsif a.position[i] > b.position[i]
            a.velocity[i] -= 1
          end
        end
      end
    end
  end

  def apply_velocity
    moons.each do |a|
      (0..2).each do |i|
        a.position[i] += a.velocity[i]
      end
    end
  end

  def total_energy
    moons.map(&:total_energy).sum
  end

  def to_s
    moons.map(&:to_s).join("\n")
  end

  def cycles
    cycles = [nil, nil, nil]

    (1..).each do |step|
      break if cycles.compact.count == 3
      steps(1)
      (0..2).each do |i|
        next unless moons.all? do |m|
          m.position[i] == m.initial_position[i] && m.velocity[i] == m.initial_velocity[i]
        end
        cycles[i] ||= step
      end
    end

    cycles.reduce(1, :lcm)
  end
end
