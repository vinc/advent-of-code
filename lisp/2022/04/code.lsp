(load "/lib/lisp/core.lsp")

(define (filter fn lst)
  (if (nil? lst) nil
    (if (fn (first lst))
      (cons (first lst) (filter fn (rest lst)))
      (filter fn (rest lst)))))

(define (intersection a b)
  (filter (function (x) (contains? b x)) a))

(define line "1-10,3-8")
(define pair (map (function (x) (apply range (map string->number (split x "-")))) (split line ",")))

(intersection (first pair) (second pair))


(enum-pair "1-10,3-8")
(define (enum-pair line) (map (function (x) (apply range (map string->number (split x "-")))) (split line ",")))
(define (inter-pair? pair) (not (nil? (intersection (first pair) (second pair)))))

(map (fun (x) (inter-pair? (enum-pair x))) (lines (read-file "test.txt")))

(apply + (map (fun (x) (if (inter-pair? (enum-pair x)) 1 0)) (lines (read-file "test.txt"))))
