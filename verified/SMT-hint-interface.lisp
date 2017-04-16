;; Copyright (C) 2015, University of British Columbia
;; Written by Yan Peng (August 2nd 2016)
;;
;; License: A 3-clause BSD license.
;; See the LICENSE file distributed with this software
;;

(in-package "SMT")
(include-book "centaur/fty/top" :dir :system)
(include-book "xdoc/top" :dir :system)
(include-book "std/util/define" :dir :system)

(include-book "SMT-config")

(defsection SMT-hint-interface
  :parents (Smtlink)
  :short "Define default Smtlink hint interface"

  ;; -------------------------------------------------------
  ;;
  ;; Define default Smtlink hint interface
  ;;
  ;;  One needs to attach to SMT-hint their own aggregate
  ;;    to pass in a different hint.
  ;;

  (define pseudo-term-fix (x)
    (declare (xargs :guard (pseudo-termp x)))
    :returns (fixed pseudo-termp)
    :enabled t
    (mbe :logic (if (pseudo-termp x) x nil)
         :exec x)
    ///
    (more-returns
     (fixed (implies (pseudo-termp x) (equal fixed x))
            :name equal-fixed-and-x-of-pseudo-termp)))

  (deffixtype pseudo-term
    :fix pseudo-term-fix
    :pred pseudo-termp
    :equiv pseudo-term-equiv
    :define t)

  (define pseudo-term-list-fix (x)
    (declare (xargs :guard (pseudo-term-listp x)))
    :returns (new-x pseudo-term-listp)
    :enabled t
    (mbe :logic (if (consp x)
                    (cons (pseudo-term-fix (car x))
                          (pseudo-term-list-fix (cdr x)))
                  nil)
         :exec x)
    ///
    (more-returns
     (new-x (<= (acl2-count new-x) (acl2-count x))
            :name acl2-count-<=-pseudo-term-list-fix
            :rule-classes :linear)
     (new-x (implies (pseudo-term-listp x)
                     (equal new-x x))
            :name equal-pseudo-term-list-fix)
     (new-x (implies (pseudo-term-listp x)
                     (equal (len new-x) (len x)))
            :name len-equal-pseudo-term-list-fix
            :rule-classes :linear)))

  (deffixtype pseudo-term-list
    :fix pseudo-term-list-fix
    :pred pseudo-term-listp
    :equiv pseudo-term-list-equiv
    :define t)

  (define pseudo-term-list-list-fix (x)
    (declare (xargs :guard (pseudo-term-list-listp x)))
    :returns (fixed pseudo-term-list-listp)
    :enabled t
    (mbe :logic (if (consp x)
                    (cons (pseudo-term-list-fix (car x))
                          (pseudo-term-list-list-fix (cdr x)))
                  nil)
         :exec x))

  (deffixtype pseudo-term-list-list
    :fix pseudo-term-list-list-fix
    :pred pseudo-term-list-listp
    :equiv pseudo-term-list-list-equiv
    :define t)

  (defalist pseudo-term-alist
    :key-type pseudo-term
    :val-type pseudo-term
    :pred pseudo-term-alistp
    :true-listp t)

  (define list-fix (x)
    (declare (xargs :guard (listp x)))
    :enabled t
    (mbe :logic (if (listp x) x nil)
         :exec x))

  (deffixtype list
    :fix list-fix
    :pred listp
    :equiv list-equiv
    :define t)

  (defprod hint-pair
    ((thm pseudo-termp :default nil)       ;; a theorem statement about the variable
     (hints listp :default nil)     ;; the hint for proving this theorem
     )
    :verbosep t)

  (deflist hint-pair-list
    :elt-type hint-pair
    :pred hint-pair-listp
    :true-listp t)

  (define decl->type-reqfix ((x hint-pair-p))
    :returns (fixed hint-pair-p)
    :enabled t
    (b* ((x (hint-pair-fix x))
         (thm (hint-pair->thm x))
         (hints (hint-pair->hints x)))
      (make-hint-pair :thm (if (symbolp thm) thm nil)
                      :hints (list-fix hints))))

  (defprod decl
    ((name symbolp :default nil)
     (type hint-pair-p :default (make-hint-pair) :reqfix (decl->type-reqfix type)))
    :require (symbolp (hint-pair->thm type)))

  (deflist decl-list
    :elt-type decl
    :pred decl-listp
    :true-listp t)

  (defprod func
    ((name symbolp :default nil)
     (formals decl-listp :default nil)
     (guard hint-pair-listp :default nil)
     (returns decl-listp :default nil)            ;; belong to auxiliary hypotheses
     (more-returns hint-pair-listp :default nil)  ;; belong to auxiliary hypotheses
     (body pseudo-termp :default nil)
     (expansion-depth natp :default 0)
     (uninterpreted booleanp :default nil)
     (flattened-formals symbol-listp :default nil)
     (flattened-returns symbol-listp :default nil)))


  (deflist func-list
    :elt-type func
    :pred func-listp
    :true-listp t)

  (defalist func-alist
    :key-type symbol
    :val-type func
    :pred func-alistp)

  (defprod binding
    ((var symbolp :default nil)
     (expr pseudo-termp :default nil)
     (type symbolp :default nil)))

  (deflist binding-list
    :elt-type binding
    :pred binding-listp
    :true-listp t)

  (defprod let-binding
    ((bindings binding-listp :default nil)
     (hypotheses hint-pair-listp :default nil)))

  ;; The hint structure that contain all hints for the verified clause
  ;; processor.
  ;;
  ;; Fields:
  ;; User fields:
  ;; 1. functions: function definitions.
  ;; 2. hypotheses: hypotheses to the G theorem.
  ;; 3. main-hint: hints to the G' -> G theorem.
  ;; 4. let-binding: binds expressions to variables, generalization.
  ;; 5. int-to-rat: converts all integers to rationals.
  ;; 6. rm-file: configuration for whether to remove generated files.
  ;; 7. smt-fname: configure the name of generated SMT theorem file.
  ;; 8. smt-hint: hints for parameter tuning of the SMT solver.
  ;; 13. smt-cnf: configuration for connection to the SMT solver.
  ;; Internal fields:
  ;; 9. fast-functions: internal field for storing a fast version of function
  ;; definitions. Might be able to make the functions field a fast one after
  ;; changing the user interface.
  ;; 10. aux-hint-list: internal field for making a list of auxiliary hints.
  ;; 11. type-decl-list: internal field for making a list of auxiliary type
  ;; hints.
  ;; 12. expanded-clause-w/-hint: internal field for storing the SMT theorem.
  ;; 14. wrld-fn-len: a number specifying the upper bound of the length of the
  ;; current world. It sets a limit to the expansion depth to take care of
  ;; recursive function expansion. This will only ensure termination proof of
  ;; the expand function, but it doesn't guarantee performance since the world
  ;; length can be extremely large, and expansion is exponential. Performance
  ;; is replied upon user who will specify which functions are recursive and
  ;; therefore will be expanded only by a given number of levels.
  ;;
  (defprod smtlink-hint
    ((functions func-listp :default nil)
     (hypotheses hint-pair-listp :default nil)
     (main-hint listp :default nil)
     (let-binding let-binding-p :default (make-let-binding))
     (int-to-rat booleanp :default nil)
     (rm-file booleanp :default t)
     (smt-fname stringp :default "")
     (smt-hint listp :default nil)
     (fast-functions func-alistp :default nil)
     (aux-hint-list hint-pair-listp :default nil)
     (type-decl-list decl-listp :default nil)
     (expanded-clause-w/-hint hint-pair-p :default (make-hint-pair))
     (smt-cnf smtlink-config-p :default (make-smtlink-config))
     (wrld-fn-len natp :default 512)))

  (define flatten-formals/returns ((formal/return-lst decl-listp))
    :returns (flattened-lst symbol-listp)
    :measure (len formal/return-lst)
    :hints (("Goal" :in-theory (enable decl-list-fix)))
    :enabled t
    (b* ((formal/return-lst (decl-list-fix formal/return-lst))
         ((if (endp formal/return-lst)) nil)
         ((cons first rest) formal/return-lst)
         ((decl d) first))
      (cons d.name (flatten-formals/returns rest))))

  (define make-alist-fn-lst ((fn-lst func-listp))
    :short "@(call make-alist-fn-lst) makes fn-lst a fast alist"
    :returns (fast-fn-lst func-alistp)
    :measure (len fn-lst)
    :enabled t
    (b* ((fn-lst (func-list-fix fn-lst))
         ((unless (consp fn-lst)) nil)
         ((cons first rest) fn-lst)
         ((func f) first)
         (new-f (change-func f
                             :flattened-formals (flatten-formals/returns f.formals)
                             :flattened-returns (flatten-formals/returns f.returns))))
      (cons (cons f.name new-f) (make-alist-fn-lst rest))))

  (defconst *default-smtlink-hint*
    (make-smtlink-hint))

  (defstub smt-hint () => *)

  (define default-smtlink-hint ()
    (change-smtlink-hint *default-smtlink-hint*))

  (defattach smt-hint default-smtlink-hint)


  ;; -------------------------------------------------------------------------
  ;;        Define a set of utilities for convenience

  ;; ;; Example Usage
  ;; (def-smt-hint my-smt-hint
  ;;   :function ())

  ;; (defmacro def-smt-hint (name &key auto-expand)
  ;;   ())
  )
