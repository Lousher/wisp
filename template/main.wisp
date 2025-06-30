(use-modules (App) (shtml) (cssom) (dom))

((shtml-parse (App)) (get-element-by-id "app"))

(let ([s (create-css-style-sheet '())])
  (insert-rule s ".w-40 { height: 40 rem; background-color: blue; }")
  (document-adopted-style-sheets s))



