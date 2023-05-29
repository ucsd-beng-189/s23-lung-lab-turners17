% filename: setup_lung.m
%heterogeneity parameter (0<=beta<=1):
% beta=0.2 % for homogenous lung
%beta=1 for no ventilation/perfusion correlation
% beta=0.5
%
%number of iterations used in bisection:
maxcount=20
%
%number of ``alveoli'':
n=10000
%
%cvzero=0.0057; % normal resting venous oxygen conentration

%reference oxygen concentration (moles/liter):
 cref=0.2/(22.4*(310/273))
%cref=concentration of oxygen 
%in air at sea level at body temperature
%
%oxygen concentration in the inspired air:
% 
 cI=cref
%
%blood oxygen concentration
%at full hemoglobin saturation: 
 cstar=cref
%cstar=4*(concentration of hemoglobin 
%in blood expressed in moles/liter)
%
%rate of oxygen consumption (moles/minute):
M=0.25*cref*5.6
%
%oxygen partial pressure 
%at which hemoglobin is half-saturated:
Pstar=25
%
%gas constant*absolute temperature 
%(mmHg*liters/mole):
RT=760*22.4*(310/273)
%
%oxygen partial pressure 
%in the inspired air (mmHg):
PI=RT*cI
%
%oxygen concentration
%in blood exposed directly to inspired air:
camax=cstar*(PI/Pstar)^3/(1+(PI/Pstar)^3)
%camax is an upper bound 
%on oxygen concentration in blood 
%
%expected value of total alveolar ventilation:
VAtotal=5.0     %(liters/minute)
%
%expected value of total perfusion:
Qtotal=5.6      %(liters/minute)
%
%expected alveolar ventilation per alveolus:
VAbar=VAtotal/n
%
%expected perfusion per alveolus: 
Qbar=Qtotal/n 

% dis_fac=0.5;
% VAr_dis=0.1;
% Qr_dis=1;
% beta=.02;
% beta_d = beta/VAr_dis;

n_norm=n*(1-dis_fac);
n_norm=round(n_norm); 

n_dis = n*dis_fac;
n_dis=round(n_dis);

a1n=-log(rand(n_norm,1)); %creates vector a1 with random variables that have a mean of 1 and are exponential models ventilation in a nonrealistic way   
a2n=-log(rand(n_norm,1)); %creates a vector a2 ""                                                                 " perfusion   "                   "    
avn=(a1n+a2n)/2; % mean of ventilation and perfusion           
VAn=VAbar*(a1n*beta+avn*(1-beta)); % alveolar ventilation based on random distribution a1, ventilation per alveolus, and heterogeneity parameter 
Qn= Qbar*(a2n*beta+avn*(1-beta)); % perfustion based on random distribution a2, expected perfusion per alveolus, and heterogeneity parameter

a1_d=-log(rand(n_dis,1)); %creates vector a1 with random variables that have a mean of 1 and are exponential models ventilation in a nonrealistic way   
a2_d=-log(rand(n_dis,1)); %creates a vector a2 ""                                                                 " perfusion   "                   "    
av_d=(a1_d+a2_d)/2; % mean of ventilation and perfusion           
VA_d=VAr_dis*VAbar*(a1_d*beta_d+av_d*(1-beta_d)); % alveolar ventilation based on random distribution a1, ventilation per alveolus, and heterogeneity parameter 
Q_d = Qr_dis*Qbar*(a2_d*beta_d+av_d*(1-beta_d)); % perfustion based on random distribution a2, expected perfusion per alveolus, and heterogeneity parameter

VA=[VAn; VA_d];
Q=[Qn; Q_d];


r=VA./Q; % ventilation perfusion ratio
% figure(1)
% plot(Q,VA,'.') % ventilation perfusion ratio
% title('Ventilation Perfusion Ratio')
% ylabel('Ventilation')
% xlabel('Perfusion')
% 
% figure(2)
% plot(r,'.')
% title('Ventilation Perfusion Ratio for each Alveoli')
% ylabel('Value of Ventilation-Perfusion Ratio')
% xlabel('Alveoli')
% axis([0 10000 0 1])
% figure(3)
% 
% hist(r,[0:0.01:3])
% title('Histogram of Ventilation Perfusion Ratio for each Alveoli')
% xlabel('Value of Ventilation-Perfusion Ratio')
% ylabel('Number of Alveoli')
% axis([0 3 0 140])
% % % 
% % % % find actual values of 
% % % % VAtotal, Qtotal, VAbar, and Qbar:
% % % % VAtotal=sum(VA)
% % % % Qtotal =sum(Q)
% % % % VAbar=VAtotal/n
% % % %  Qbar= Qtotal/n
