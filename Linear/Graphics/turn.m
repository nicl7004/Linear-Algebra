function [ ro ] = turn( deg, mx )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
Rx = [1 0 0 0; 0 cos(deg) -sin(deg) 0; 0 sin(deg) cos(deg) 0; 0 0 0 1;];
Ry = [cos(deg) 0 sin(deg) 0; 0 1 0 0; -sin(deg) 0 cos(deg) 0; 0 0 0 1;];
Rz = [cos(deg) -sin(deg) 0 0; sin(deg) cos(deg) 0 0; 0 0 1 0 ; 0 0 0 1;];

if(mx == 1)
    ro = Rx;
else if(mx == 2)
    ro = Ry;
    
else if(mx ==3)
    ro = Rz;
    end
    end
end