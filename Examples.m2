--Here is the Gasharov-Peeva example
restart
S = ZZ/101[x_1..x_5]
a = 2--needs to be an element of the multiplicative group of the ground field of infinite order
J = ideal (x_1^2, x_2^2, x_3*x_4, x_3*x_5, x_4*x_5, x_5^2, a*x_1*x_3 + x_2*x_3, x_1*x_4+x_2*x_4, x_3^2 - x_2*x_5 + a*x_1*x_5, x_4^2 - x_2*x_5 + x_1*x_5)
R = S/J--this is the Gasharov-Peeva ring
I = ideal (random(1,R), random(2, R))
C = resolution oo
netList apply (length C, i -> trim ideal C.dd_i)


--The following example is due to Roos from his paper "Good and bad Koszul algebras
--and their Hochschild homology". See pages 302 - 303 of that paper.
--It's an example of a module over a Koszul algebra 
--with transcendental Poincare series. It follows that "Linear Dominance" does not
--hold for this module. 
restart
S = ZZ/2[x, y, z, u, v]--working mod 2 helps keeps computing time down. 
I = (ideal vars S)^2
R = S/I
S' = ZZ/2[X, Y, Z, U, V]
I = (ideal vars S')^2
R' = S'/I
T = R ** R'--this is the Koszul algebra over which we wish to work. I'm copying 
--the notation of Roos.
A = matrix{
    	{x+X, 0,0,0,0,U, V, 0},
	{0, y+Y, 0,0,0,Z,U,V},
	{0,0,z+Z,0,0,y,0,U},
	{0,0,0,u+U,0,x,y,z},
	{0,0,0,0,v+V,0,x,y}
	}
B = matrix{
    	{Y-y, Z-z, U-u,V-v,0,0,0,0,0,0},
	{x-X,0,0,0,Z-z,U-u,V-v,0,0,0},
	{0,x-X,0,0,y-Y,0,0,U-u,V-v,0},
	{0,0,x-X,0,0,y-Y,0,z-Z,0,V-v},
	{0,0,0,x-X,0,0,y-Y,0,z-Z,u-U}
	}
M = coker(A | B) --this is a T-module with transcendental Poincare series. 
--Thus, Linear Dominance does not hold for this module. 
C = res(M, LengthLimit => 5)
netList apply (length C, i -> trim ideal C.dd_i)--Good news: this computation
--doesn't violate our conjecture. Though this example gives limited
--information, since the resolution C is not minimal in degrees 4 and 5 (and
--pruning it seems to take too long). 


--Here is another (simpler) example, due to Roos, of a Koszul algebra
--and a module over it with pathological properties. This is Example 1.3 in the 
--aforementioned paper.
restart
S = ZZ/2[A',B', C']
I = (ideal vars S)^2
R = S/I
S' = ZZ/2[A'', B'', C'']
I' = (ideal vars S')^2
R' = S'/I'
T = R ** R'--This is the Koszul algebra of interest
A = matrix{
    	{0,0,C', B'' + C'', 0},
	{B' + B'', C'' , 0, A', C'+C''},
	{0, C' + C'' + B', A'', A', B' + B''}
	}
M = coker A--And here is a pathological module over it
C = res M
netList apply (7, i -> trim ideal C.dd_i)--One again, this example does not
--obviously violate our conjecture, although we still have the problem
--of non-minimality.
