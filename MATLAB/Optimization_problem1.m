%input values
m=256;
t=linspace(0,1,m)';
y=exp(-128*((t-0.3).^2))-3*(abs(t-0.7).^0.4);
mpdict=wmpdictionary(m,'LstCpt',{'dct',{'wpsym4',2}});
A=full(mpdict);
n= size(A,2) 
d = 0.5;
R = d*ones(m,n);


% L1-norm problem solution with cvx
cvx_begin
    variable x1(n)
    minimize( norm(x1,1) )
    subject to
     A*x1 == y;
cvx_end

% L2-norm problem solution with cvx
cvx_begin
    variable x2(n)
    minimize( norm(x2,2) )
    subject to
     A*x2 == y;
cvx_end


% L1-norm problem solution with cvx with 5% largest entries
cvx_begin
    variable x1(n)
    minimize( norm_largest(x1,1) )
    subject to
     A*x1 == y;
     R*abs(x1);
cvx_end

% L1-norm problem solution with cvx with 5% largest entries
cvx_begin
    variable x2(n)
    minimize( norm_largest(x2,2) )
    subject to
     A*x2 == y;
     R*abs(x2);
cvx_end


