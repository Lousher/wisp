(define-module (dom)
  #:use-module (hoot ffi)
  #:re-export (procedure->external)
  #:export (document-body
	    console-log
	    add-event-listener!
	    create-text-node
	    text-content
	    query-selector
	    get-element-by-id
	    create-element
	    set-attribute!
	    append-child!
	    insert-adjacent-element
	    insert-adjacent-HTML))

(define-foreign set-attribute!
  "element" "setAttribute"
  (ref null extern) (ref string) (ref string) -> none)

(define-foreign append-child!
  "element" "appendChild"
  (ref null extern) (ref null extern) -> (ref null extern))

(define-foreign create-element
  "document" "createElement"
  (ref string) -> (ref null extern))

(define-foreign create-text-node
  "document" "createTextNode"
  (ref string) -> (ref null extern))

(define-foreign query-selector
  "document" "querySelector"
  (ref string) -> (ref null extern))

(define-foreign document-body
  "document" "body"
  -> (ref null extern))

(define-foreign console-log
  "console" "log"
  (ref null extern) -> none)

(define-foreign add-event-listener!
  "element" "addEventListener"
  (ref null extern) (ref string) (ref null extern) -> none)

(define-foreign text-content
  "element" "textContent"
  (ref null extern) (ref string) -> none)

(define-foreign get-element-by-id
  "document" "getElementById"
  (ref string) -> (ref null extern))

(define-foreign insert-adjacent-HTML
  "element" "insertAdjacentHTML"
  (ref null extern) (ref string) (ref string) -> (ref null extern))

(define-foreign insert-adjacent-element
  "element" "insertAdjacentElement"
  (ref null extern) (ref string) (ref null extern) -> (ref null extern))
