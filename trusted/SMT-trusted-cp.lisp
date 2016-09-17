;; Copyright (C) 2015, University of British Columbia
;; Written by Yan Peng (August 2nd 2016)
;;
;; License: A 3-clause BSD license.
;; See the LICENSE file distributed with this software
;;

(in-package "SMT")

(include-book "SMT-prove")

(defstub SMT-prove-stub (term) t)

(program)

(defttag :SMT-trusted-cp)

(progn

; We wrap everything here in a single progn, so that the entire form is
; atomic.  That's important because we want the use of push-untouchable to
; prevent anything besides SMT-proves-stub from calling SMT-prove.

  (progn!

   (set-raw-mode-on state)

   (defun SMT-prove-stub (term)
     (SMT-prove term)))

  (defun SMT-trusted-cp (cl)
    (declare (xargs :guard (pseudo-term-listp cl)
                    :mode :program))
    (prog2$ (cw "cl given to the clause processor: ~q0"  cl)
            (if (SMT-prove-stub (disjoin cl))
                (prog2$ (cw "Proved!")
                        nil)
              (prog2$ (cw "~|~%NOTE: Unable to prove goal with ~
                  my-clause-processor and indicated hint.~|")
                      (list cl)))))

  (push-untouchable SMT-prove-stub t)
  )


(define-trusted-clause-processor
  SMT-trusted-cp
  nil
  :ttag SMT-trusted-cp)