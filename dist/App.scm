(define-module
 (App)
 #:export
 (App)
 #:use-module
 (htmlprag)
 #:use-module
 (Counter))
(define count1 0)
(define count2 100)
(define count-with-ops
  (lambda (t-1dff1b83541ce327-1)
    (let ((c (any->string t-1dff1b83541ce327-1)))
      `(div (button (^ (id "dec")) "Minus")
            ,(Counter c)
            (button (^ (id "inc")) "Plus")))))
(define App
  (lambda ()
    (let ()
      `(div (^ (id "container"))
            ,(count-with-ops count1)
            (br)
            ,(count-with-ops count2)))))
