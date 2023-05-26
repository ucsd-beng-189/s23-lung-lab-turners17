%filename: outchecklung.m
%starting from the value of cv 
%determined by cvsolve, 
%solve for all other unknowns:
%concentrations and partial pressures 
%in the individual alveoli:
%
%vector of oxygen concentrations in 
%arterial blood leaving each alveolus:
ca=carterial(cv,r);
%
%vector of oxygen partial pressures
%in arterial blood leaving each alveolus:
Pa=H(ca);
%
%vector of oxygen partial pressures 
%in alveolar air:
PA=Pa;
%
%vector of oxygen concentrations
%in alveolar air:
cA=PA/RT;
%
%concentrations and partial pressures 
%for the whole organism:
%(write out these results)
%oxygen concentration in (systemic) venous blood:
cv
%
%mean arterial oxygen concentration:
cabar=Q' *ca/sum(Q)
%  
%mean alveolar oxygen concentration:
cAbar=VA'*cA/sum(VA)
%
%oxygen concentration is the inspired air:
cI
%
%oxygen partial pressure in venous blood:
Pv=H(cv)
%
%mean arterial oxygen partial pressure:
Pabar=H(cabar)
%
%mean alveolar oxygen partial pressure:
PAbar=RT*cAbar
%
%oxygen partial pressure in the inspired air:
PI=RT*cI
% 
%check that partial pressures are in expected order
if((Pv<Pabar)&(Pabar<=PAbar)&(PAbar<PI))
  'partial pressures ordered as expected' 
else
  'WARNING: partial pressures NOT ordered as expected'
  Pv
  Pabar
  PAbar
  PI
end
%
%check that all equations are satisfied
%output a measure of relative residual in each case
%first consider individual-alveolus equations:
fba= Q.*(ca-cv);
faa=VA.*(cI-cA);
check1=max(abs(fba-faa))/max(abs(fba))
check2=max(abs(PA-Pa))/max(abs(PA))
check3=max(abs(PA-RT*cA))/max(abs(PA))
ca_check=cstar*((Pa/Pstar).^3)./(1+(Pa/Pstar).^3);
check4=max(abs(ca-ca_check))/max(abs(ca))
%
%now check that total rate of oxygen transport 
%matches rate of consumption
fb=Q' *(ca-cv); %=sum(Q. *(ca-cv))
fa=VA'*(cI-cA); %=sum(VA.*(cI-cA))
check5=abs(M-fb)/abs(M)
check6=abs(M-fa)/abs(M)
%
%plot various results 
%against the ventilation-perfusion ratio, r:
%(plot individual points instead of lines 
%since r values are not in order)
%define vector with all unit entries:
u=ones(n,1);
cblood=[cv*u cabar*u ca];
cair=  [cI*u cAbar*u cA];
Pressures=[Pv*u Pabar*u PAbar*u PI*u Pa PA];
% figure(4)
% subplot(2,1,1),plot(r,cblood,'.')
% title('O2 Blood Concentration vs Ventilation Perfusion Ratio')
% xlabel('Value of Ventilation-Perfusion Ratio')
% ylabel('O2 Blood Concentrations')
% legend('Venous', 'Mean Arterial','Individual Arterial')
% 
% subplot(2,1,2),plot(r,cair  ,'.')
% title('O2 Air Concentration vs Ventilation Perfusion Ratio')
% xlabel('Value of Ventilation-Perfusion Ratio')
% ylabel('O2 Air Concentrations')
% legend('Inspired', 'Mean Alveolar','Individual Alveoli')
% 
% figure(5)
% plot(r,Pressures,'.')
% title('O2 Partial Pressures vs Ventilation Perfusion Ratio')
% xlabel('Value of Ventilation-Perfusion Ratio')
% ylabel('O2 Partial Pressures')
% legend('Venous Blood', 'Mean Arterial Blood','Mean Alveolar Air', 'Inspired Air', 'Arterial Blood', 'Alveolar Air')