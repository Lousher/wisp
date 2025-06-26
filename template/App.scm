(define-module (App)
  #:use-module (dom)
  #:use-module (signal)
  #:export (App))

(define-signal (count set-count-next) 0)

(define MSG "with Scheme Repl system, data is code and code is data")

(define test (lambda (event)
	       (console-log event)))

(define dec (lambda (event) (set-count-next 1-)))
(define inc (lambda (event) (set-count-next 1+)))

(define App
  `(section (^ (id "data-test-id"))
	    (button (^ (@click ,dec)) "Minus")
	    (h2 ,count)
	    (button (^ (@click ,inc)) "Plus")))







