%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

for beta=0:0.1:1
    setup_lung
    cvsolve
    outchecklung
    figure(4)
    plot(beta,PI,'ro')
    hold on 
    plot(beta,PAbar,'go')
    plot(beta,Pabar,'bo')
    plot(beta,Pv,'ko')
end 
legend('Inspired','mean alveolar','mean arterial','venous')
title('Partial pressures vs Beta')
xlabel('Beta')
ylabel('Partial pressure')