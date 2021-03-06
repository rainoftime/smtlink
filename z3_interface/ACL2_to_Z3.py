# Copyright (C) 2015, University of British Columbia
# Written (originally) by Mark Greenstreet (13th March, 2014)
# Counter-example generation: Carl Kwan (May 2016)
# Editted by Yan Peng (15th Nov 2016)
#
# License: A 3-clause BSD license.
# See the LICENSE file distributed with this software

from z3 import *

def sort(x):
    if type(x) == bool:    return BoolSort()
    elif type(x) == int:   return IntSort()
    elif type(x) == float: return RealSort()
    elif hasattr(x, 'sort'):
        if x.sort() == BoolSort(): return BoolSort()
        if x.sort() == IntSort():  return IntSort()
        if x.sort() == RealSort(): return RealSort()
        else:
            raise Exception('unknown sort for expression')

class ACL22SMT(object):
    class status:
        def __init__(self, value):
            self.value = value

        def __str__(self):
            if(self.value is True): return 'QED'
            elif(self.value.__class__ == 'msg'.__class__): return self.value
            else: raise Exception('unknown status?')

        def isThm(self):
            return(self.value is True)

    class atom:  # added my mrg, 21 May 2015
        def __init__(self, string):
            self.who_am_i = string.lower()
        def __eq__(self, other):
            return(self.who_am_i == other.who_am_i)
        def __ne__(self, other):
            return(self.who_am_i != other.who_am_i)
        def __str__(self):
            return(self.who_am_i)

    def __init__(self, solver=None):
        if(solver != None): self.solver = solver
        else: self.solver = Solver()
        self.nameNumber = 0

    # ---------------------------------------------------------
    #                   Basic Functions
    #
    # Type declarations
    def isBool(self, who): return Bool(who)
    def isInt(self, who): return Int(who)
    def isReal(self, who): return Real(who)

    def plus(self, *args): return reduce(lambda x, y: x+y, args)
    def times(self, *args): return reduce(lambda x, y: x*y, args)

    def reciprocal(self, x):
        if(type(x) is int): return(Q(1,x))
        elif(type(x) is float): return 1.0/x
        else: return 1.0/x

    def negate(self, x): return -x
    def lt(self, x,y): return x<y
    def equal(self, x,y): return x==y
    def notx(self, x): return Not(x)
    def implies(self, x, y): return Implies(x,y)
    def Qx(self, x, y): return Q(x,y)

    # type related functions
    def integerp(self, x): return sort(x) == IntSort()
    def rationalp(self, x): return sort(x) == RealSort()
    def booleanp(self, x): return sort(x) == BoolSort()
    # Uninterpreted function types
    def Z(self): return IntSort()
    def R(self): return RealSort()
    def B(self): return BoolSort()

    def ifx(self, condx, thenx, elsex):
        return If(condx, thenx, elsex)

    def hint_okay(self):
        return False

    # -------------------------------------------------------------
    #       Proof functions and counter-example generation

    def get_vars(self, asserts):
        """
        Return a list of ArithRef objects of variables appeared
        in the list of expressions stored in asserts.
        """
        acc = []

        def get_vars_ast(v):
            if(hasattr(v, "children")):
                # hopefully, v is a z3 expression
                if v.children() == []:
                    if not(is_int_value(v) or \
                           is_rational_value(v) or \
                           is_true(v) or is_false(v)):
                        return [v]
                    else:
                        return []
                else:
                    children_lst = []
                    for nu in v.children():
                        children_lst += get_vars_ast(nu)
                    return children_lst
            else:
                return []

        for ast in asserts:
            acc += get_vars_ast(ast)

        return list(set(acc))


    def get_model(self, var_lst):
        m = self.solver.model()
        dontcare_lst = []
        model_lst = []
        for var in var_lst:
            if m.__getitem__(var) == None:
                value = m.eval(var, model_completion = True)
                dontcare_lst.append([var, value])
            else:
                value = m.eval(var)
                model_lst.append([var, value])
        return [model_lst, dontcare_lst]


    def translate_to_acl2(self, model_lst, dontcare_lst):
        model_acl2 = []
        dontcare_acl2 = []

        def translate_value(n, v):
            if (is_algebraic_value(v)):
                rt_obj = str(v.sexpr())
                rt_obj = rt_obj.replace("root-obj", "cex-root-obj " + "'" + n + " state")
                rt_obj = rt_obj.replace("(+", "'(+")
                translated_v = rt_obj
            else:
                translated_v = str(v).replace(".0", "").replace("False", "nil").replace("True","t")
            return translated_v

        def translate_model(model):
            m = model[0]
            name = m.decl().name()
            value = model[1]
            return "(" + name + " " + translate_value(name, value) + ")"

        model_acl2 = [translate_model(model) for model in model_lst]
        dontcare_acl2 = [translate_model(model) for model in dontcare_lst]
        return [model_acl2, dontcare_acl2]


    def proof_counterExample(self):
        asserts = self.solver.assertions()
        var_lst = self.get_vars(asserts)
        [model_lst, dontcare_lst] = self.get_model(var_lst)
        [model_acl2, dontcare_acl2] = self.translate_to_acl2(model_lst, dontcare_lst)

        print "'(" + " ".join(model_acl2+dontcare_acl2) + ")"
        print "Without dontcares: " + "'(" + " ".join(model_acl2) + ")"

    def proof_success(self):
        print "proved"

    def proof_fail(self):
        print "failed to prove"

    # usage prove(claim) or prove(hypotheses, conclusion)
    def prove(self, hypotheses, conclusion=None):
        if(conclusion is None): claim = hypotheses
        else: claim = Implies(hypotheses, conclusion)

        self.solver.push()
        self.solver.add(Not(claim))
        res = self.solver.check()

        if res == unsat: self.proof_success()
        elif res == sat: self.proof_counterExample()
        else: self.proof_fail()

        self.solver.pop()
        return(self.status(res == unsat))
