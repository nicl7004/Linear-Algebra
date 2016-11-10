function cl = Vortex_Panel(x,y,V_inf,alpha,n,g,boo)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
alpha=alpha*(pi/180);
N=length(x)-1;
%% Define Critical Points and theta from those points
for i=1:N
    xc(i)=(x(i)+x(i+1))/2;
    yc(i)=(y(i)+y(i+1))/2;
    s(i)=((x(i+1)-x(i))^2+(y(i+1)-y(i))^2)^(0.5);
    Y=y(i+1)-y(i);
    X=x(i+1)-x(i);
    theta(i)=atan2(Y,X);
    RHS(i)=sin(theta(i)-alpha);
end
N=length(x)-1;
%% Define System of equations
for i=1:N
    for j=1:N
        if i==j;
            CN1(i,j)=-1;
            CN2(i,j)=1;
            CT1(i,j)=pi/2;
            CT2(i,j)=pi/2;
        else
            A=-(xc(i)-x(j))*cos(theta(j))-(yc(i)-y(j))*sin(theta(j));
            B=(xc(i)-x(j))^2+(yc(i)-y(j))^2;
            C=sin(theta(i)-theta(j));
            D=cos(theta(i)-theta(j));
            E=(xc(i)-x(j))*sin(theta(j))-(yc(i)-y(j))*cos(theta(j));
            F=log(1+(s(j)^2+2*A*s(j))/B);
            G=atan2((E*s(j)),(B+A*s(j)));
            P=(xc(i)-x(j))*sin(theta(i)-2*theta(j))+(yc(i)-y(j))*cos(theta(i)-2*theta(j));
            Q=(xc(i)-x(j))*cos(theta(i)-2*theta(j))-(yc(i)-y(j))*sin(theta(i)-2*theta(j));
            CN2(i,j)=D+0.5*Q*F/s(j)-(A*C+D*E)*G/s(j);
            CN1(i,j)=0.5*D*F+C*G-CN2(i,j);
            CT2(i,j)=C+0.5*P*F/s(j)+(A*D-C*E)*G/s(j);
            CT1(i,j)=0.5*C*F-D*G-CT2(i,j);
        end
    end
end
for i=1:N
    AN(i,1) = CN1(i,1);
    AN(i,N+1) = CN2(i,N);
    AT(i,1) = CT1(i,1);
    AT(i,N+1) = CT2(i,N);
    for j=2:N
        AN(i,j) = CN1(i,j) + CN2(i,j-1);
        AT(i,j) = CT1(i,j) + CT2(i,j-1);
    end
end
AN(N+1,1) = 1;
AN(N+1,N+1) = 1;
RHS(N+1) = 0;
for j=2:N
    AN(N+1,j) = 0;
end
RHS=RHS';
gamma=(AN\RHS);
cl=0;
for i=1:N
    temp=0;
    for j=1:N+1
        temp2=AT(i,j)*gamma(j);
        temp=temp+temp2;
    end
    V(i)=cos(theta(i)-alpha)+temp;
    Cp(i)=1-(V(i))^2;
end
%^ method from Kuethe and Chow 
c=max(x)-min(x);
Vt=V*V_inf;
gamma=sum(Vt.*s);
cl=2*gamma/(V_inf*c);
%^cl calculation
if boo==0
    I1=(length(y)-1)/2+1;
    cl=trapz(x(I1:N),(Cp(I1:N)));
end
%^ C_p on top side if boo=0
if boo==1
    hold on
    xc=xc/(max(x)-min(x));
    subplot(g,g,n);
    plot(xc/c,Cp,'b');
    AoA=num2str(alpha*180/pi);
    title_N=strcat('C_p for NACA 0012 AoA=',AoA);
    title(title_N);
    set(gca,'YDir','Reverse');
    xlabel('x/c');
    ylabel('C_p');
end
%^ C_p plot is boo=1
end

