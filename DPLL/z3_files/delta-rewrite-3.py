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
G1=s.isReal("G1")
V0=s.isReal("V0")
DV=s.isReal("DV")
hypothesis=s.ifx(s.equal(s.times(EXPT_GAMMA_2_MINUS_2N,EXPT_GAMMA_2N_MINUS_2),1),s.ifx(s.equal(EXPT_GAMMA_2N_MINUS_1,s.times(EXPT_GAMMA_2N_MINUS_2,EXPT_GAMMA_1)),s.ifx(s.equal(EXPT_GAMMA_2N,s.times(EXPT_GAMMA_2N_MINUS_2,EXPT_GAMMA_2)),s.ifx(s.notx(s.lt(N,3)),s.ifx(s.equal(G1,Q(1,3200)),s.ifx(s.notx(s.lt(V0,Q(9,10))),s.ifx(s.notx(s.lt(Q(11,10),V0)),s.ifx(s.notx(s.lt(DV,s.negate(s.times(2,Q(-1,16000))))),s.notx(s.lt(s.times(2,Q(-1,16000)),DV)),False),False),False),False),False),False),False),False)
conclusion=s.equal(s.plus(s.times(EXPT_GAMMA_2N,s.plus((lambda var0,var1,var2,var3:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var1,var2)))),s.reciprocal(s.plus(1,s.times(1,s.times(var0,var3))))))(s.plus(-1,(lambda var4,var5:s.plus(s.times(1,s.reciprocal(var5)),s.negate(var4)))(s.floor(N),G1)),V0,DV,G1),s.negate((lambda var6,var7,var8,var9:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var7,var8)))),s.reciprocal(s.plus(1,s.times(1,s.times(var6,var9))))))((lambda var10,var11:s.plus(s.times(1,s.reciprocal(var11)),s.negate(var10)))(s.floor(N),G1),V0,DV,G1)))),s.plus(s.times(EXPT_GAMMA_2N_MINUS_1,s.plus((lambda var12,var13,var14,var15:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var13,var14)))),s.reciprocal(s.plus(1,s.times(1,s.times(var12,var15))))))((lambda var16,var17:s.plus(s.times(1,s.reciprocal(var17)),s.negate(var16)))(s.floor(N),G1),V0,DV,G1),s.negate((lambda var18,var19,var20,var21:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var19,var20)))),s.reciprocal(s.plus(1,s.times(1,s.times(var18,var21))))))(s.plus(1,(lambda var22,var23:s.plus(s.times(1,s.reciprocal(var23)),s.negate(var22)))(s.floor(N),G1)),V0,DV,G1)))),s.plus(s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(V0,DV)))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(G1,s.plus(-1,s.floor(N))),1)))))),s.times(EXPT_GAMMA_2N_MINUS_2,s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(V0,DV)))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(G1,s.plus(1,s.negate(s.floor(N)))),1)))))))))),s.times(EXPT_GAMMA_2N_MINUS_2,s.plus(s.times(EXPT_GAMMA_2,s.plus((lambda var24,var25,var26,var27:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var25,var26)))),s.reciprocal(s.plus(1,s.times(1,s.times(var24,var27))))))(s.plus(-1,(lambda var28,var29:s.plus(s.times(1,s.reciprocal(var29)),s.negate(var28)))(s.floor(N),G1)),V0,DV,G1),s.negate((lambda var30,var31,var32,var33:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var31,var32)))),s.reciprocal(s.plus(1,s.times(1,s.times(var30,var33))))))((lambda var34,var35:s.plus(s.times(1,s.reciprocal(var35)),s.negate(var34)))(s.floor(N),G1),V0,DV,G1)))),s.plus(s.times(EXPT_GAMMA_1,s.plus((lambda var36,var37,var38,var39:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var37,var38)))),s.reciprocal(s.plus(1,s.times(1,s.times(var36,var39))))))((lambda var40,var41:s.plus(s.times(1,s.reciprocal(var41)),s.negate(var40)))(s.floor(N),G1),V0,DV,G1),s.negate((lambda var42,var43,var44,var45:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var43,var44)))),s.reciprocal(s.plus(1,s.times(1,s.times(var42,var45))))))(s.plus(1,(lambda var46,var47:s.plus(s.times(1,s.reciprocal(var47)),s.negate(var46)))(s.floor(N),G1)),V0,DV,G1)))),s.plus(s.times(EXPT_GAMMA_2_MINUS_2N,s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(V0,DV)))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(G1,s.plus(-1,s.floor(N))),1))))))),s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(V0,DV)))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(G1,s.plus(1,s.negate(s.floor(N)))),1)))))))))))
s.prove(hypothesis, conclusion)
