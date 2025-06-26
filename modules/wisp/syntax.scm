(define-module (wisp syntax)
  #:export (@map))

(define @map (lambda (proc sig) `(@map ,proc ,sig)))
