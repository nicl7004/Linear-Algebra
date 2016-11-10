%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ASEN 3111 Computational Lab 5
% Author: Nicholas Cenedells
% Date created: 10/28/16
% Purpose: To use Prandtl lifting line theory to calculation preformance
% characteristics of a wing with varied chord, zero lift AoA, aero AoA,
% lift slope
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
%% Question 2
b=40; %ft
rho_inf=0.0023769; % slugs/m^3
c_t=2; %ft
c_r=6; %ft
geo_t=4*pi/180; %rads
geo_r=7*pi/180; %rads
%^define wing characteristics
NACA= ['4412';'2412']; % tip to root airfoil
j=1;
g=1;
boo=2;
%^boolean for vortex panel method
for i=1:2
    NACA_1=NACA(i,1);
    NACA_2=NACA(i,2);
    NACA_3=NACA(i,3);
    NACA_4=NACA(i,4);
    N=150;
    N=N-2;
    c=1;
    m=str2double(NACA_1)/100;
    p=str2double(NACA_2)/10;
    t=str2double(strcat(NACA_3,NACA_4))/100;
    %^ defines Airfoil
    [x,y] = NACA_Airfoil(m,p,t,c,N);
    V_inf=100; % m/s
    alpha_All=[-5,0,5,10]; % AoA in degrees
    for j=1:4
        alpha=alpha_All(j);
        cl = Vortex_Panel(x,y,V_inf,alpha,j,g,boo);
        avcl(j)=cl;
    end
    %^ Defines cl at multiple angles of attack
    coefficients=polyfit(alpha_All*pi/180,avcl,1);
    a0(i)=coefficients(1);
    yintercept=avcl(4)-a0*alpha_All(4)*pi/180;
    a_L0(i)=-yintercept/a0;
    %^ define zero lift AoA and lift slope
end
a0_r=a0(1);
a0_t=a0(2);
aero_r=a_L0(1);
aero_t=a_L0(2);
%^ defines tip and root characteristics
N=50;
[e,c_L_actual,c_Di_actual] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N);
c_L_actual
c_Di_actual
e
%^ calculates cl cDi and e for 50 terms
V_inf=130*(88/60); %ft/s
q_inf=.5*rho_inf*V_inf^2;
S=(b/2)*(c_t+c_r);
L=q_inf*c_L_actual*S;
Di=q_inf*c_Di_actual*S;
%^ calcaulates lift and drag
fprintf('The Lift produced for the finite wing in problem 1 is: %4.2f lb\n', L);
fprintf('The Induced Drag produced for the finite wing in problem 1 is: %4.2f lb\n', Di);
z=1;
v=1;
w=1;
count1=0;
%^ initialize counters and boolean
n=40;
for i=2:n
    count1=count1+1;
    [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,i);
    c_L_er(count1)=c_L;
    c_Di_er(count1)=c_Di;
    if abs(c_Di_actual-c_Di_er(count1))/abs(c_Di_actual) < 0.05 && abs(c_L_actual-...
            c_L_er(count1))/abs(c_L_actual) < 0.05 && z==1
        z=0;
        c_l_5(1)= c_L_er(count1);
        c_Di_5(1)=c_Di_er(count1);
        N_er(1)=i-1;
        %^ for 5 percent error
    elseif abs(c_Di_actual-c_Di_er(count1))/abs(c_Di_actual) < 0.01 && abs(c_L_actual-...
            c_L_er(count1))/abs(c_L_actual) < 0.01 && v==1
        v=0;
        c_l_5(2)=c_L_er(count1);
        c_Di_5(2)=c_Di_er(count1);
        N_er(2)=i-1;
        %^ for 1 percent error
    elseif abs(c_Di_actual-c_Di_er(count1))/abs(c_Di_actual) < 0.001 && abs(c_L_actual-...
            c_L_er(count1))/abs(c_L_actual) < 0.001 && w==1
        w=0;
        c_l_5(3)=c_L_er(count1); 
        c_Di_5(3)=c_Di_er(count1);
        N_er(3)=i-1;
        %^ for 0.1 percent error
    else
        continue
    end
end
t=linspace(1,n-1,n-1);
c_L_actual=c_L_actual*ones(1,n-1);
c_Di_actual=c_Di_actual*ones(1,n-1);
figure(1)
hold on
plot(t,c_L_er)
hold on
plot(t,c_L_actual)
hold on
plot(N_er,c_l_5,'k*');
hold off
title('Error in c_l versus number of odd terms');
xlabel('number of odd terms');
ylabel('c_l');
legend('variable c_l','relative c_l','5,1,0.1 % error','location','northeast');

figure(2)
hold on
plot(t,c_Di_er)
hold on
plot(t,c_Di_actual)
plot(N_er,c_Di_5,'k*');
hold off
title('Error in c_{Di} versus number of odd terms');
xlabel('number of odd terms');
ylabel('c_{Di}');
legend('variable c_{Di}','relative c_{Di}','5,1,0.1 % error','location','northeast');
%^ plots error values versus actual for cl and cDi
%% Question 3
AR_all=[4,6,8,10];
N=N_er(3);
b=40; %ft
a0_t=2*pi;
a0_r=2*pi;
aero_t=1;
aero_r=1;
geo_t=0;
geo_r=0;
%^ define no twist
for i=1:4
    AR=AR_all(i);
    S=b^2/AR;
    ct_cr=linspace(0.01,1,99);
    for j=1:length(ct_cr)
        c_r=(S/b)/(ct_cr(j)+1);
        c_t=ct_cr(j)*c_r;
        [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N);
        e_all(j)=e;
    end
    %^ calculates e for taper ratios from 0 to 1
    figure(3)
    hold on
    plot(ct_cr,e_all);
    %^ plots taper ratio versus e
end

[M,I]=max(e_all);
n=ct_cr(I);
%^ finds where e is at a maximum
title('Span Efficiency Factor as a Function of Taper Ratio');
xlabel('taper ratio');
ylabel('Span Efficiency Factor (e)');
legend('AR=4','AR=6','AR=8','AR=10','Location','south');



