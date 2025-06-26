(define-module (App)
  #:export (App)
  #:use-module (Menu)
  #:use-module (Main)
  #:use-module (dom)
  #:use-module (signal))


(define App
  (lambda ()
    (values
     (Main)
     (Menu))))



    
