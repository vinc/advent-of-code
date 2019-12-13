require "tty-prompt"
require "rainbow/refinement"

require_relative "./computer.rb"

using Rainbow

def rainbow(freq, i)
   r = Math.sin(freq * i + 0) * 127 + 128
   g = Math.sin(freq * i + 2 * Math::PI / 3) * 127 + 128
   b = Math.sin(freq * i + 4 * Math::PI / 3) * 127 + 128
   format("#%02X%02X%02X", r, g, b)
end

def tile(code)
  case code
    when 0 then " " # empty
    when 1 then "#" # wall
    when 2 then "X" # block
    when 3 then "=".bold.red # paddle
    when 4 then "o".bold.red # ball
  end
end

prompt = TTY::Prompt.new

autoplay = ARGV.shift == "autoplay"
speed = (ARGV.shift || "0.4").to_f
score = 0
loop do
  screen = Array.new(23).map { Array.new }
  program = File.read(File.join(__dir__, "input")).split(",").map(&:to_i)
  program[0] = 2 # Play for free
  computer = Computer.new(program.dup)
  # computer.debug = true
  until computer.halted?
    computer.run do |outputs|
      if outputs
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

        term = "\e[H\e[2J"
        term += screen[0].join + "\n"
        term += format("%s %s %s\n", tile(1), score.to_s.center(screen[0].size - 4).bold.red, tile(1))
        term += screen.each_with_index.reduce("") do |r, (l, i)|
          if 1 < i && i < 17
            r + l.join.gsub("X", "X".color(rainbow(0.3, i))) + "\n"
          else
            r + l.join + "\n"
          end
        end
        puts term
      end

      if autoplay
        sleep speed
        if xp > xb
          -1
        elsif xp == xb
          0
        else
          1
        end
      else
        #start = Time.now.to_f
        case prompt.keypress(timeout: speed)
          when "\e[D" then -1
          when "\e[C" then 1
          else 0
        end
        #duration = Time.now.to_f - start
        #sleep [speed - duration, 0].max
      end
    end
  end
  case prompt.keypress("Play again? [Y/n]")
    when "\r", "y" then next
    else break
  end
end
