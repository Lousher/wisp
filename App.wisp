(define-module (App)
  #:export (App)
  #:use-module (signal))

(define-signal (count set-next-count) 0)
(define inc (lambda (event) (set-next-count 1+)))
(define dec (lambda (event) (set-next-count 1-)))

(define App
  `(section
    (button (^ (@click ,dec)) "Minus")
    (h2 ,count)
    (button (^ (@click ,inc)) "Plus")))
