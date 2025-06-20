#!/usr/local/bin/guile -s
!#

(use-modules (ice-9 pretty-print)
	     (ice-9 textual-ports))

(define export-module-syntax
  (lambda (name)
    `(define-module (,name)
       #:export (,name))))

(define use-module-syntax
  (lambda ()
    `(use-modules (dom) (htmlprag) (signal))))

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

(define wisp-string->wave-string
  (lambda (str)
    (if (string=? "wisp" str) "wave"
	str)))

(define wisp-suffix->wish-siffux
  (lambda (wisp-file-name)
    (let* ([wisp-name-list (string-split wisp-file-name #\.)]
	   [wish-name-list (map wisp-string->wish-string wisp-name-list)])
      (string-join wish-name-list "."))))
(define wisp-suffix->wave-siffux
  (lambda (wisp-file-name)
    (let* ([wisp-name-list (string-split wisp-file-name #\.)]
	   [wave-name-list (map wisp-string->wave-string wisp-name-list)])
      (string-join wave-name-list "."))))

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

(define substitute-@actions-and-&signal
  (lambda (li)
    (cond
     [(@action-pair? li) (@action-pair->data-at-action li)]
     [(&signal? li)
      (let ([sig-name (substring (symbol->string li) 1)])
	(list 'span (list '^ (list (string->symbol (string-append "data-amper-" sig-name))))
	      (list 'unquote (list 'signal-ref (string->symbol sig-name)))))]
     [(pair? li)
      (cons (substitute-@actions-and-&signal (car li))
	    (substitute-@actions-and-&signal (cdr li)))]
     [else li])))

(define &signal?
  (lambda (li)
    (and (symbol? li)
	 (string-prefix? "&" (symbol->string li)))))

(define find-&signals
  (lambda (li)
    (cond
     [(&signal? li) (list (string->symbol (substring (symbol->string li) 1)))]
     [(pair? li) (apply append (list (find-&signals (car li))
				     (find-&signals (cdr li))))]
     [else '()])))

(define define-component-syntax?
  (lambda (stx)
    (eqv? 'define-component (car (syntax->datum stx)))))

(define wisp-syntax->wave-syntax
  (lambda (wisp-syntax) wisp-syntax))

(define wisp-syntax->wish-syntax
  (lambda (wisp-syntax)
    (syntax-case wisp-syntax (define-component)
      [(define-component name (lambda (args ...) `(exp ...)))
       (let* ([exp-list (syntax->datum #'(exp ...))]
	      [exp-normalized-list (substitute-@actions-and-&signal exp-list)]
	      [&signals (find-&signals exp-list)]pp
	      [@actions (find-@actions exp-list)])
         (with-syntax ([((a-n p-n) ...) @actions]
		       [(sig ...) &signals]
		       [(final-exp-list ...) exp-normalized-list])
	   #`(define name
	       (lambda (args ...)
		 `(final-exp-list ...)))))]
      [(exp ...) #'(exp ...)])))

(define append-module-syntax
  (lambda (ori-def-stx mol-names)
    (apply append ori-def-stx
	   (map (lambda (mol-name) `(#:use-module ,mol-name)) mol-names))))

(define wisp-file->wish-and-wave-file
  (lambda (wisp-file-name)
    (call-with-input-file wisp-file-name
      (lambda (wisp-inport)
	(call-with-output-file (wisp-suffix->wish-siffux wisp-file-name)
	  (lambda (wish-outport)
	    (call-with-output-file (wisp-suffix->wave-siffux wisp-file-name)
	      (lambda (wave-outport)
		(pretty-print (use-module-syntax) wave-outport)
		(let ([first-syntax (read-syntax wisp-inport)])
		  (if (import-component-syntax? first-syntax)
		      (pretty-print (append-module-syntax (export-module-syntax (string->symbol (filename wisp-file-name))) (cadr (syntax->datum first-syntax))) wish-outport)
		      (begin
			(pretty-print (export-module-syntax (string->symbol (filename wisp-file-name))) wish-outport)
			(if (define-component-syntax? first-syntax)
			    (begin
			      (pretty-print (syntax->datum (wisp-syntax->wish-syntax first-syntax)) wish-outport)
			      (pretty-print (syntax->datum (wisp-syntax->wave-syntax first-syntax)) wave-outport))
			    (pretty-print (syntax->datum (wisp-syntax->wave-syntax first-syntax)) wave-outport)))))
		(for-each
		 (lambda (stx)
		   (if (define-component-syntax? stx)
			    (begin
			      (pretty-print (syntax->datum (wisp-syntax->wish-syntax stx)) wish-outport)
			      (pretty-print (syntax->datum (wisp-syntax->wave-syntax stx)) wave-outport))
			    (pretty-print (syntax->datum (wisp-syntax->wave-syntax stx)) wave-outport)))
		 (read-syntaxs wish-outport))))))))))

(let ([wisp-files (cdr (command-line))])
  (for-each wisp-file->wish-and-wave-file wisp-files))
