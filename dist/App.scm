(define-module (App)
  #:use-module (signal)
  #:export (App))

(define-signal (count set-count-next) 0)
(define inc (lambda (event) (set-count-next 1+)))
(define dec (lambda (event) (set-count-next 1-)))

(define h2-count
  (lambda (c)
    `(empty
      (h2 ,c))))

(define App
  (lambda ()
    `(empty
      (button (^ (@click ,dec) (class "bg-red-200 w-40")) "Minus")
      ,(h2-count count)
      (button (^ (@click ,inc) (class "bg-red-200")) "Plus"))))
