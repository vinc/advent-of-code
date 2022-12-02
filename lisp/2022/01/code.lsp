(load "/lib/lisp/core.lsp")

(define (aoc lst acc)
  (if (nil? lst)
    (list acc)
    (if (= (first lst) 0)
      (cons acc (aoc (rest lst) 0))
      (aoc (rest lst) (+ (first lst) acc)))))

(define (read-input path)
  (map
    (fun (line) (string->number line))
    (lines (read-file path))))

(define (part1 lst)
  (first lst))

(define (part2 lst)
  (apply + (slice lst 0 2)))

(define input (read-input (first args)))
(define output (reverse (sort (aoc input 0))))
(println (part1 output))
(println (part2 output))
