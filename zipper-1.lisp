;; zipper

(in-package :zipper-internal)

(defun car (list)
  (cl:car (the cons list)))

(defun cdr (list)
  (cl:cdr (the cons list)))

(defstruct zipper:zipper
  (acc () :type list)
  (cur () :type list))

(defun zipper:from-list (list)
  (make-zipper :acc () :cur list))

(defun zipper:beginp (zipper)
  (null (zipper-acc zipper)))

(defun zipper:endp (zipper)
  (null (zipper-cur zipper)))

(defun zipper:next (zipper)
  (make-zipper :acc (cons (car (zipper-cur zipper))
                          (zipper-acc zipper))
               :cur (cdr (zipper-cur zipper))))

(defun zipper:prev (zipper)
  (make-zipper :acc (cdr (zipper-acc zipper))
               :cur (cons (car (zipper-acc zipper))
                          (zipper-cur zipper))))

(defun zipper:get (zipper)
  (car (zipper-cur zipper)))

(defun zipper:set (elt zipper)
  (make-zipper :acc (zipper-acc zipper)
               :cur (cons elt (cdr (zipper-cur zipper)))))

(defun zipper:insert (elt zipper)
  (make-zipper :acc (zipper-acc zipper)
               :cur (cons elt (zipper-cur zipper))))

(defun zipper:remove (zipper)
  (make-zipper :acc (zipper-acc zipper)
               :cur (cdr (zipper-cur zipper))))

(defun zipper:to-list (zipper)
  (revappend (zipper-acc zipper)
             (zipper-cur zipper)))

