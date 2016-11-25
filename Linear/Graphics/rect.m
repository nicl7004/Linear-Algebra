function h = rect(a,c)
%
% draw a rectangle
%
x = a(:,1);
y = a(:,2);
z = a(:,3);
fill3(x,y,z,c)
hold on
%
end