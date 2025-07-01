(define-module (Sticky)
  #:export (Sticky))

(define Sticky
  (lambda (content)
    `(div (^ (class "sticky top-4 w-40 h-40 bg-gradient-to-br from-indigo-500 to-purple-600 shadow-xl rounded-lg flex items-center justify-center text-white font-bold text-xl transform transition-all duration-300 hover:scale-110 hover:rotate-12 hover:shadow-2xl cursor-pointer z-10"))
	  ,content)))
