(define-module (App)
  #:use-module (signal)
  #:use-module (wisp syntax)
  #:use-module (Sticky)
  #:export (App))

(define App
  (lambda ()
    `(div (^ (class "container mx-auto p-8"))
	  ,(@map Sticky (list "Test" "Hello")))))

