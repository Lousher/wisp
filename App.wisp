
(define-signal (count next) 114514)

(define increment
  (lambda (event)
      (next 1+)))

(define decrement
  (lambda (event) (next 1-)))

(define reset
  (lambda (event) (next (lambda (c) 0))))

(define-component App
  (lambda ()
    `(div
      (button (^ (@click reset)) "Reset")
      (button (^ (@click decrement)) "Minus")
      (span &count)
      (button (^ (@click increment)) "Plus"))))
