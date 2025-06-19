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

(define wisp-syntax->wish-syntax
  (lambda (wisp-syntax)
    (syntax-case wisp-syntax ()
      [(define-component name (lambda () `(exp ...)))
       #'(define name (lambda () (shtml->html `(exp ...))))]
      [(exp ...) #'(exp ...)])))

(define wisp-file->wish-file
  (lambda (wisp-file-name)
    (call-with-output-file (wisp-suffix->wish-siffux wisp-file-name)
      (lambda (port)
	(pretty-print (export-module-syntax (string->symbol (filename wisp-file-name))) port)
	(for-each
	 (lambda (wisp-syntax)
	   (pretty-print
	    (syntax->datum
	     (wisp-syntax->wish-syntax wisp-syntax)) port))
	 (call-with-input-file wisp-file-name read-syntaxs))))))

(let ([wisp-files (cdr (command-line))])
  (for-each wisp-file->wish-file wisp-files))
	 
	

