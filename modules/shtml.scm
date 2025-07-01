(define-module (shtml)
  #:export (shtml-parse)
  #:use-module (cssom)
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

(define @map?
  (lambda (sym)
    (and (symbol? sym)
	 (eqv? '@map sym))))

(define symbol-empty?
  (lambda (sym)
    (and (symbol? sym)
	 (eqv? 'empty sym))))

(define class-symbol?
  (lambda (sym)
    (and (symbol? sym)
	 (eqv? 'class sym))))

(define attribute-parse
  (lambda (elem attr)
    (match attr
      (((? @action-symbol? act-name) (? procedure? proc))
       (add-event-listener! elem (@action-name act-name) (procedure->external proc)))
      (((? class-symbol? class-attr) (? string? scss-attr-values))
       (set-attribute! elem (symbol->string class-attr) scss-attr-values))
      (((? symbol? attr-name) (? string? attr-value))
       (set-attribute! elem (symbol->string attr-name) attr-value))
      (((? symbol? attr-name) (? signal? attr-sig))
       (signal-effect (lambda () (set-attribute! elem (symbol->string attr-name) (any->string (signal-ref attr-sig)))))))))

(define shtml-parse
  (lambda (exp)
    (match exp
      ((? signal? sig)
       (lambda (anchor)
	 (signal-effect (lambda () (text-content anchor (any->string (signal-ref sig)))))))
      ((? string? str)
       (lambda (anchor) (text-content anchor str)))
      (((? @map? op) (? procedure? proc) (? list? ele-list))
       (lambda (anchor)
	 (for-each (lambda (ele) ((shtml-parse ele) anchor)) (map proc ele-list))))
      (((? @map? op) (? procedure? proc) (? signal? sig-list))
       (lambda (anchor)
	 (signal-effect
	  (lambda ()
	    (let* ([sig-v (signal-ref sig-list)]
		   [items (map proc sig-v)])
	      (inner-HTML anchor "")
	      (for-each
	       (lambda (item) ((shtml-parse item) anchor)) items))))))
      (((? symbol-empty? tag) . children)
       (lambda (anchor)
	 (for-each (lambda (child) ((shtml-parse child) anchor)) children)))
      (((? symbol? tag) . body)
       (let ([elem (create-element (symbol->string tag))])
	 (define add-childern!
	   (lambda (children)
	     (for-each (lambda (child) ((shtml-parse child) elem)) children)))
	 (match body
	   ((('^ . attrs) . children)
	    (for-each (lambda (attr) (attribute-parse elem attr)) attrs)
	    (add-childern! children))
	   (pure-children (add-childern! pure-children)))
	 (lambda (anchor) (append-child! anchor elem)))))))
