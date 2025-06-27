(define-module (App)
  #:export (App)
  #:use-module (Menu)
  #:use-module (Main)
  #:use-module (dom)
  #:use-module (signal))

(define H2&H3
  (lambda ()
    `(empty
      (h2 "H2")
      (h3 "H3"))))

(define App
  (lambda ()
    `(empty
      (h1 "H1")
      ,(H2&H3))))
      


