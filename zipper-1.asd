;;;; /home/mc/lisp/work/zipper-1/zipper-1.asd

(in-package :asdf)

(defsystem #:zipper-1
  :serial t
  :components ((:file "package")
               (:file "zipper-1")))

(defsystem zipper-1-test
  :depends-on (:fiveam :zipper-1)
  :components ((:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system 'zipper-1-test))))
  (or (flet ((_ (sym)
         (intern (symbol-name sym)
                 (find-package :zipper-internal))))
        (let ((result (funcall (_ :run) (_ :zipper-test))))
          (funcall (_ :explain!) result)
          (funcall (_ :results-status) result)))
      (error "test-op failed") ))

(defmethod perform ((o test-op) (c (eql (find-system 'zipper-1))))
  (load-system :zipper-1)
  (test-system :zipper-1-test :force t))