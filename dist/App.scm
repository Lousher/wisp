(define-module (App) #:export (App) #:use-module (dom) #:use-module (htmlprag))
(define count 0)
(define increment (lambda (event) (set! count (+ count 1))))
(define decrement (lambda (event) (set! count (- count 1))))
(begin
  (define App
    (case-lambda
     ((type)
      (cond
        ((eqv? 'shtml type)
         (lambda ()
           `(div (button (^ (data-at-click "decrement")) "Minus")
                 (span ,count)
                 (button (^ (data-at-click "increment")) "Plus"))))
        ((eqv? 'event type)
         (lambda ()
           (for-each
            (lambda (ac-pair)
              (let ((a-name (substring (symbol->string (car ac-pair)) 1)))
                (add-event-listener!
                 (query-selector
                  (format
                   #f
                   "[data-at-~a=\"~a\"]"
                   a-name
                   (procedure-name (cdr ac-pair))))
                 a-name
                 (procedure->external (cdr ac-pair)))))
            (list (cons '@click decrement) (cons '@click increment))))))))))
