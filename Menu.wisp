(define-module (Menu)
  #:export (Menu))

(define Menu
  (lambda ()
    `(aside (^ (class "sidebar"))
	    (nav (^ (class "navbar"))
		 (div (^ (class "logo"))
		      (a (^ (href "/"))))
		 (ul (^ (class "nav-main"))
		     (li (a "主页"))
		     (li (a "归档"))
		     (li (a "标签")))))))
