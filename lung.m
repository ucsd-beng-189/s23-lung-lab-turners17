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

%% Task 6
%filename: lung.m (main program)

clear all
clf
beta=0.5;
global Pstar cstar n maxcount M Q camax RT cI;

cref=0.2/(22.4*(310/273));

pO2=[20.9 20.1 19.4 18.6 17.9 17.3 16.6 16.0 15.4 14.8 14.3 14.3 13.7 13.2 12.7 12.3 11.8 11.4 11.0 10.5 10.1 9.7 9.4 9.0 8.7 8.4 8.1 7.8 7.5 7.2 6.9].*0.01;
Altft=[0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000 17000 18000 19000 20000 21000 22000 23000 24000 25000 26000 27000 28000 29000];

for i=1:1:31
    k=pO2(1,i);
    cI=k/(22.4*(310/273));
    j=Altft(i);
    setup_lung
    cvsolve
    outchecklung
    figure(4)
    plot(j,PAbar,'go')
    hold on
    plot(j,Pabar,'bo')
    plot(j,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Altitude')
    xlabel('Altitude (ft)')
    ylabel('Partial Pressure')
    
    figure(5)
    plot(j,cAbar,'go')
    hold on
    plot(j,cabar,'bo')
    plot(j,cv,'ko')
    crefmat=(ones([1,30])).*cref;
    plot([0:1000:29000],crefmat,'k-')
    legend('mean alveolar','mean arterial','venous','O2 concentration at sea level')
    title('Oxygen concentration vs Altitude')
    xlabel('Altitude (ft)')
    ylabel('Oxygen concentration')
end

%% Task 7
%filename: lung.m (main program)

clear all
clf
beta=0.5;
global Pstar cstar n maxcount M Q camax RT cI;

cref=0.2/(22.4*(310/273));
cstar=(1.5)*cref;

pO2=[20.9 20.1 19.4 18.6 17.9 17.3 16.6 16.0 15.4 14.8 14.3 14.3 13.7 13.2 12.7 12.3 11.8 11.4 11.0 10.5 10.1 9.7 9.4 9.0 8.7 8.4 8.1 7.8 7.5 7.2 6.9].*0.01;
Altft=[0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000 17000 18000 19000 20000 21000 22000 23000 24000 25000 26000 27000 28000 29000];

for i=1:1:31
    k=pO2(1,i);
    cI=k/(22.4*(310/273));
    j=Altft(i);
    setup_lung
    cvsolve
    outchecklung
    figure(4)
    plot(j,PAbar,'go')
    hold on
    plot(j,Pabar,'bo')
    plot(j,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Altitude')
    xlabel('Altitude (ft)')
    ylabel('Partial Pressure')
    
    figure(5)
    plot(j,cAbar,'go')
    hold on
    plot(j,cabar,'bo')
    plot(j,cv,'ko')
    crefmat=(ones([1,30])).*cref;
    plot([0:1000:29000],crefmat,'k-')
    legend('mean alveolar','mean arterial','venous','O2 concentration at sea level')
    title('Oxygen concentration vs Altitude')
    xlabel('Altitude (ft)')
    ylabel('Oxygen concentration')
end

%% Task 8
%filename: lung.m (main program)

clear all
clf

global Pstar cstar n maxcount M Q camax RT cI;

cref=0.2/(22.4*(310/273));

pO2=[20.9 20.1 19.4 18.6 17.9 17.3 16.6 16.0 15.4 14.8 14.3 14.3 13.7 13.2 12.7 12.3 11.8 11.4 11.0 10.5 10.1 9.7 9.4 9.0 8.7 8.4 8.1 7.8 7.5 7.2 6.9].*0.01;
Altft=[0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000 17000 18000 19000 20000 21000 22000 23000 24000 25000 26000 27000 28000 29000];
p=0;
for beta=0:0.2:1
    p=p+1;

    for i=1:1:31
    k=pO2(1,i);
    cI=k/(22.4*(310/273));
    j=Altft(i);
    setup_lung
        if(Mdiff(0,r)>0)
                break 
        else 
    cvsolve
    outchecklung

    PAbarstored(p,i)=PAbar;
    Pabarstored(p,i)=Pabar;
    Pvstored(p,i)=Pv;
    
    cAbarstored(p,i)=cAbar;
    cabarstored(p,i)=cabar;
    cvstored(p,i)=cv;
        end
    end
end

g=[0 0.2 0.4 0.6 0.8 1];
for h=1:1:6
    betaval=g(h);
    figure (4)
    subplot(2,3,h)
    plot(Altft(1,[1:length(PAbarstored)]),PAbarstored(h,:),'g-')
    hold on
    plot(Altft(1,[1:length(Pabarstored)]),Pabarstored(h,:),'b-')
    plot(Altft(1,[1:length(Pvstored)]),Pvstored(h,:),'k-')

    legend('mean alveolar','mean arterial','venous')
    title(sprintf('Partial pressure vs Altitude for Beta=%i', betaval))
    xlabel('Altitude (ft)')
    ylabel('Partial Pressure')
    
    figure(5)
    subplot(2,3,h)
    plot(Altft(1,[1:length(cAbarstored)]),cAbarstored(h,:),'g-')
    hold on
    plot(Altft(1,[1:length(cabarstored)]),cabarstored(h,:),'b-')
    plot(Altft(1,[1:length(cvstored)]),cvstored(h,:),'k-')
    legend('mean alveolar','mean arterial','venous')
    title(sprintf('O2 Concentration vs Altitude for Beta=%i', betaval))
    xlabel('Altitude (ft)')
    ylabel('Oxygen concentration')
    
end

%% Task 9 pt 1
%filename: lung.m (main program)

clear all
clf
beta=0.5;
global Pstar cstar n maxcount M Q camax RT cI;

cref=0.2/(22.4*(310/273));

for cstar=cref:-0.0002:0.00325
    setup_lung
    cvsolve
    outchecklung
   
    figure(4)
    plot(cstar,PAbar,'go')
    hold on
    plot(cstar,Pabar,'bo')
    plot(cstar,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Blood Oxygen Concentration')
    xlabel('Blood Oxygen Concentration')
    ylabel('Partial Pressure')

    figure(5)
    plot(cstar,cAbar,'go')
    hold on
    plot(cstar,cabar,'bo')
    plot(cstar,cv,'ko')

    crefmat=(ones([1,24])).*cref;
    plot([0.00325:0.0002:cref],crefmat,'k-')
    legend('mean alveolar','mean arterial','venous','O2 concentration at sea level')
    title('Oxygen concentration vs Blood Oxygen Concentration')
    xlabel('Blood Oxygen Concentration')
    ylabel('Oxygen concentration')
end

%% Task 9 pt 2
%filename: lung.m (main program)

beta=1;
global Pstar cstar n maxcount M Q camax RT cI;

cref=0.2/(22.4*(310/273));

for cstar=cref:-0.0002:0.00325
    setup_lung
    cvsolve
    outchecklung
   
    figure(4)
    plot(cstar,PAbar,'go')
    hold on
    plot(cstar,Pabar,'bo')
    plot(cstar,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Blood Oxygen Concentration Beta=1')
    xlabel('Blood Oxygen Concentration')
    ylabel('Partial Pressure')

    figure(5)
    plot(cstar,cAbar,'go')
    hold on
    plot(cstar,cabar,'bo')
    plot(cstar,cv,'ko')

    crefmat=(ones([1,24])).*cref;
    plot([0.00325:0.0002:cref],crefmat,'k-')
    legend('mean alveolar','mean arterial','venous','O2 concentration at sea level')
    title('Oxygen concentration vs Blood Oxygen Concentration Beta=1')
    xlabel('Blood Oxygen Concentration')
    ylabel('Oxygen concentration')
end
