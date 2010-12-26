;;;; /home/mc/lisp/work/zipper-1/package.lisp

(defpackage :zipper
  (:export :from-list
           :beginp
           :endp
           :next
           :prev
           :get
           :set
           :remove
           :insert
           :to-list
           :zipper-p
           :zipper))

(defpackage :zipper-internal
  (:use :cl :fiveam)
  (:shadow :car :cdr))

