;; Copyright (C) 2015, University of British Columbia
;; Written by Yan Peng (June 26th 2017)
;;
;; License: A 3-clause BSD license.
;; See the LICENSE file distributed with this software
;;

(in-package "SMT")
(include-book "centaur/sv/tutorial/support" :dir :system)
(include-book "examples/examples")

;; ------------------------------------------------------- ;;
;;    Documentation

(include-book "xdoc/save" :dir :system)  ;; load xdoc::save

(defxdoc Smtlink
  :parents (ACL2::top)
  :short "Tutorial and documentation for the ACL2 book, Smtlink."
  :long "<h3>Introduction</h3>
         <p>A framework for integrating external SMT solvers into ACL2 based on
         the @(see ACL2::clause-processor) and the @(tsee ACL2::computed-hint)
         mechanism.</p>

         <h4>Overview</h4>
         <p>@('Smtlink') is a framework for representing suitable ACL2 theorems
         as a SMT (Satisfiability Modulo Theories) formula, and calling SMT
         solvers from within ACL2.  Two phases of translation happen in the
         framework.  The first translation is fully verified using several
         verified clause processor interleaved with computed hints, therefore
         is ensured to be sound.  The second phase involves a partial
         transliteration from ACL2's LISP language to the target SMT solver's
         language.  This phase is done through a trusted clause processor and
         thus is not verified in ACL2 to be sound.</p>

         <p>SMT solvers combine domain-specific techniques together into a SAT
         (Satisfiability) Solver and solves domain-specific satisfiability
         problems.  Typical domain specific procedures include procedures in
         integer and real, linear and non-linear arithmetic, array theory,
         and uninterpreted function theory.  Modern SMT solvers benefit from
         the development of both the SAT solvers and the domain-specific
         techniques and have become very fast at solving some relatively large
         problems.  Like the SAT solvers, SMT solvers are also competing each
         other annually at <a
         href='http://smtcomp.sourceforge.net/'>SMT-COMP</a>.</p>

         <p>@('Smtlink') currently only supports <a
         href='https://github.com/Z3Prover/z3/wiki'>Z3</a>. We will be adding
         an interface to include the <a
         href='http://smtlib.cs.uiowa.edu/'>SMT-LIB</a> in near future.</p>

         <h3>Using Smtlink</h3>
         <h4>Requirements</h4>
         <ul>
         <li>Python 2 is properly installed.</li>
         <li>Z3 is properly installed.</li>
         <li>ACL2 and the system books are properly installed.</li>
         <li>@('Smtlink') uses Unix commands.</li>
         </ul>

         <h4>Build Smtlink</h4>
         <ul>
         <li>Setup smtlink-config in smtlink-config
         </li>
         <li>Certify Smtlink to bake setup into certified books.
         </li>
         </ul>

         <h4>Load and Setup Smtlink</h4>
         <p>To use @('Smtlink'), one needs to include book:</p>
         @({
          (include-book \"Smtlink/top\" :dir :system)
         })
         <p>Then one needs to enable @(tsee acl2::tshell) by doing:</p>
         @({
          (value-triple (tshell-ensure))
         })
         <p>@(tsee value-triple) makes sure the form @('(tshell-ensure)') can
         be submitted in an event context and therefore is certifiable.</p>

         <p>For a detail description of how to setup and get started using
         @('Smtlink'), see @(tsee tutorial).</p>

         <h3>Reference</h3>
         <p>@('Smtlink') has experienced a great interface and infrastructure
         change since its first publication at ACL2 workshop 2015. But you may
         still find below paper useful in understanding basics of
         @('Smtlink'):</p>

         <p>Yan Peng and Mark R. Greenstreet. <a
         href='https://arxiv.org/abs/1509.06082'>Extending ACL2 with SMT
         Solvers</a>In ACL2 Workshop 2015. October 2015. EPTCS 192. Pages 61-77.</p>")


(defxdoc z3-py
  :parents (Trusted)
  :short "The Z3 python interface related books."
  :long "<h3>Introduction</h3>")

(defxdoc Trusted
  :parents (Developer)
  :short "Trusted part of Smtlink."
  :long "<h3>Introduction</h3>")

(defxdoc Verified
  :parents (Developer)
  :short "Verified part of Smtlink"
  :long "<h3>Introduction</h3>")

(defxdoc Developer
  :parents (Smtlink)
  :short "The developer's reference to Smtlink."
  :long "<h3>Introduction</h3>")

(sv::deftutorial Tutorial
  :parents (Smtlink)
  :short "A tutorial to walk you through how to use Smtlink to prove ACL2 theorems."
  :long "<h3>Introduction</h3>")

(xdoc::save "./manual" :redef-okp t)  ;; write the manual