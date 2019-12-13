require "tty-prompt"
require "rainbow/refinement"

require_relative "./computer.rb"

using Rainbow

def tile(code)
  case code
    when 0 then " " # empty
    when 1 then "#" # wall
    when 2 then "X" # block
    when 3 then "=".bold.red # paddle
    when 4 then "o".bold.red # ball
  end
end

def rainbow(freq, i)
   r = Math.sin(freq * i + 0) * 127 + 128
   g = Math.sin(freq * i + 2 * Math::PI / 3) * 127 + 128
   b = Math.sin(freq * i + 4 * Math::PI / 3) * 127 + 128
   format("#%02X%02X%02X", r, g, b)
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
      puts format("%s %s %s", tile(1), score.to_s.center(screen[0].size - 4).bold.red, tile(1))
      screen.each_with_index do |line, i|
        if 1 < i && i < 17
          puts line.join.gsub("X", "X".color(rainbow(0.3, i)))
        else
          puts line.join
        end
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
