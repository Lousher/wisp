(define-module (App)
  #:use-module (signal)
  #:export (App))

(define-signal (count set-nex-count) 0)
(define inc (lambda (e) (set-nex-count 1+)))
(define dec (lambda (e) (set-nex-count 1-)))

(define App
  (lambda ()
    `(section
      (button (^ (@click ,dec) (class "bg-red-200 w-40")) "Minus")
      (h2 ,count)
      (button (^ (@click ,inc) (class "bg-red-200")) "Plus"))))


