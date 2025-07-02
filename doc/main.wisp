(use-modules (App) (shtml) (cssom) (dom))


(parameterize
    ([CSS_STYLE_SHEET (create-css-style-sheet '())])
  (document-adopted-style-sheets (CSS_STYLE_SHEET))
  ((shtml-parse (App)) (get-element-by-id "app")))

