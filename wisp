#!/usr/local/bin/guile -s
!#
#|(define-module (wisp compile)
#:use-module (ice-9 pretty-print)
#:use-module (ice-9 textual-ports)
#:export (wisp-file->wish-file)) |#

(use-modules (ice-9 pretty-print)
	     (ice-9 textual-ports))

(define export-module-syntax
  (lambda (name)
    `(define-module (,name)
       #:export (,name)
       #:use-module (dom)
       #:use-module (htmlprag))))

(define read-syntaxs
  (lambda (port)
    (let ([syn (read-syntax port)])
      (if (eof-object? syn) '()
	  (cons syn (read-syntaxs port))))))

(define filename
  (lambda (path)
    (car (string-split (basename path) #\.))))

(define wisp-string->wish-string
  (lambda (str)
    (if (string=? "wisp" str) "wish"
	str)))

(define wisp-suffix->wish-siffux
  (lambda (wisp-file-name)
    (let* ([wisp-name-list (string-split wisp-file-name #\.)]
	   [wish-name-list (map wisp-string->wish-string wisp-name-list)])
      (string-join wish-name-list "."))))

(define import-component-syntax?
  (lambda (stx)
    (eqv? 'import-component (car (syntax->datum stx)))))

(define any->string
  (lambda (obj)
    (if (string? obj) obj
	(object->string obj))))

(define @action-pair?
  (lambda (li)
    (and (pair? li)
	 (= 2 (length li))
	 (eqv? #\@ (string-ref (object->string (car li)) 0)))))

(define data-at-action-pair?
  (lambda (li)
    (and (pair? li)
	 (= 2 (length li))
	 (string? (car li))
	 (string? (cadr li))
	 (string-prefix? "data-at" (car li)))))

(define find-@actions
  (lambda (li)
    (cond
     [(@action-pair? li) (list li)]
     [(pair? li)
      (apply append
	     (list (find-@actions (car li))
		   (find-@actions (cdr li))))]
     [else '()])))

(define @action-pair->data-at-action
  (lambda (acp)
    (let ([@act-id (car acp)]
	  [proc-name (cadr acp)])
      (list (string->symbol (string-append "data-at-" (substring (symbol->string @act-id) 1)))
	    (symbol->string proc-name)))))

(define substitute-@actions
  (lambda (li)
    (cond
     [(@action-pair? li) (@action-pair->data-at-action li)]
     [(pair? li)
      (cons (substitute-@actions (car li))
	    (substitute-@actions (cdr li)))]
     [else li])))

(define wisp-syntax->wish-syntax
  (lambda (wisp-syntax)
    (syntax-case wisp-syntax ()
      [(define-component name (lambda (args ...) `(exp ...)))
       (let* ([exp-list (syntax->datum #'(exp ...))]
	      [exp-normalized-list (substitute-@actions exp-list)]
	      [@actions (find-@actions exp-list)])
         (with-syntax ([((a-n p-n) ...) @actions]
		       [(final-exp-list ...) exp-normalized-list])
	   #`(begin
	       (define name
		 (case-lambda
		   [(type) (cond
			  [(eqv? 'shtml type) (lambda (args ...)
					   `(final-exp-list ...))]
			  [(eqv? 'event type) (lambda () (for-each
						     (lambda (ac-pair)
						       (let ([a-name (substring (symbol->string (car ac-pair)) 1)])
							 (add-event-listener!
							  (query-selector (format #f "[data-at-~a=\"~a\"]" a-name (procedure-name (cdr ac-pair))))
							  a-name
							  (procedure->external (cdr ac-pair)))))
						     (list (cons 'a-n p-n) ...)))])])))))]
      [(exp ...) #'(exp ...)])))

(define wisp-file->wish-file
  (lambda (wisp-file-name)
    (call-with-input-file wisp-file-name
      (lambda (inport)
	(call-with-output-file (wisp-suffix->wish-siffux wisp-file-name)
	  (lambda (outport)
	    (let ([first-syntax (read-syntax inport)])
	      (if (import-component-syntax? first-syntax)
		  (pretty-print
		   (append (export-module-syntax (string->symbol (filename wisp-file-name)))
			   (apply append (map (lambda (comp) `(#:use-module ,(list comp))) (cadr (syntax->datum first-syntax)))))
		   outport)
		  (begin
		    (pretty-print
		     (export-module-syntax (string->symbol (filename wisp-file-name))) outport)
		    (pretty-print
		     (syntax->datum (wisp-syntax->wish-syntax first-syntax)) outport))))
	    (for-each
	     (lambda (wisp-syntax)
	       (pretty-print
		(syntax->datum
		 (wisp-syntax->wish-syntax wisp-syntax))
		outport))
	     (read-syntaxs inport))))))))


(let ([wisp-files (cdr (command-line))])
  (for-each wisp-file->wish-file wisp-files))
