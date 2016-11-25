function m = main


a = rectpos
b = trappos
%creates a rectangle horixontal to the x axis
%using a ' after a in rect will give a triangle
% a = rot90(a)
horizRect = [0;0;3;0]
rect(a,horizRect)

end