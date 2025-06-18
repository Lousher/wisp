(define-module (signal)
  #:use-module (srfi srfi-111)
  #:use-module (srfi srfi-9)
  #:export (signal-init
	    signal-ref
	    signal-set!
	    signal-computed
	    signal-effect))

(define-record-type <signal>
  (make-signal box listeners)
  signal?
  (box signal-box)
  (listeners signal-listeners signal-listeners-set!))

(define *CURRENT-EFFECT* (make-parameter #f))

(define signal-init
  (lambda (value)
    (make-signal (box value) '())))

(define signal-ref
  (lambda (sig)
    (let ([cur (*CURRENT-EFFECT*)])
      (when cur
	(signal-listeners-set! sig (cons cur (signal-listeners sig)))))
    (unbox (signal-box sig))))

(define signal-set!
  (lambda (sig updated)
    (let ([sig-box (signal-box sig)]
	  [sig-liss (signal-listeners sig)])
      (set-box! sig-box updated)
      (for-each (lambda (fn) (fn)) sig-liss))))

(define signal-effect
  (lambda (fn)
    (parameterize ([*CURRENT-EFFECT* fn])
      (fn))))

(define signal-computed
  (lambda (fn)
    (let ([memo (signal-init #f)])
      (signal-effect (lambda () (signal-set! memo (fn))))
      memo)))
