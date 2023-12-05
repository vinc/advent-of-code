(load "/lib/lisp/core.lsp")

(var line "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green")
(var games (str.split (second (str.split line ": ")) "; "))
(map (fun (game) (map words (str.split game ", "))) games)

(def (check line) (do
  (var id (str->num (second (words (first (str.split line ": "))))))
  (var games (str.split (second (str.split line ": ")) "; "))
  (map (fun (game) (map words (str.split game ", "))) games)

