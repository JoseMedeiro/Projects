* Resistors
* Positive to negative -> Smaller knot to bigger numbered knot

* PHILIPS BJT'S
.MODEL BC557A PNP(IS=2.059E-14 ISE=2.971f ISC=1.339E-14 XTI=3 BF=227.3 BR=7.69 IKF=0.08719 IKR=0.07646 XTB=1.5 VAF=37.2 VAR=11.42 VJE=0.5912 VJC=0.1 RE=0.688 RC=0.6437 RB=1 RBM=1 IRB=1E-06 CJE=1.4E-11 CJC=1.113E-11 XCJC=0.6288 FC=0.7947 NF=1.003 NR=1.007 NE=1.316 NC=1.15 MJE=0.3572 MJC=0.3414 TF=7.046E-10 TR=1m2 ITF=0.1947 VTF=5.367 XTF=4.217 EG=1.11)
.MODEL BC547A NPN(IS=1.533E-14 ISE=7.932E-16 ISC=8.305E-14 XTI=3 BF=178.7 BR=8.628 IKF=0.1216 IKR=0.1121 XTB=1.5 VAF=69.7 VAR=44.7 VJE=0.4209 VJC=0.2 RE=0.6395 RC=0.6508 RB=1 RBM=1 IRB=1E-06 CJE=1.61E-11 CJC=4.388p XCJC=0.6193 FC=0.7762 NF=1.002 NR=1.004 NE=1.436 NC=1.207 MJE=0.3071 MJC=0.2793 TF=4.995E-10 TR=1m2 ITF=0.7021 VTF=3.523 XTF=139 EG=1.11)

Vcc vcc 0 12.0
Vin in 0 0 ac 1.0 sin(0 10m 1k)
Rin in in2 100

* input coupling capacitor
Ci in2 base 	#Cin_val#


* bias circuit
R1 vcc base 	#R1_val#
R2 base 0 	#R2_val#

* gain stage
Q1 coll base emit BC547A
Rc vcc coll 	#Rc_val#
Re emit 0 	#Re_val#

* bypass capacitor
Cb emit 0 	#Cb_val#


* output stage
Q2 0 coll emit2 BC557A
Rout emit2 vcc #Rout_val#

* output coupling capacitor
Co emit2 out 	#Cout_val#

*load resistance
Rl out 0 8

