(define-module (Main)
  #:export (Main))


(define Main
  (lambda ()
    `(section (^ (class "cover"))
	      (div (^ (class "cover-frame"))
		   (div (^ (class "bg-box"))
			(img (^ (src "assets/cover.jpg") (alt "shima"))))
		   (div (^ (class "cover-inner"))
			(h1 (a (^ (href "/")) "岛屿"))
			(div (^ (id "subtitle-box")) "人生是不断前行的路途"))))))
