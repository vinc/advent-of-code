(load "/lib/lisp/core.lsp")

(def (contains? x lst)
  (if (nil? lst) false
    (if (eq? x (head lst)) true
      (contains? c (tail lst)))))

(def (aoc-two-digits line) (do
  (var digits
    (filter
      (fun (c)
        (contains? c (chars "0123456789")))
      (chars line)))
  (str->num (str.join (list (first digits) (last digits)) ""))))

(print (reduce +
  (map aoc-two-digits (lines (read "input.txt")))))
