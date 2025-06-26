(define-module (TaskList)
  #:use-module (wisp syntax)
  #:export (TaskList))

(define task->li
  (lambda (task) `(li ,task)))

(define TaskList
  (lambda (tasks)
    `(ul (^ (id "tasks"))
	 ,(@map task->li tasks))))
         
