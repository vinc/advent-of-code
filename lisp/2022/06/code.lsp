(load "/lib/lisp/core.lsp")

(define (find-marker s n)
  (do
    (define i 0)
    (+ (while (< (length (uniq (sort (slice s i n)))) n) (set i (+ i 1))) n)))

(define input (chars (read-file (first args))))

(println (find-marker input 4))
(println (find-marker input 14))
