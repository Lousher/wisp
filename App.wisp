(define count 0)

(define increment
  (lambda () (set! count (+ count 1))))
    
(define-component App
  (lambda ()
    `(div
      (button (^ (id "dec")) "Minus")
      (span ,count)
      (button (^ (click "increment")) "Plus"))))
