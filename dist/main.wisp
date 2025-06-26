(use-modules (App) (shtml) (dom))

(call-with-values
    (lambda () (App))
  (lambda elems
    (let ([app (get-element-by-id "app")])
      (for-each
       (lambda (elem)
	 ((shtml-parse elem) app))
       elems))))



