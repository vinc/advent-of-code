lines = ARGF.read.split("\n")
n = lines[0].length / 3 - 1
m = lines.find_index { |line| line.start_with? " 1" } - 1
(1..2).each do |part|
  board = (0..n).map { |i| (0..m).map { |j| lines[j][1 + i * 4] }.filter { |c| c != " " }.reverse }
  lines[(m + 3)..].map { |line| line.split(" ").map(&:to_i) }.each do |cmd|
    k, i, j = cmd[1], cmd[3], cmd[5]
    (part == 1 ? k : 1).times { board[j - 1] += board[i - 1].pop(part != 1 ? k : 1) }
  end
  puts board.map { |stack| stack.pop }.join
end
