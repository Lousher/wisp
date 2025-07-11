(define-module (App)
  #:export (App)
  #:use-module (signal))

(define-signal (count set-next-count) 0)
(define inc (lambda (e) (set-next-count 1+)))
(define dec (lambda (e) (set-next-count 1-)))

(define App
  (lambda ()
    `(div
      (button (^ (@click ,dec)) "Minus")
      (h1 ,count)
      (button (^ (@click ,inc)) "Plus"))))
