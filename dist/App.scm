(define-module (App) #:export (App) #:use-module (htmlprag))
(define count 0)
(define increment (lambda () (set! count (+ count 1))))
(define App
  (lambda ()
    `(div (button (^ (id "dec")) "Minus")
          (span ,count)
          (button (^ (click "increment")) "Plus"))))
