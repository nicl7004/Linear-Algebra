function [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)

n=(1:1:N);
th=n*pi/(2*N);
y=-b/2*cos(th);
c=c_r-(c_t-c_r)*(2*y./(b));
a_L0=aero_r-(aero_t-aero_r)*(2*y./b);
LiftSlope=a0_r-(a0_t-a0_r)*(y./(b/2));
alpha=geo_r-(geo_t-geo_r)*(y./(b/2));
%^Define attributes of the airfoil
k=length(th);
C=zeros(N,k);
%^finds chord at every theta location
for x=1:length(th)
    for k=1:length(th)
        C(k,x)=(4*b/(LiftSlope(k)*c(k))+(2*x-1)/sin(th(k)))*sin((2*x-1)*th(k));
    end
end
%^ Creates Matrix C which when multiplied by the coefficients equals the
%effective angle of attack
D=zeros(k,1);
for i=1:k
    D(i,1)=alpha(i)-a_L0(i);
end
C_I=C^-1;
A=C_I*D;
%^Matrix multiplication to output ceoefficients
delta=0;
for i=2:length(th)
    delta=delta+(2*i-1)*(A(i)/A(1))^2;
end
%^Uses equation for summation to get delta
e=(1+delta)^(-1);
%^finds airfoil efficiency
S=(c_t+c_r)*b/2;
AR=b^2/S;
c_L=A(1)*AR*pi;
c_Di=c_L^2/(AR*pi*e);
end