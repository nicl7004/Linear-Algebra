function h = trap(a,c)
%
% draw a trapezoid
%
x = a(:,1);
y = a(:,2);
z = a(:,3);
fill3(x,y,z,c)
hold on
%
end