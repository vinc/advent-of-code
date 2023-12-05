(load "/lib/lisp/core.lsp")

(var puzzle (dict "red" 12 "green" 13 "blue" 14))

(def (aoc-cube s)
  (<= (str->num (first (words s))) (get puzzle (second (words s)))))

(def (aoc-cubes s)
  (map aoc-cube (str.split s ", ")))

(def (aoc-game s) (do
  (var game (str.split s ": "))
  (var id (str->num (second (words (first game)))))
  (var res (map aoc-cubes (str.split (second game) "; ")))
  (if (contains? (reduce concat res) false) 0 id)))

(print (reduce +
  (map aoc-game (lines (read (first args))))))
