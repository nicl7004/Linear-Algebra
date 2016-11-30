function [ h ] = size( f )
%change the scale of the passed in object

x = f(1,1);
y = f(2,1);
z = f(3,1);
h = [x 0 0 0 ; 0 y 0 0 ; 0 0 z 0 ; 0 0 0 1];


end

