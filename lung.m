%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

setup_lung
cvsolve
outchecklung

%% Task 3

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
title('Partial Pressure vs Beta')
xlabel('Beta')
ylabel('Partial Pressure')

%% Task 4 

%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

qq=0;

for beta=0:0.1:1
    qq=qq+1;
    for M=0:0.005:0.1
        setup_lung
        if(Mdiff(0,r)>0)
            figure(4)
            plot(beta,M,'kx')
            break 
        else 
            cvsolve
            outchecklung
            figure(4)
            betasucc(qq)=M;
            plot(beta,M,'go')
            hold on
            title('Oxygen Consumption vs Beta')
            xlabel('Beta')
            ylabel('Oxygen Consumption')
            axis([0 1 0 0.1])
        end 
    end 
    figure(5)
    plot(beta,r,'o')
    hold on
    title('Ventilation and Perfusion with varying Beta')
    xlabel('Beta')
    ylabel('Ventilation-Perfusion Ratio')
end
figure(4)
plot([0:0.1:1],betasucc,'-')

%% Task 5 
%filename: lung.m (main program)

clear all
clf
beta=0.5;
global Pstar cstar n maxcount M Q camax RT cI;

cref=0.2/(22.4*(310/273));

for cI=cref:-0.0002:0.00325
    setup_lung
    cvsolve
    outchecklung
    figure(4)
    plot(cI,PAbar,'go')
    hold on
    plot(cI,Pabar,'bo')
    plot(cI,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Oxygen Concentration in Inspired Air')
    xlabel('Oxygen Concentration of Inspired Air')
    ylabel('Partial Pressure')
    axis([0.0032 0.008 0 105])

    figure(5)
    plot(cI,cAbar,'go')
    hold on
    plot(cI,cabar,'bo')
    plot(cI,cv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Oxygen concentration vs Oxygen Concentration in Inspired Air')
    xlabel('Oxygen Concentration of Inspired Air')
    ylabel('Oxygen concentration')
end
