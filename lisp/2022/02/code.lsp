(load "/lib/lisp/core.lsp")

(define (part1 line)
  (cond
    ((eq line "A X") (+ 1 3))
    ((eq line "A Y") (+ 2 6))
    ((eq line "A Z") (+ 3 0))
    ((eq line "B X") (+ 1 0))
    ((eq line "B Y") (+ 2 3))
    ((eq line "B Z") (+ 3 6))
    ((eq line "C X") (+ 1 6))
    ((eq line "C Y") (+ 2 0))
    ((eq line "C Z") (+ 3 3))))

(println (apply + (map part1 (lines (read-file (first args))))))

(define (part2 line)
  (cond
    ((eq line "A X") (+ 3 0))
    ((eq line "A Y") (+ 1 3))
    ((eq line "A Z") (+ 2 6))
    ((eq line "B X") (+ 1 0))
    ((eq line "B Y") (+ 2 3))
    ((eq line "B Z") (+ 3 6))
    ((eq line "C X") (+ 2 0))
    ((eq line "C Y") (+ 3 3))
    ((eq line "C Z") (+ 1 6))))

(println (apply + (map part2 (lines (read-file (first args))))))
