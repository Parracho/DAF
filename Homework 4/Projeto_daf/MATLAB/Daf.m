%%
clear all
close all
clc

alpha_0 = 10;
beta = 1;
gama = 1;
v = -0.1;
dT = 1;
Tc1 = 100;
Tc2 = 101;
Tf = 200;

%%

alpha_1 = @ (T) alpha_0 * (T-Tc1);
alpha_2 = @ (T) alpha_0 * (T-Tc2);

psi_1 = zeros(Tc1/dT-1,1);
psi_2 = zeros(Tc1/dT-1,1);

i = 0;
T = 0:dT:Tf;
for t = T
    i=i+1;
    "i: " + i + " - " + length(T)
    out = solve_F(alpha_0,beta,gama,v,Tc1,Tc2,t);
    psi_1(i) = out(1);
    psi_2(i) = out(2);
end
%%
plot(T,psi_1,'r')
hold on
plot(T,psi_2,'b')

