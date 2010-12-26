;;;; /home/mc/lisp/work/zipper-1/zipper-1.asd

(in-package :asdf)

(defsystem #:zipper-1
  :serial t
  :components ((:file "package")
               (:file "zipper-1")))

(defmethod perform ((o test-op) (c (eql (find-system 'zipper-1))))
  (operate 'load-op 'zipper-1-test)
  (operate 'test-op 'zipper-1-test :force t))