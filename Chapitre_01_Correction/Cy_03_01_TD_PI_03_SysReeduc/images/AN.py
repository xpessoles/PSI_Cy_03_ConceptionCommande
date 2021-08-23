import math as m
omega,A,B,T_i = 50,6700,0.01,0.05

K_i = (T_i *omega**2*m.sqrt(B**2*omega**2+1))/(A*m.sqrt(1+T_i**2*omega**2))
print(K_i)