(define-module (App)
  #:export (App)
  #:use-module (Span)
  #:use-module (signal))

(define-signal (count set-next-count) 0)
(define inc (lambda (event) (set-next-count 1+)))
(define dec (lambda (event) (set-next-count 1-)))

(define App
  (lambda ()
    `(section
      (button (^ (@click ,dec)) "Minus")
      ,(Span count)
      (button (^ (@click ,inc)) "Plus"))))
