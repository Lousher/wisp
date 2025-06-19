(import-component (Counter))

(define count1 0)
(define count2 100)

(define-component count-with-ops
  (lambda (c)
    `(div
      (button (^ (id "dec")) "Minus")
      ,(Counter c)
      (button (^ (id "inc")) "Plus"))))
     
(define-component App
  (lambda ()
    `(div (^ (id "container"))
	 ,(count-with-ops count1)
	 (br)
	 ,(count-with-ops count2))))


