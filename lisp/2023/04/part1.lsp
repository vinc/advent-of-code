(load "/lib/lisp/core.lsp")

(def (aoc-count line) (do
  (var nums (str.split (second (str.split line ": ")) " | "))
  (var win (reject empty? (words (nth nums 0))))
  (var own (reject empty? (words (nth nums 1))))
  (var n (len (intersection win own)))
  (if (> n 0) (^ 2 (- n 1)) 0)))

(print (reduce + (map aoc-count (lines (read (first args))))))
