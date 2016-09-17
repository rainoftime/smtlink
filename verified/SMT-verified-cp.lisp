;; Copyright (C) 2015, University of British Columbia
;; Written by Yan Peng (August 2nd 2016)
;;
;; License: A 3-clause BSD license.
;; See the LICENSE file distributed with this software
;;

;;
;; ABSTRACTED VERIFIED CLAUSE PROCESSOR FOR SMTLINK
;;
;;   This verified clause processor decomposes the main goal
;;    into three subgoals. The clause processor is verified
;;    meaning it's proven that the three subgoals imply the
;;    original main clause. This is verified in theorem:
;;      "correctness-of-Smtlink-subgoals"
;;
;;   This higher order way of write proofs in ACL2 requires
;;     treating goals as program expressions (meaning they
;;     are quoted terms). Proving theorems on expressions
;;     instead of programs requires an evaluator that tells
;;     the theorem the ``meaning'' of the expressions.
;;

(in-package "SMT")
(include-book "std/util/bstar" :dir :system)
(include-book "misc/eval" :dir :system)
(include-book "clause-processors/join-thms" :dir :system)
(include-book "xdoc/top" :dir :system)
(include-book "std/util/define" :dir :system)

(include-book "SMT-hint-interface")

(defsection SMT-verified-clause-processor
  :parents (Smtlink)
  :short "SMT verified clause processor"

;; -----------------------------------------------------------------
;;       Define the identity function.
;;

(define hint-please ((hint listp))
  (declare (ignore hint)
           (xargs :guard t))
  nil)

(defthm hint-please-forward
  (implies (hint-please hint)
           nil)
  :rule-classes :forward-chaining)

(in-theory (disable (:d hint-please)
                    (:e hint-please)
                    (:t hint-please)))

;; -----------------------------------------------------------------
;;       Define evaluators

(defevaluator ev-Smtlink-subgoals ev-lst-Smtlink-subgoals
  ((not x) (if x y z) (hint-please hint) ))

(def-join-thms ev-Smtlink-subgoals)


;; -----------------------------------------------------------------
;;       Define Smtlink subgoals.
;;


;;
;; Explanation for clause decomposition
;;
;; A -> G-prim
;; A \and G-prim -> G
;; A \or G
;;
;; A : The auxiliary hypothesis clauses
;; G-prim : The expanded original clause
;; G : The original clause

(define preprocess-auxes ((hinted-As hint-pair-listp) (G pseudo-termp))
  :enabled t
  :returns (mv (list-of-A-thm true-listp)
               (list-of-not-As true-listp))
  (b* (((unless (hint-pair-listp hinted-As)) (mv nil nil))
      ((if (endp hinted-As)) (mv nil nil))
       ((cons first-hinted-A rest-hinted-As) hinted-As)
       (A (hint-pair->thm first-hinted-A))
       (A-hint (hint-pair->hints first-hinted-A))
       (first-A-thm `((hint-please ,A-hint) ,A ,G))
       (first-not-A-clause `(not ,A))
       ((mv rest-A-thms rest-not-A-clauses)
        (preprocess-auxes rest-hinted-As G)))
    (mv (cons first-A-thm rest-A-thms)
        (cons first-not-A-clause rest-not-A-clauses)))
  ///
  ;; For helping verify clause processor
  (defthm preprocess-auxes-corollary
    (implies (and (pseudo-term-listp cl)
                  (alistp b)
                  (hint-pair-listp hinted-As)
                  (ev-smtlink-subgoals
                   (disjoin (mv-nth 1 (preprocess-auxes hinted-As (disjoin cl)))) b)
                  (ev-smtlink-subgoals
                   (conjoin-clauses (mv-nth 0 (preprocess-auxes hinted-As (disjoin cl)))) b))
             (ev-smtlink-subgoals (disjoin cl) b))
    :hints (("Goal"
             :induct (preprocess-auxes hinted-As (disjoin cl)))))
  )

;;
;; Constructing three type of clauses:
;;
;; 1. ((not A1) ... (not An) G-prim)
;; 2. ((not A1) ... (not An) (not G-prim) G)
;; 3. (A1 G)
;;    ...
;;    (An G)
;;
;; Adding hint-please:
;;
;; 1. ((hint-please smt-hint) (not A1) ... (not An) G-prim)
;; 2. ((hint-please main-hint) (not A1) ... (not An) (not G-prim) G)
;; 3. ((hint-please A1-hint) A1 G)
;;    ...
;;    ((hint-please An-hint) An G)
;;
(define construct-smtlink-subgoals ((hinted-As hint-pair-listp)
                                    (hinted-G-prim hint-pair-p)
                                    (smt-hint listp)
                                    (G pseudo-termp))
  :enabled t
  (b* (((mv aux-clauses list-of-not-As) (preprocess-auxes hinted-As G))
       (G-prim (hint-pair->thm hinted-G-prim))
       (main-hint (hint-pair->hints hinted-G-prim))
       (cl0 `((hint-please ,smt-hint) ,@list-of-not-As ,G-prim))
       (cl1 `((hint-please ,main-hint) ,@list-of-not-As (not ,G-prim) ,G)))
    `(,cl0 ,cl1 ,@aux-clauses)))

;; If I give guard to smtlink-hint, then I get the error:

;; ACL2 Error in ( DEFTHM CORRECTNESS-OF-SMTLINK-SUBGOALS ...):  The clause-
;; processor of a :CLAUSE-PROCESSOR rule must have a guard that obviously
;; holds whenever its first argument is known to be a PSEUDO-TERM-LISTP
;; and any stobj arguments are assumed to satisfy their stobj predicates.
;; However, the guard for SMTLINK-SUBGOALS is
;; (AND (PSEUDO-TERM-LISTP CL) (SMTLINK-HINT-P SMTLINK-HINT)).  See :DOC
;; clause-processor.


(define Smtlink-subgoals ((cl pseudo-term-listp) (smtlink-hint t))
  :enabled t
  (b* (((unless (smtlink-hint-p smtlink-hint)) (list cl))
       (hinted-As (smtlink-hint->aux-hint-list smtlink-hint))
       (hinted-G-prim (smtlink-hint->expanded-clause-w/-hint smtlink-hint))
       (smt-hint (smtlink-hint->smt-hint smtlink-hint)))
    (construct-smtlink-subgoals hinted-As hinted-G-prim smt-hint (disjoin cl))))

;; ------------------------------------------------------------
;;         Prove correctness of clause processor
;;

(defthm correctness-of-Smtlink-subgoals
  (implies (and (pseudo-term-listp cl)
                (alistp b)
                (ev-Smtlink-subgoals
                 (conjoin-clauses (Smtlink-subgoals cl smtlink-hint))
                 b))
           (ev-Smtlink-subgoals (disjoin cl) b))
  :rule-classes :clause-processor
  :hints (("Goal"
           :use ((:instance preprocess-auxes-corollary
                            (hinted-As (smtlink-hint->aux-hint-list smtlink-hint)))))))

)