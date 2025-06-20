(define count 0)

(define increment
  (lambda (event) (set! count (+ count 1))))

(define decrement
  (lambda (event) (set! count (- count 1))))
    
(define-component App
  (lambda ()
    `(div
      (button (^ (@click decrement)) "Minus")
      (span ,count)
      (button (^ (@click increment)) "Plus"))))
