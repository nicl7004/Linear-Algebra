% nicholas clement

function m = main
%this script creates all of the matricies and scales/orients them to create
% our house.

% dependices are draw, rect, sized, trap, and turn
p0 = [-2;-2;0];
p1 =[0;-1;0];
p2 =[-1;1;0];
p3 =[-0.75;-1;0];
p5 = [-1.10;-1.1;0.9;];
p6 = [0.099;-1.1;0.9;];
p7 = [-0.25;-1.01;0.03];
p8 = [-0.73;-1.02;-0.00];

c = [4;4;4];
c1 = [2;1;1];
c2 = [1/2;1/2;1/2;];
c3 = [4/5;4/5;4/5;];
c4 = [1.2;2.15;1.05];
c5 = [1/1.50;0.05;1];
c6 = [1/10;0.25;0];

%set up translations
T = translate(p0);
T1 = translate(p1);
T2 = translate(p2);
T3 = translate(p3);
T5 = translate(p5);
T6 = translate(p6);
T7 = translate(p7);
T8 = translate(p8);

%change the different sizes
S = sized(c);
S1 = sized(c1);
S2= sized(c2);
S3 = sized(c3);
S4 = sized(c4);
S5 = sized(c5);
S6 = sized(c6);

P = trappos();
G = rectpos();
R1 = turn(pi/2,3);
R2 = turn(pi/2,1);
R3 = turn(-pi/4,2);
R4 = turn(5*pi/4,2);

Left =R1*(R2*(S1*G));
Right = T1*(Left);
Front = R2*P;
Back = T2 * Front;
Door = R1*(R2*(S2*G));

Leftroof = T5*(R3*(S4*G));
Rightroof = T6*(R4*(S4*G));
 


%Plot the house
%walls
draw(Front, 'y');
draw(Back, 'y');
draw(Left,'y');
draw(Right,'y');
% door
draw(Door, 'r');
% triangle that makes the roof
draw(Rightroof, 'g');
draw(Leftroof, 'g');

A(:,:,1) = [-1;-1.5;0;];
A(:,:,2) = [-.9;-1.5;0;];
A(:,:,3) = [-.8;-1.5;0;];
A(:,:,4) = [-.7;-1.5;0;];
A(:,:,5) = [-.6;-1.5;0;];
A(:,:,6) = [-.5;-1.5;0;];
A(:,:,7) = [-.4;-1.5;0;];
A(:,:,8) = [-.3;-1.5;0;];
A(:,:,9) = [-.2;-1.5;0;];
A(:,:,10) = [-.1;-1.5;0;];
%draw fence
 for i = 1:10
     fence = translate(A(:,:,i))*(R2*(S6*P));
     drawshape(fence, 'b');
 end



grid on;
 axis([-0.5 1.5 -0.5 2.5 0 1.5]);
