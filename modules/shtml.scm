(define-module (shtml)
  #:export (shtml-parse)
  #:use-module (ice-9 match)
  #:use-module (signal)
  #:use-module (dom))

(define @action-symbol?
  (lambda (sym)
    (and (symbol? sym)
	 (string-prefix? "@" (symbol->string sym)))))

(define @action-name
  (lambda (@act-sym)
    (substring (symbol->string @act-sym) 1)))

(define any->string
  (lambda (item)
    (if (string? item) item
	(object->string item))))


(define shtml-parse
  (lambda (exp)
    (match exp
      ((? signal? sig)
       (lambda (anchor)
	 (signal-effect (lambda () (text-content anchor (any->string (signal-ref sig)))))))
      ((? string? str)
       (lambda (anchor) (text-content anchor str)))
      (((? symbol? tag) . body)
       (let ([elem (create-element (symbol->string tag))])
	 (define add-childern!
	   (lambda (children)
	       (for-each (lambda (child) ((shtml-parse child) elem)) children)))
	 (match body
	   ((('^ . attrs) . children)
	    (for-each (lambda (attr) (match attr
				       (((? @action-symbol? act-name) (? procedure? proc))
					(add-event-listener! elem (@action-name act-name) (procedure->external proc)))
				       (((? symbol? attr-name) (? string? attr-value))
					(set-attribute! elem (symbol->string attr-name) attr-value))))

		      attrs)
	    (add-childern! children))
	   (pure-children (add-childern! pure-children)))
	 (lambda (anchor) (append-child! anchor elem)))))))
