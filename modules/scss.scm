(define-module (scss)
  #:export (scss-attribute->css-style))

(define SCSS_STYLES
  '(("bg-red-200" ".bg-red-200 { background-color: red; }")
    ("w-40" ".w-40 { width: 160rem; }")))

(define scss-attribute->css-style
  (lambda (scss-attr)
    (cadr (assoc scss-attr SCSS_STYLES))))

