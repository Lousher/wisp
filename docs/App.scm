(define-module (App)
  #:use-module (signal)
  #:use-module (wisp syntax)
  #:export (App))

(define menu-list '("New Game" "Load Game" "Gallery" "Config" "End Game"))

(define App
  (lambda ()
    `(div (^ (class "flex flex-1 h-screen"))
	  (div (^ (class "w-5/12 p-8 flex flex-col bg-red-200 relative"))
	       (img (^ (class "fixed bottom-0 left-0 z-100 p-4 w-1/8 h-auto")
		       (src "assets/mrfree.png")))
	       (ul (^ (id "menu") (class "absolute bottom-0 right-0 m-5"))
		   ,(@map (lambda (item) `(li (^ (class "m-2 text-5xl")) ,item)) menu-list)))
	  (div (^ (class "w-7/12 relative bg-blue-200"))
	       (img (^ (class "h-full w-full") (src "assets/ba.png")))))))
	  


