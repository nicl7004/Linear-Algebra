function [ m ] = translate( p)
%edit orientation of passed in shape
x0 = p(1,1) + 1;
y0 = p(2,1) + 1;
z0 = p(3,1) + 0;
m = [1 0 0 x0; 0 1 0 y0; 0 0 1 z0;0 0 0 1];



end