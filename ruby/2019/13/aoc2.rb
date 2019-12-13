require "tty-prompt"

require_relative "./computer.rb"

def tile(code)
  case code
    when 0 then " " # empty
    when 1 then "#" # wall
    when 2 then "X" # block
    when 3 then "-" # paddle
    when 4 then "o" # ball
  end
end

screen = Array.new(23).map { Array.new }
prompt = TTY::Prompt.new

program = File.read(File.join(__dir__, "input")).split(",").map(&:to_i)
program[0] = 2 # Play for free
computer = Computer.new(program.dup)
# computer.debug = true
autoplay = true
until computer.halted?
  computer.run do |outputs|
    if outputs
      score = 0
      xb = 0
      xp = 0

      outputs.each_slice(3) do |x, y, t|
        if x == -1 && y == 0
          score = t
        else
          screen[y][x] = tile(t)

          case t
            when 3 then xp = x
            when 4 then xb = x
          end
        end
      end

      puts "\e[H\e[2J"
      puts screen[0].join
      puts format("%s %s %s", tile(1), score.to_s.center(screen[0].size - 4), tile(1))
      screen.each do |line|
        puts line.join
      end
    end

    if autoplay
      sleep 0.1
      if xp > xb
        -1
      elsif xp == xb
        0
      else
        1
      end
    else
      case prompt.keypress
        when "\e[D" then -1
        when " "    then 0
        when "\e[C" then 1
        else
      end
    end
  end
end
