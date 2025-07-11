(define-module (signal)
  #:use-module (hoot boxes)
  #:use-module (srfi srfi-9)
  #:export (signal-init
	    signal-ref
	    signal-set!
	    signal?
	    define-signal
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
    (make-signal (make-box value) '())))

(define-syntax define-signal
  (syntax-rules ()
    [(_ (name set-next) init)
     (define-values (name set-next)
       (values
	(signal-init init)
	(lambda (fn) (signal-next! name fn))))
     ]))

(define signal-ref
  (lambda (sig)
    (let ([cur (*CURRENT-EFFECT*)])
      (when cur
	(signal-listeners-set! sig (cons cur (signal-listeners sig)))))
    (box-ref (signal-box sig))))

(define signal-next!
  (lambda (sig fn)
    (let ([sig-box (signal-box sig)]
	  [sig-liss (signal-listeners sig)])
      (box-set! sig-box (fn (signal-ref sig)))
      (for-each (lambda (fn) (fn)) sig-liss))))
		
(define signal-set!
  (lambda (sig updated)
    (let ([sig-box (signal-box sig)]
	  [sig-liss (signal-listeners sig)])
      (box-set! sig-box updated)
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
