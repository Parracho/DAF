%%
clear all
close all
clc

alpha_0 = 2;
beta = 1;
gama = 1;
v = 0.5;
dT = 0.05;
%dT = 0.1;
Tc1 = 130;
Tc2 = 100;
Tf = 160;

PsiMax = 17; 
PsiMin = 0;


%%

alpha_1 = @ (T) alpha_0 * (T-Tc1);
alpha_2 = @ (T) alpha_0 * (T-Tc2);

psi_1_coup = zeros(Tc1/dT-1,1);
psi_2_coup = zeros(Tc1/dT-1,1);
psi_1_noCoup = zeros(Tc1/dT-1,1);
psi_2_noCoup = zeros(Tc1/dT-1,1);


i = 0;
T = 0:dT:Tf;
PsiMax_noCoup = PsiMax;
PsiMin_noCoup = PsiMin;
for t = T
    i=i+1;
    "T: " + i + " - " + length(T)
    out = solve_F(alpha_0,beta,gama,v,Tc1,Tc2,t,PsiMax,PsiMin);
    psi_1_coup(i) = out(1);
    psi_2_coup(i) = out(2);
    PsiMax = max([psi_1_coup(i),psi_2_coup(i)]) * (1.3);
    PsiMin = min([psi_1_coup(i),psi_2_coup(i)]) * (0.30);
    
    %No coupling
    out = solve_F(alpha_0,beta,gama,0,Tc1,Tc2,t,PsiMax_noCoup,PsiMin_noCoup);
    psi_1_noCoup(i) = out(1);
    psi_2_noCoup(i) = out(2);
    PsiMax_noCoup = max([psi_1_noCoup(i),psi_2_noCoup(i)]) * (1.3);
    PsiMin_noCoup = min([psi_1_noCoup(i),psi_2_noCoup(i)]) * (0.30);
end
%%
figure(1)
plot(T(1:length(psi_1_noCoup)),psi_1_noCoup,'r--')
hold on
plot(T(1:length(psi_1_noCoup)),psi_2_noCoup,'b--')

figure(2)
plot(T(1:length(psi_1_coup)),psi_1_coup,'r')
hold on
plot(T(1:length(psi_1_coup)),psi_2_coup,'b')

