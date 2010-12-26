;; zipper

(in-package :zipper-internal)

(def-suite zipper-test)

(in-suite zipper-test)

(test car
  (is (eql 'a (car '(a))))
  (signals (error "The value NIL is not of type CONS")
           (car () )))

(test cdr
  (is (eql '() (cdr '(a))))
  (signals (error "The value NIL is not of type CONS")
           (cdr () )))

(test from-list_to-list
  (is (equal (zipper:to-list (zipper:from-list '(1 2 3 4 5)))
             '(1 2 3 4 5)))
  (is (eql ()
           (zipper:to-list (make-zipper)))))

(test beginp
  (is (eq t (zipper:beginp (make-zipper))))
  (is (eq nil (zipper:beginp (zipper:next (make-zipper :cur '(1 2)))))))

(test endp
  (is (eq t (zipper:endp (make-zipper))))
  (is (eq nil (zipper:endp (make-zipper :cur '(1 2))))))

(test next
  (is (eq 'a (zipper:get (zipper:next (make-zipper :cur '(_ a))))))
  (signals (error)
    (zipper:next (make-zipper))))

(test prev
  (is (eq 'a (zipper:get (zipper:prev
                          (zipper:next (zipper:next (make-zipper :cur '(_ a _))))))))
  (signals (error)
    (zipper:prev (make-zipper))))

(test get
  (is (eq 'a (zipper:get (make-zipper :cur '(a)))))
  (signals (error)
    (zipper:get (make-zipper))))

(test set
  (is (equal '(b)
             (zipper:to-list
              (zipper:set 'b (make-zipper :cur '(a))))))
  (signals (error)
    (zipper:set 'a (make-zipper))))

(test insert
  (is (equal '(b)
             (zipper:to-list
              (zipper:insert 'b (make-zipper))))))

(test remove
  (is (equal '(b)
             (zipper:to-list
              (zipper:remove (make-zipper :cur '(a b))))))
  (signals (error)
    (zipper:remove (make-zipper))))

(test to-list
  (is (eq () (zipper:to-list (make-zipper))))
  (is (eq #0='(1 2 3 4 5)
          (zipper:to-list (make-zipper :cur #0#)))))

(test zipper-misc-1
  (is (equal
       (do ((z (zipper:next
                (zipper:next
                 (zipper:from-list
                  (loop :for i :from 0 :to 20 :collect i))))
               (zipper:next z))
            (ans () (list* (zipper:get z)
                      (zipper:get (zipper:prev z))
                      (zipper:get (zipper:prev (zipper:prev z)))
                      ans)))
           ((zipper:endp z) (nreverse ans)))
       '(0 1 2 1 2 3 2 3 4 3 4 5 4 5 6 5 6 7 6 7 8 7 8 9 8 9 10 9 10 11 10 11 12 11 12
         13 12 13 14 13 14 15 14 15 16 15 16 17 16 17 18 17 18 19 18 19 20))))

