function [x,y] = NACA_Airfoil(m,p,t,c,N)
%This function uses equations to determine x and y coordinates for a given
%airfoil 4 digit number

if p~=0 && m~=0 %if the airfoil has camber
    xc0=linspace(0,c,N/2+3)/c;
    for i=1:N/2+3
        yt0(i)=(t/0.2)*c*(0.2969*xc0(i)^0.5-0.126*xc0(i)-0.3516*xc0(i)^2+0.2843*xc0(i)^3-0.1015*xc0(i)^4-0.0021*xc0(i)^8);
    end
    %^ Thickness
    pc=find(xc0 >=p*c,1)-1;
    for i=1:pc
        yc0(i)=m*xc0(i)*c/p^2*(2*p-xc0(i));
    end
    for i=pc+1:N/2+3
        yc0(i)=m*(c-xc0(i)*c)/(1-p)^2*(1+xc0(i)-2*p);
    end
    %^camber
    temp=diff(yc0)./diff(xc0*c);
    xc=linspace(0,c,N/2+2)/c;
    for i=1:N/2+2
        yt(i)=(t/0.2)*c*(0.2969*xc(i)^0.5-0.126*xc(i)-0.3516*xc(i)^2+0.2843*xc(i)^3-0.1015*xc(i)^4-0.0021*xc(i)^8);
    end
    pc=find(xc >=p*c,1)-1;
    for i=1:pc
        yc(i)=m*xc(i)*c/p^2*(2*p-xc(i));
    end
    for i=pc+1:N/2+2
        yc(i)=m*(c-xc(i)*c)/(1-p)^2*(1+xc(i)-2*p);
    end
else % for non cambered airfoils
    xc=linspace(0,c,N/2+2)/c;
    for i=1:N/2+2
        yt(i)=(t/0.2)*c*(0.2969*xc(i)^0.5-0.126*xc(i)-0.3516*xc(i)^2+0.2843*xc(i)^3-0.1015*xc(i)^4-0.0021*xc(i)^8);
    end
    yc=zeros(1,N/2+3);
    xs=linspace(0,c,N/2+3)/c;
    temp=diff(yc)./diff(xs*c);
end
epsi=atan(temp);
for i=1:N/2+2
    xu(i)=xc(i)*c-yt(i)*sin(epsi(i));
    xl(i)=xc(i)*c+yt(i)*sin(epsi(i));
    yu(i)=yc(i)+yt(i)*cos(epsi(i));
    yl(i)=yc(i)-yt(i)*cos(epsi(i));
end
%^ considers camber and thickness to create the airfoil
xl=fliplr(xl);
x(1:N/2+2)=xl;
x(N/2+2:N+3)=xu;
yl=fliplr(yl);
y(1:N/2+2)=yl;
y(N/2+2:N+3)=yu;
%^ assembles the coordinates 
end

