(define-signal (count next) 114514)

(define increment
  (lambda (event) (next 1+)))

(define decrement
  (lambda (event) (next 1-)))

(define-component App
  (lambda ()
    `(div
      (button (^ (@click decrement)) "Minus")
      (span &count)
      (button (^ (@click increment)) "Plus"))))
