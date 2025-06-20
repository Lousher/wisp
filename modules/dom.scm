(define-module (dom)
  #:use-module (hoot ffi)
  #:re-export (procedure->external)
  #:export (document-body
	    console-log
	    add-event-listener!
	    text-content
	    query-selector
	    get-element-by-id
	    insert-adjacent-HTML))

(define-foreign query-selector
  "document" "querySelector"
  (ref string) -> (ref null extern))

(define-foreign document-body
  "document" "body"
  -> (ref null extern))

(define-foreign console-log
  "console" "log"
  (ref string) -> none)

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
