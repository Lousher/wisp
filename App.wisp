(define-module (App)
  #:use-module (signal)
  #:export (App))

(define-signal (count set-count-next) 0)
(define inc (lambda (event) (set-count-next 1+)))
(define dec (lambda (event) (set-count-next 1-)))

(define App
  (lambda ()
    `(empty
      (button (^ (@click ,dec) (class "bg-red-200")) "Minus")
      (h2 ,count)
      (button (^ (@click ,inc)) "Plus"))))
