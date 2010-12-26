(in-package :asdf)

(defsystem zipper-1-test
  :depends-on (:fiveam :zipper-1)
  :components ((:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system 'zipper-1-test))))
  (or (funcall (intern (symbol-name '#:run!)
		       (find-package '#:fiveam))
               (intern (symbol-name '#:zipper-test)
		       (find-package '#:zipper-internal)))
      ;(error "test-op failed")
      ))








