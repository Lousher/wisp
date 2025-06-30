(define-module (cssom)
  #:use-module (hoot ffi)
  #:export (create-css-style-sheet
	    insert-rule
	    CSS_STYLE_SHEET))

(define CSS_STYLE_SHEET (make-parameter #f))

(define-foreign create-css-style-sheet
  "cssom" "CSSStyleSheet"
  (ref eq) -> (ref extern))

(define-foreign insert-rule
  "cssom" "insertRule"
  (ref extern) (ref string) -> none)

