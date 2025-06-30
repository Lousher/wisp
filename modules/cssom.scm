(define-module (cssom)
  #:use-module (hoot ffi)
  #:export (create-css-style-sheet
	    insert-rule))


(define-foreign create-css-style-sheet
  "cssom" "CSSStyleSheet"
  (ref eq) -> (ref extern))

(define-foreign insert-rule
  "cssom" "insertRule"
  (ref extern) (ref string) -> none)

