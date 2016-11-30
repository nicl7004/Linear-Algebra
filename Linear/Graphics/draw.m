function[z]= draw(X, c)
%I updated trap and rect into this function
%It seemed more modular to have a single draw function instead of two

x = X(1,:);
y = X(2,:);
z = X(3,:);
fill3(x,y,z,c);
hold on;
end