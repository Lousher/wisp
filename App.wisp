(define count 0)

(define increment
  (lambda () (set! count (+ count 1))))
    
(define-component App
  (lambda ()
    `(div
      (button (^ (@click ,increment)) "Minus")
      (span ,count)
      (button (^ (@click ,increment)) "Plus"))))
