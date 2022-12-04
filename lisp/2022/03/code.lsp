(load "/lib/lisp/core.lsp")

(define (filter fn lst)
  (if (nil? lst) nil
    (if (fn (first lst))
      (cons (first lst) (filter fn (rest lst)))
      (filter fn (rest lst)))))

(define (intersection a b)
  (filter (function (x) (contains? b x)) a))

(define (priority x)
  (- x (if (> x 96) 96 38)))

(define (part1 items)
  (do
    (define items (chars items))
    (define n (/ (length items) 2))
    (apply + (map priority
      (string->bytes
        (string-join
          (intersection
            (uniq (sort (slice items 0 n)))
            (uniq (sort (slice items n n)))) ""))))))

(println (apply + (map part1 (lines (read-file (first args))))))

(define (split-items s)
  (uniq (sort (chars s))))

(define (part2 group)
  (apply + (map priority
    (string->bytes
      (string-join (reduce intersection (map split-items group)) "")))))

(println (apply + (map part2 (chunks (lines (read-file (first args))) 3))))
