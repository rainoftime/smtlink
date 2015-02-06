from sys import path
path.insert(0,"/ubc/cs/home/y/yanpeng/project/ACL2/smtlink/z3_interface")
from ACL2_translator import to_smt, Q
s = to_smt()
EXPT_GAMMA_1_MINUS_N=s.isReal("EXPT_GAMMA_1_MINUS_N")
EXPT_GAMMA_N_MINUS_1=s.isReal("EXPT_GAMMA_N_MINUS_1")
EXPT_GAMMA_2N_MINUS_1=s.isReal("EXPT_GAMMA_2N_MINUS_1")
EXPT_GAMMA_2N=s.isReal("EXPT_GAMMA_2N")
N=s.isReal("N")
G1=s.isReal("G1")
V0=s.isReal("V0")
DV=s.isReal("DV")
hypothesis=s.ifx(s.notx(s.lt(N,3)),s.ifx(s.notx(s.lt(640,N)),s.ifx(s.equal(G1,Q(1,3200)),s.ifx(s.notx(s.lt(V0,Q(9,10))),s.ifx(s.notx(s.lt(Q(11,10),V0)),s.ifx(s.notx(s.lt(DV,s.negate(s.times(-2,Q(-1,16000))))),s.notx(s.lt(s.times(-2,Q(-1,16000)),DV)),False),False),False),False),False),False)
conclusion=s.equal(s.plus(s.plus(s.times(EXPT_GAMMA_2N,s.plus(-1,(lambda var0,var1,var2,var3:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var1,var2)))),s.reciprocal(s.plus(1,s.times(1,s.times(var0,var3))))))(s.plus(-1,(lambda var4,var5,var6:s.plus(s.times((lambda var7:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var7)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(var5),s.reciprocal(var6)),s.negate(var4)))(N,V0,G1)),V0,DV,G1))),s.negate(s.times(EXPT_GAMMA_2N,s.plus(-1,(lambda var8,var9,var10,var11:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var9,var10)))),s.reciprocal(s.plus(1,s.times(1,s.times(var8,var11))))))((lambda var12,var13,var14:s.plus(s.times((lambda var15:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var15)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(var13),s.reciprocal(var14)),s.negate(var12)))(N,V0,G1),V0,DV,G1))))),s.plus(s.plus(s.times(EXPT_GAMMA_2N_MINUS_1,s.plus(-1,(lambda var16,var17,var18,var19:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var17,var18)))),s.reciprocal(s.plus(1,s.times(1,s.times(var16,var19))))))((lambda var20,var21,var22:s.plus(s.times((lambda var23:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var23)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(var21),s.reciprocal(var22)),s.negate(var20)))(N,V0,G1),V0,DV,G1))),s.negate(s.times(EXPT_GAMMA_2N_MINUS_1,s.plus(-1,(lambda var24,var25,var26,var27:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var25,var26)))),s.reciprocal(s.plus(1,s.times(1,s.times(var24,var27))))))(s.plus(1,(lambda var28,var29,var30:s.plus(s.times((lambda var31:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var31)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(var29),s.reciprocal(var30)),s.negate(var28)))(N,V0,G1)),V0,DV,G1))))),s.times(EXPT_GAMMA_N_MINUS_1,s.plus(s.times(EXPT_GAMMA_1_MINUS_N,s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(V0,DV)))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(G1,s.plus(-1,N)),(lambda var32:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var32)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(V0)))))))),s.times(EXPT_GAMMA_N_MINUS_1,s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(V0,DV)))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(G1,s.plus(1,s.negate(N))),(lambda var33:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var33)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(V0)))))))))))),s.plus(s.times(EXPT_GAMMA_2N,s.plus((lambda var34,var35,var36,var37:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var35,var36)))),s.reciprocal(s.plus(1,s.times(1,s.times(var34,var37))))))(s.plus(-1,(lambda var38,var39,var40:s.plus(s.times((lambda var41:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var41)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(var39),s.reciprocal(var40)),s.negate(var38)))(N,V0,G1)),V0,DV,G1),s.negate((lambda var42,var43,var44,var45:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var43,var44)))),s.reciprocal(s.plus(1,s.times(1,s.times(var42,var45))))))((lambda var46,var47,var48:s.plus(s.times((lambda var49:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var49)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(var47),s.reciprocal(var48)),s.negate(var46)))(N,V0,G1),V0,DV,G1)))),s.plus(s.times(EXPT_GAMMA_2N_MINUS_1,s.plus((lambda var50,var51,var52,var53:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var51,var52)))),s.reciprocal(s.plus(1,s.times(1,s.times(var50,var53))))))((lambda var54,var55,var56:s.plus(s.times((lambda var57:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var57)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(var55),s.reciprocal(var56)),s.negate(var54)))(N,V0,G1),V0,DV,G1),s.negate((lambda var58,var59,var60,var61:s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(var59,var60)))),s.reciprocal(s.plus(1,s.times(1,s.times(var58,var61))))))(s.plus(1,(lambda var62,var63,var64:s.plus(s.times((lambda var65:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var65)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(var63),s.reciprocal(var64)),s.negate(var62)))(N,V0,G1)),V0,DV,G1)))),s.plus(s.times(s.times(EXPT_GAMMA_N_MINUS_1,EXPT_GAMMA_1_MINUS_N),s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(V0,DV)))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(G1,s.plus(-1,N)),(lambda var66:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var66)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(V0)))))))),s.times(s.times(EXPT_GAMMA_N_MINUS_1,EXPT_GAMMA_N_MINUS_1),s.plus(-1,s.times(s.times(s.times(1,s.reciprocal(s.times(1,1))),s.plus(1,s.times(1,s.plus(V0,DV)))),s.reciprocal(s.plus(1,s.times(1,s.plus(s.times(G1,s.plus(1,s.negate(N))),(lambda var67:s.plus(s.times(1,s.times(s.plus(1,s.times(1,var67)),s.reciprocal(s.times(1,s.times(1,1))))),s.negate(s.reciprocal(1))))(V0))))))))))))
s.prove(hypothesis, conclusion)
