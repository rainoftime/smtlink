;; Copyright (C) 2015, University of British Columbia
;; Written (originally) by Yan Peng (13th March, 2014)
;;
;; License: A 3-clause BSD license.
;; See the LICENSE file distributed with this software

(in-package "SMT")
(include-book "centaur/fty/top" :dir :system)
(include-book "xdoc/top" :dir :system)
(include-book "std/util/define" :dir :system)
;; for lambda expression
(include-book "kestrel/utilities/terms" :dir :system)
(include-book "centaur/misc/hons-extra" :dir :system)

(include-book "../../verified/SMT-hint-interface")
(include-book "./SMT-names")

(defsection SMT-translator
  :parents (Smtlink)
  :short "SMT-translator does the LISP to Python translation."

  (defconst *SMT-functions*
    ;;(ACL2 function . (SMT function       Least # of arguments))
    `((binary-+      . ("_SMT_.plus"       0))
      (binary-*      . ("_SMT_.times"      0))
      (unary-/       . ("_SMT_.reciprocal" 1))
      (unary--       . ("_SMT_.negate"     1))
      (equal         . ("_SMT_.equal"      2))
      (<             . ("_SMT_.lt"         2))
      (if            . ("_SMT_.ifx"        3))
      (not           . ("_SMT_.notx"       1))
      (lambda        . ("lambda"           2))
      (implies       . ("_SMT_.implies"    2))
      ))

  (defconst *SMT-types*
    ;;(ACL2 type .  SMT type)
    `((rationalp . "_SMT_.isReal")
      (integerp  . "_SMT_.isInt")
      (booleanp  . "_SMT_.isBool")))

  (define SMT-numberp (sym)
    (declare (xargs :guard t))
    :returns (is? booleanp)
    :enabled t
    (if (or (rationalp sym) (integerp sym)) t nil))

  (define SMT-number-fix ((num SMT-numberp))
    :returns (fixed SMT-numberp)
    :enabled t
    (mbe :logic (if (SMT-numberp num) num 0)
         :exec num))

  (deffixtype SMT-number
    :fix SMT-number-fix
    :pred SMT-numberp
    :equiv SMT-number-equiv
    :define t)

  (define wordp (atom)
    (declare (xargs :guard t))
    :returns (word? booleanp)
    :enabled t
    (if (or (acl2-numberp atom)
            (symbolp atom)
            (characterp atom)
            (stringp atom))
        t
      nil))

  (define word-fix ((atom wordp))
    :returns (fixed wordp)
    :enabled t
    (mbe :logic (if (wordp atom) atom nil)
         :exec atom)
    ///
    (more-returns
     (fixed (equal (word-fix fixed) fixed)
            :name equal-word-fixed)))

  (deffixtype word
    :fix word-fix
    :pred wordp
    :equiv word-equiv
    :define t)

  (defthm wordp-of-lisp-to-python-names
    (wordp (lisp-to-python-names x))
    :hints (("Goal" :in-theory (enable wordp))))


  (define translate-function ((opr symbolp))
    :returns (translated stringp)
    (b* ((translated (cadr (assoc-equal opr *SMT-functions*)))
         ((if (equal translated nil))
          (prog2$ (er hard? 'SMT-translator=>translate-function "Not a basic SMT function: ~q0" opr)
                  "")))
      translated))

  (defthm wordp-of-translate-function
    (wordp (translate-function x))
    :hints (("Goal" :in-theory (enable wordp))))

  (define paragraphp (par)
    (declare (xargs :guard t))
    :returns (paragraph? booleanp)
    :short "A paragraph is made up of lists of words. Notice a single word is also counted as a paragraphp."
    (if (atom par)
        (wordp par)
      (and (paragraphp (car par)) (paragraphp (cdr par)))))

  (defthm paragraphp-corollary-1
    (implies (wordp x) (paragraphp x))
    :hints (("Goal" :in-theory (enable paragraphp wordp))))

  (defthm paragraphp-corollary-2
    (implies (and (consp x) (paragraphp (car x)) (paragraphp (cdr x))) (paragraphp x))
    :hints (("Goal" :in-theory (enable paragraphp))))

  (encapsulate ()
    (local (in-theory (enable paragraphp)))
    (define paragraph-fix ((x paragraphp))
      :returns (fixed paragraphp)
      (mbe :logic (if (consp x)
                      (cons (paragraph-fix (car x)) (paragraph-fix (cdr x)))
                    (word-fix x))
           :exec x))
    )

  (encapsulate ()
    (local (in-theory (enable paragraph-fix)))
    (deffixtype paragraph
      :fix paragraph-fix
      :pred paragraphp
      :equiv paragraph-equiv
      :define t)
    )

  (define translate-number ((num SMT-numberp))
    :returns (translated paragraphp :hints (("Goal" :in-theory (enable wordp paragraphp))))
    :guard-debug t
    (b* ((num (mbe :logic (SMT-number-fix num) :exec num))
         ((if (and (rationalp num) (not (integerp num))))
          `("_SMT_.Qx(" ,(numerator num) "," ,(denominator num) ")")))
      (list num)))

  (define translate-symbol ((sym symbolp))
    :returns (translated paragraphp
                         :hints (("Goal" :in-theory (enable paragraphp wordp))))
    (cond ;; A number
     ((SMT-numberp sym) (translate-number sym))
     ;; Boolean: nil
     ((equal sym 'nil) (list "False"))
     ;; Boolean: t
     ((equal sym 't) (list "True"))
     ;; A variable
     (t (list (lisp-to-python-names sym)))))

  (define translate-type ((type symbolp))
    :returns (translated stringp)
    (b* ((type (mbe :logic (symbol-fix type) :exec type))
         (item (assoc-equal type *SMT-types*)))
      (if (endp item)
          (prog2$ (er hard? 'SMT-translator=>translate-type "Not a SMT type: ~q0" type) "")
        (cdr item))))

  (defprod te-args
    ((expr-lst pseudo-term-listp :default nil)
     (fn-lst func-alistp :default nil)
     (uninterpreted-lst symbol-listp :default nil)))

  (define translate-lambda-formals ((formals symbol-listp))
    :returns (translated paragraphp
                         :hints (("Goal" :in-theory (enable translate-symbol paragraphp))))
    :measure (len formals)
    (b* ((formals (mbe :logic (symbol-list-fix formals) :exec formals))
         ((unless (consp formals)) nil)
         ((cons first rest) formals)
         (translated-name (translate-symbol first)))
      (cons translated-name `(#\Space ,@(translate-lambda-formals rest)))))

  (define translate-expression ((args te-args-p))
    :returns (mv (translated paragraphp
                             :hints (("Goal" :in-theory (enable paragraphp))))
                 (uninterpreted symbol-listp))
    :measure (acl2-count (te-args->expr-lst args))
    :hints (("Goal" :in-theory (enable pseudo-lambdap)))
    :verify-guards nil
    (b* ((args (mbe :logic (te-args-fix args) :exec args))
         ((te-args a) args)
         ((unless (consp a.expr-lst)) (mv nil a.uninterpreted-lst))
         ((cons expr rest) a.expr-lst)
         ((mv translated-rest uninterpreted-rest)
          (translate-expression (change-te-args a :expr-lst rest)))
         ;; If first term is an symbolp, should be a variable name
         ;; translate the variable then recurse on the rest of the list
         ((if (symbolp expr))
          (mv (cons (translate-symbol expr) translated-rest)
              uninterpreted-rest))
         ;; If car of term is 'quote
         ;; Translate it into a SMT atom
         ((if (equal (car expr) 'quote))
          (b* (((unless (symbolp (cadr expr)))
                (mv (er hard? 'SMT-translator=>translate-expression "List not supported: ~q0" expr) nil))
               (translated-quote `("_SMT_.atom" #\( #\" ,(translate-symbol (cadr expr)) #\" #\) )))
            (mv (cons translated-quote translated-rest)
                uninterpreted-rest)))
         ;; The first term is now a function call:
         ;; Either a lambda or a symbol
         ((cons fn-call fn-actuals) expr)

         ;; If fn-call is a lambda
         ((if (pseudo-lambdap fn-call))
          (b* ((formals (lambda-formals fn-call))
               (body (lambda-body fn-call))
               (lambda-sym (car fn-call))
               (translated-lambda (translate-function lambda-sym))
               (translated-formals (translate-lambda-formals formals))
               ((mv translated-body uninterpreted-1)
                (translate-expression (change-te-args a :expr-lst (list body) :uninterpreted-lst uninterpreted-rest)))
               ((mv translated-actuals uninterpreted-2)
                (translate-expression (change-te-args a :expr-lst fn-actuals :uninterpreted-lst uninterpreted-1)))
               (translated-lambda-whole
                `(#\( ,translated-lambda #\Space ,translated-formals #\: ,translated-body #\)
                  #\( ,translated-actuals #\))))
            (mv (cons translated-lambda-whole translated-rest)
                uninterpreted-2)))

         ;; If fn-call is neither a lambda expression nor a function call
         ((unless (mbt (symbolp fn-call))) (mv nil nil))
         ;; See if fn-call is an uninterpreted function
         (fn (hons-get fn-call a.fn-lst))
         ((if fn)
          (b* (((func f) (cdr fn))
               ((if (not f.uninterpreted))
                (mv (er hard? 'SMT-translator=>translate-expression "Not a basic SMT function: ~q0" fn-call) nil))
               ((mv translated-actuals uninterpreted-1)
                (translate-expression (change-te-args a :expr-lst fn-actuals :uninterpreted-lst uninterpreted-rest)))
               (translated-fn-call
                `(,(translate-symbol fn-call) #\( ,translated-actuals #\) )))
            (mv (cons translated-fn-call translated-rest)
                (cons fn-call uninterpreted-1))))
         ;; If fn-call is not an uninterpreted function, then it has to be a basic function
         ((mv translated-actuals uninterpreted-1)
          (translate-expression (change-te-args a :expr-lst fn-actuals :uninterpreted-lst uninterpreted-rest))))
      (mv (cons `( ,(translate-function fn-call) #\( ,translated-actuals #\) ) translated-rest)
          uninterpreted-1)))

  (encapsulate ()
    (local (defthm lemma-1
             (implies (te-args-p x)
                      (pseudo-term-listp (te-args->expr-lst x)))))
    (local (defthm lemma-2
             (implies (and (pseudo-term-listp x) (consp x))
                      (pseudo-term-listp (cdr x)))))
    (defthm pseudo-term-listp-of-cdr-of-te-args->expr-lst
      (implies (and (te-args-p x)
                    (consp (te-args->expr-lst x)))
               (pseudo-term-listp (cdr (te-args->expr-lst x))))
      :hints (("Goal" :in-theory (enable pseudo-term-listp))))

    (local (defthm lemma-3
             (implies (and (pseudo-term-listp x) (consp x))
                      (pseudo-termp (car x)))))

    (local (defthm lemma-4
             (implies (and (pseudo-termp x) (not (symbolp x)))
                      (consp x))))

    (defthm consp-of-car-of-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args)))))
               (consp (car (te-args->expr-lst args)))))

    (local (defthm lemma-5
             (implies (and (pseudo-term-listp x) (consp x)
                           (not (symbolp (car x))) (equal (caar x) 'quote))
                      (consp (cdar x)))))

    (defthm not-cdr-of-car-of-quote-ex-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (equal (car (car (te-args->expr-lst args)))
                           'quote)
                    (not (consp (cdr (car (te-args->expr-lst args))))))
               (not (cdr (car (te-args->expr-lst args))))))

    (local (defthm lemma-6
             (implies (and (pseudo-term-listp x) (consp x)
                           (pseudo-lambdap (caar x)))
                      (symbolp (caaar x)))))

    (defthm symbolp-of-caaar-of-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (equal (car (car (te-args->expr-lst args)))
                                'quote))
                    (pseudo-lambdap (car (car (te-args->expr-lst args)))))
               (symbolp (car (car (car (te-args->expr-lst args)))))))

    (local (defthm lemma-7
             (implies (and (pseudo-term-listp x) (consp x)
                           (not (symbolp (car x))) (not (pseudo-lambdap (caar x))))
                      (symbolp (caar x)))
             :hints (("Goal" :in-theory (enable pseudo-termp pseudo-lambdap pseudo-term-listp)))))

    (defthm symbolp-of-caar-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (pseudo-lambdap (car (car (te-args->expr-lst args))))))
               (symbolp (car (car (te-args->expr-lst args))))))

    (local (defthm lemma-8
             (implies (and (pseudo-term-listp x) (consp x) (pseudo-lambdap (caar x)))
                      (symbol-listp (cadaar x)))
             :hints (("Goal" :in-theory (enable pseudo-termp pseudo-lambdap pseudo-term-listp)))))

    (defthm symbol-listp-of-cadaar-of-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (equal (car (car (te-args->expr-lst args)))
                                'quote))
                    (pseudo-lambdap (car (car (te-args->expr-lst args)))))
               (symbol-listp (cadr (car (car (te-args->expr-lst args)))))))

    (local (defthm lemma-9
             (implies (and (pseudo-term-listp x) (consp x)
                           (pseudo-lambdap (caar x)))
                      (pseudo-termp (caddr (caar x))))
             :hints (("Goal" :in-theory (enable pseudo-lambdap pseudo-term-listp pseudo-termp)))))

    (defthm pseudo-termp-of-caddaar-of-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (equal (car (car (te-args->expr-lst args)))
                                'quote))
                    (pseudo-lambdap (car (car (te-args->expr-lst args)))))
               (pseudo-termp (caddr (car (car (te-args->expr-lst args)))))))

    (local (defthm lemma-10
             (implies (and (pseudo-term-listp x) (consp x)
                           (pseudo-lambdap (caar x)))
                      (pseudo-term-listp (cdar x)))))

    (defthm pseudo-term-listp-of-cdar-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (equal (car (car (te-args->expr-lst args)))
                                'quote))
                    (pseudo-lambdap (car (car (te-args->expr-lst args)))))
               (pseudo-term-listp (cdr (car (te-args->expr-lst args))))))

    (local (defthm lemma-11
             (implies (and (pseudo-term-listp x) (consp x)
                           (not (symbolp (car x))) (not (pseudo-lambdap (caar x)))
                           (not (equal (caar x) 'quote)))
                      (pseudo-term-listp (cdar x)))))

    (defthm pseudo-term-listp-of-cdar-of-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (equal (car (car (te-args->expr-lst args)))
                                'quote))
                    (not (pseudo-lambdap (car (car (te-args->expr-lst args))))))
               (pseudo-term-listp (cdr (car (te-args->expr-lst args))))))

    (local (defthm lemma-12
             (implies (and (pseudo-term-listp x) (consp x)
                           (pseudo-lambdap (caar x)))
                      (consp (cdaar x)))
             :hints (("Goal" :in-theory (enable pseudo-lambdap pseudo-term-listp pseudo-termp)))))

    (defthm not-cdaar-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (equal (car (car (te-args->expr-lst args)))
                                'quote))
                    (pseudo-lambdap (car (car (te-args->expr-lst args))))
                    (not (consp (cdr (car (car (te-args->expr-lst args)))))))
               (not (cdr (car (car (te-args->expr-lst args)))))))

    (local (defthm lemma-13
             (implies (and (pseudo-term-listp x) (consp x)
                           (pseudo-lambdap (caar x)))
                      (consp (cddaar x)))
             :hints (("Goal" :in-theory (enable pseudo-lambdap pseudo-term-listp pseudo-termp)))))

    (defthm not-cddaar-of-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (equal (car (car (te-args->expr-lst args)))
                                'quote))
                    (pseudo-lambdap (car (car (te-args->expr-lst args))))
                    (not (consp (cddr (car (car (te-args->expr-lst args)))))))
               (not (cddr (car (car (te-args->expr-lst args)))))))

    (local (defthm lemma-14
             (implies (and (pseudo-term-listp x) (consp x)
                           (pseudo-lambdap (caar x)))
                      (consp (caar x)))
             :hints (("Goal" :in-theory (enable pseudo-lambdap pseudo-term-listp pseudo-termp)))))

    (defthm not-caar-of-te-args->expr-lst
      (implies (and (te-args-p args)
                    (consp (te-args->expr-lst args))
                    (not (symbolp (car (te-args->expr-lst args))))
                    (not (equal (car (car (te-args->expr-lst args)))
                                'quote))
                    (pseudo-lambdap (car (car (te-args->expr-lst args))))
                    (not (consp (car (car (te-args->expr-lst args))))))
               (not (car (car (te-args->expr-lst args))))))
    )

  (verify-guards translate-expression
    :guard-debug t)

  (define translate-declaration ((name symbolp) (type symbolp))
    :returns (translated paragraphp
                         :hints (("Goal"
                                  :in-theory (enable translate-symbol translate-type paragraphp wordp))))
    (b* ((name (mbe :logic (symbol-fix name) :exec name))
         (type (mbe :logic (symbol-fix type) :exec type))
         (translated-name (translate-symbol name))
         (translated-type (translate-type type)))
      `(,translated-name = ,translated-type #\( #\" ,translated-name #\" #\) )))

  (encapsulate ()
    (local (in-theory (enable paragraph-fix paragraphp)))
    (define translate-type-decl-list ((type-decl-lst decl-listp) (acc paragraphp))
      :returns (translated paragraphp
                           :hints (("Goal" :in-theory (enable translate-declaration))))
      :measure (len type-decl-lst)
      (b* ((type-decl-lst (mbe :logic (decl-list-fix type-decl-lst) :exec type-decl-lst))
           (acc (mbe :logic (paragraph-fix acc) :exec acc))
           ((unless (consp type-decl-lst)) acc)
           ((cons first rest) type-decl-lst)
           ((decl d) first)
           ((hint-pair h) d.type)
           (translated-type-decl (translate-declaration d.name h.thm)))
        (translate-type-decl-list rest (cons translated-type-decl acc))))
    )

  (define translate-theorem ((theorem pseudo-termp) (fn-lst func-alistp))
    :returns (mv (translated paragraphp :hints (("Goal" :in-theory (enable translate-expression))))
                 (uninterpreted symbol-listp
                                :hints (("Goal"
                                         :in-theory (disable symbol-listp)
                                         :use ((:instance symbol-listp-of-translate-expression.uninterpreted))))))
    (b* ((theorem (mbe :logic (pseudo-term-fix theorem) :exec theorem))
         (uninterpreted-lst nil)
         ((mv translated-theorem-body uninterpreted)
          (with-fast-alists (fn-lst uninterpreted-lst)
            (translate-expression (make-te-args :expr-lst (list theorem)
                                                :fn-lst fn-lst
                                                :uninterpreted-lst uninterpreted-lst))))
         (theorem-assign `("theorem" = ,translated-theorem-body #\Newline))
         (prove-theorem `("_SMT_.prove(theorem)" #\Newline)))
      (mv `(,theorem-assign ,prove-theorem) uninterpreted)))

  (define translate-uninterpreted-arguments ((type symbolp) (args decl-listp))
    :returns (translated paragraphp
                         :hints (("Goal" :in-theory (disable true-listp))))
    :measure (len args)
    (b* ((type (mbe :logic (symbol-fix type) :exec type))
         (args (mbe :logic (decl-list-fix args):exec args))
         ((unless (consp args)) nil)
         ((cons first rest) args)
         ((decl d) first)
         (translated-type (translate-type d.name)))
      (cons `(#\, #\Space ,translated-type #\( #\))
            (translate-uninterpreted-arguments type rest))))

  (define translate-uninterpreted-decl ((fn func-p))
    :returns (translated paragraphp)
    (b* ((fn (mbe :logic (func-fix fn) :exec fn))
         ;; Bind everything needed from fn
         ((func f) fn)
         (name f.name)
         (translated-formals (translate-uninterpreted-arguments 'formals f.formals))
         ((if (> (len f.returns) 1))
          (er hard? 'SMT-translator=>translate-uninterpreted-decl "Currently, mv returns are not supported."))
         (translated-returns (translate-uninterpreted-arguments 'returns f.returns)))
      `(,name "= Function(" #\' ,name #\' ,translated-formals ,translated-returns #\Newline)))

  ;; func1 = Function('func1', I1-type, I2-type, R-type)
  ;; example:
  ;;   expr = Function('expr', RealSort(), IntSort(), RealSort())
  (encapsulate ()
    (local (in-theory (enable paragraph-fix paragraphp)))
    (define translate-uninterpreted-decl-lst ((uninterpreted symbol-listp) (fn-lst func-alistp)
                                              (acc paragraphp))
      :measure (len uninterpreted)
      :returns (translated paragraphp)
      :guard-debug t
      (b* ((uninterpreted (mbe :logic (symbol-list-fix uninterpreted) :exec uninterpreted))
           (fn-lst (mbe :logic (func-alist-fix fn-lst) :exec fn-lst))
           (acc (mbe :logic (paragraph-fix acc) :exec acc))
           ((unless (consp uninterpreted)) acc)
           ((cons first rest) uninterpreted)
           (fn (hons-get first fn-lst))
           ;; ((unless (mbt fn)) acc)
           ((unless fn) acc)
           (first-decl (translate-uninterpreted-decl (cdr fn))))
        (translate-uninterpreted-decl-lst rest fn-lst (cons first-decl acc))))
    )

  (define SMT-translation ((term pseudo-termp) (smtlink-hint smtlink-hint-p))
    :returns (py-term paragraphp)
    (b* ((term (mbe :logic (pseudo-term-fix term) :exec term))
         (smtlink-hint (mbe :logic (smtlink-hint-fix smtlink-hint) :exec smtlink-hint))
         ((smtlink-hint h) smtlink-hint)
         ;; Make an alist version of fn-lst
         (fn-lst (make-alist-fn-lst h.functions))
         ((mv translated-theorem uninterpreted) (translate-theorem term fn-lst))
         (translated-uninterpreted-decls
          (with-fast-alist fn-lst
            (translate-uninterpreted-decl-lst uninterpreted fn-lst translated-theorem)))
         (translated-theorem-with-type-decls
          (translate-type-decl-list h.type-decl-list translated-uninterpreted-decls))
         )
      `(,@translated-theorem-with-type-decls)))
  )
