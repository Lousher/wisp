(define-module
 (App)
 #:export
 (App)
 #:use-module
 (dom)
 #:use-module
 (signal)
 #:use-module
 (htmlprag))
(define-signal (count next) 114514)
(define increment (lambda (event) (next #{1+}#)))
(define decrement (lambda (event) (next #{1-}#)))
(begin
  (define App
    (case-lambda
     ((type)
      (cond
        ((eqv? 'shtml type)
         (lambda ()
           `(div (button (^ (data-at-click "decrement")) "Minus")
                 (span (span (^ (data-amper-count)) ,(signal-ref count)))
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
            (list (cons '@click decrement) (cons '@click increment)))
           (signal-effect
            (lambda ()
              (text-content
               (query-selector (format #f "[data-amper-~a]" 'count))
               (any->string (signal-ref count))))))))))))
