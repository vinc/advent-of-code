(load "/lib/lisp/core.lsp")

(define (aoc input)
  (reverse (sort (map
    (fun (elf)
      (apply + (map string->number (split elf "\n"))))
    (split (trim (read-file input)) "\n\n")))))

(define output (aoc (first args)))
(println (first output))
(println (apply + (slice output 0 2)))
