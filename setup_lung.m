% filename: setup_lung.m
%heterogeneity parameter (0<=beta<=1):
%beta=0 for homogenous lung
%beta=1 for no ventilation/perfusion correlation
beta=0.5
%
%number of iterations used in bisection:
maxcount=20
%
%number of ``alveoli'':
n=100
%
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

a1=-log(rand(n,1)); %creates vector a1 with random variables that have a mean of 1 and are exponential models ventilation in a nonrealistic way   
a2=-log(rand(n,1)); %creates a vector a2 ""                                                                 " perfusion   "                   "    
av=(a1+a2)/2; % mean of ventilation and perfusion           
VA=VAbar*(a1*beta+av*(1-beta)); % alveolar ventilation based on random distribution a1, ventilation per alveolus, and heterogeneity parameter 
Q = Qbar*(a2*beta+av*(1-beta)); % perfustion based on random distribution a2, expected perfusion per alveolus, and heterogeneity parameter
r=VA./Q; % ventilation perfusion ratio
figure(1)
plot(Q,VA,'.') % ventilation perfusion ratio

%find actual values of 
%VAtotal, Qtotal, VAbar, and Qbar:
VAtotal=sum(VA)
Qtotal =sum(Q)
VAbar=VAtotal/n
 Qbar= Qtotal/n
