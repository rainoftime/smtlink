from sys import path
path.insert(0,"/ubc/cs/home/y/yanpeng/project/ACL2/smtlink/z3_interface")
from ACL2_translator import to_smt, Q
s = to_smt()
EXPT_GAMMA_2_MINUS_2N=s.isReal("EXPT_GAMMA_2_MINUS_2N")
EXPT_GAMMA_1=s.isReal("EXPT_GAMMA_1")
EXPT_GAMMA_2=s.isReal("EXPT_GAMMA_2")
EXPT_GAMMA_2N_MINUS_2=s.isReal("EXPT_GAMMA_2N_MINUS_2")
EXPT_GAMMA_2N_MINUS_1=s.isReal("EXPT_GAMMA_2N_MINUS_1")
EXPT_GAMMA_2N=s.isReal("EXPT_GAMMA_2N")
N=s.isReal("N")
hypothesis=s.ifx(s.lt(s.times(2,N),EXPT_GAMMA_2_MINUS_2N),s.notx(s.lt(N,3)),False)
conclusion=s.implies(s.lt(s.times(s.plus(s.times(EXPT_GAMMA_2,s.plus((lambda var0:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.times(var0,Q(1,3200)))))))(s.plus(-1,(lambda var1:s.plus(s.times(s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))),s.reciprocal(Q(1,3200))),s.negate(var1)))(N))),s.negate((lambda var2:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.times(var2,Q(1,3200)))))))((lambda var3:s.plus(s.times(s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))),s.reciprocal(Q(1,3200))),s.negate(var3)))(N))))),s.plus(s.times(EXPT_GAMMA_1,s.plus((lambda var4:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.times(var4,Q(1,3200)))))))((lambda var5:s.plus(s.times(s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))),s.reciprocal(Q(1,3200))),s.negate(var5)))(N)),s.negate((lambda var6:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.times(var6,Q(1,3200)))))))(s.plus(1,(lambda var7:s.plus(s.times(s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))),s.reciprocal(Q(1,3200))),s.negate(var7)))(N)))))),s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(Q(1,3200),s.plus(1,s.negate(N))),s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))))))))))),s.reciprocal(s.plus(1,s.negate(s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(Q(1,3200),s.plus(-1,N)),s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1))))))))))))),s.times(2,N)),s.lt(s.times(s.plus(s.times(EXPT_GAMMA_2,s.plus((lambda var8:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.times(var8,Q(1,3200)))))))(s.plus(-1,(lambda var9:s.plus(s.times(s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))),s.reciprocal(Q(1,3200))),s.negate(var9)))(N))),s.negate((lambda var10:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.times(var10,Q(1,3200)))))))((lambda var11:s.plus(s.times(s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))),s.reciprocal(Q(1,3200))),s.negate(var11)))(N))))),s.plus(s.times(EXPT_GAMMA_1,s.plus((lambda var12:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.times(var12,Q(1,3200)))))))((lambda var13:s.plus(s.times(s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))),s.reciprocal(Q(1,3200))),s.negate(var13)))(N)),s.negate((lambda var14:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.times(var14,Q(1,3200)))))))(s.plus(1,(lambda var15:s.plus(s.times(s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))),s.reciprocal(Q(1,3200))),s.negate(var15)))(N)))))),s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(Q(1,3200),s.plus(1,s.negate(N))),s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1)))))))))))),s.reciprocal(s.plus(1,s.negate(s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,1))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(Q(1,3200),s.plus(-1,N)),s.plus(s.times(s.times(1,s.reciprocal(s.times(1,s.times(1,1)))),s.plus(1,s.times(1,1))),s.negate(s.times(1,s.reciprocal(1))))))))))))),EXPT_GAMMA_2_MINUS_2N))
s.prove(hypothesis, conclusion)
