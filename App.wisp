(define-module (App)
  #:export (App)
  #:use-module (TaskList)
  #:use-module (dom)
  #:use-module (signal))

(define-signal (tasks set-tasks-next) '("Old Task 1"))
(define add-task (lambda (event)
		   (set-tasks-next (lambda (tasks) (cons "new Task 1" tasks)))))

(define App
  (lambda ()
    `(section
      (button (^ (@click ,add-task)) "Add New Task")
      ,(TaskList tasks)
      )))

