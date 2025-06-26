(define-module (Span)
  #:use-module (signal)
  #:export (Span))

(define Span
  (lambda (c)
    `(span (^ (data-test-id ,c)) ,c)))

