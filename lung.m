%filename: lung.m (main program)
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

setup_lung
cvsolve
outchecklung  

%% Healthy Old 
% VA vs Q plot 
% R plot 
% R histogram 
% O2 Blood and Air Concentration vs VP Ratio
% O2 Partial Pressures vs VP Ratio

global Pstar cstar n maxcount M Q camax RT cI;

dis_fac=0;
VAr_dis=1;
Qr_dis=1;
beta=0.5;
beta_d = beta/VAr_dis;

setup_lung
cvsolve
outchecklung 

%% Healthy Old
% Partial pressure vs Beta 

clear all 
clf

global Pstar cstar n maxcount M Q camax RT cI;

dis_fac=0;
VAr_dis=1;
Qr_dis=1;

for beta=0.4:0.01:0.6
    beta_d=beta/VAr_dis;
    setup_lung
    cvsolve
    outchecklung
   
    figure(6)
    plot(beta,PI,'ro')
    hold on 
    plot(beta,PAbar,'go')
    plot(beta,Pabar,'bo')
    plot(beta,Pv,'ko')
end

legend('Inspired','Mean Alveolar','Mean Arterial','Venous')
title('Partial Pressure vs Beta')
xlabel('Beta')
ylabel('Partial Pressure')

%% Healthy Old 
% Partial Pressures of % Lung Affected

%this is the disease factor

clear all 
clf

global Pstar cstar n maxcount M Q camax RT cI;

VAr_dis=1;
Qr_dis=1;
beta=0.5;
beta_d = beta/VAr_dis;

for dis_fac=0:0.01:0.05
    setup_lung
    cvsolve
    outchecklung
   
    figure(7)
    plot(dis_fac,PI,'ro')
    hold on 
    plot(dis_fac,PAbar,'go')
    plot(dis_fac,Pabar,'bo')
    plot(dis_fac,Pv,'ko')
end

legend('Inspired','Mean Alveolar','Mean Arterial','Venous')
title('Partial Pressure vs Lung Affected by Disease')
xlabel('Lung Affected by Disease')
ylabel('Partial Pressure')

%% Heathy Old 
% Partial pressure vs cstar 

% comment out cstar and cref 
clear all 
clf 

dis_fac=0;
VAr_dis=1;
Qr_dis=1;
beta=.5;
beta_d = beta/VAr_dis;

global Pstar cstar n maxcount M Q camax RT cI;

cref=0.2/(22.4*(310/273));

for cstar=cref:-0.0002:0.00325
    setup_lung
    cvsolve
    outchecklung
   
    figure(8)
    plot(cstar,PAbar,'go')
    hold on
    plot(cstar,Pabar,'bo')
    plot(cstar,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Blood Oxygen Concentration')
    xlabel('Blood Oxygen Concentration')
    ylabel('Partial Pressure')

    figure(9)
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

%% Healthy Old 
% oxygen consumption vs beta 

% comment out M 
% change axis range to be in beta range
% change plot to be equal to the range of beta
clear all
clf
global Pstar cstar n maxcount M Q camax RT cI;

dis_fac=0;
VAr_dis=1;
Qr_dis=1;

qq=0;

for beta=0.4:0.01:0.6
    beta_d = beta/VAr_dis;
    qq=qq+1;
    for M=0:0.005:0.05
        setup_lung
        if(Mdiff(0,r)>0)
            figure(10)
            plot(beta,M,'kx')
            break 
        else 
            cvsolve
            outchecklung
            figure(10)
            betasucc(qq)=M;
            plot(beta,M,'go')
            hold on
            title('Oxygen Consumption vs Beta')
            xlabel('Beta')
            ylabel('Oxygen Consumption')
            axis([0.4 0.6 0 0.05])
        end 
    end 
end
figure(10)
plot([0.4:0.01:0.6],betasucc,'-')

%% Healthy Old 
% O2 Partial pressure adaped to sea level 

% comment out cI

clear all
clf

global Pstar cstar n maxcount M Q camax RT cI;

beta=0.5;
dis_fac=0;
VAr_dis=1;
Qr_dis=1;
beta_d = beta/VAr_dis;
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
    figure(11)
    plot(j,PAbar,'go')
    hold on
    plot(j,Pabar,'bo')
    plot(j,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Altitude')
    xlabel('Altitude (ft)')
    ylabel('Partial Pressure')
    
    figure(12)
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

%% Healthy Old 
% O2 Partial pressure adapted to high elevation 
%RBC make up 60% of blood volume 

% comment out cI
% comment out cstar

clear all
clf

global Pstar cstar n maxcount M Q camax RT cI;

beta=0.5;
dis_fac=0;
VAr_dis=1;
Qr_dis=1;
beta_d = beta/VAr_dis;
cref=0.2/(22.4*(310/273));
cstar=1.5*cref;

pO2=[20.9 20.1 19.4 18.6 17.9 17.3 16.6 16.0 15.4 14.8 14.3 14.3 13.7 13.2 12.7 12.3 11.8 11.4 11.0 10.5 10.1 9.7 9.4 9.0 8.7 8.4 8.1 7.8 7.5 7.2 6.9].*0.01;
Altft=[0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000 17000 18000 19000 20000 21000 22000 23000 24000 25000 26000 27000 28000 29000];

for i=1:1:31
    k=pO2(1,i);
    cI=k/(22.4*(310/273));
    j=Altft(i);
    setup_lung
    cvsolve
    outchecklung
    figure(13)
    plot(j,PAbar,'go')
    hold on
    plot(j,Pabar,'bo')
    plot(j,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Altitude')
    xlabel('Altitude (ft)')
    ylabel('Partial Pressure')
    
    figure(14)
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

%% Healthy Old 
% O2 Partial pressure adaped to sea level with anemia

% comment out cstar 

clear all
clf

global Pstar cstar n maxcount M Q camax RT cI;

beta=0.5;
dis_fac=0;
VAr_dis=1;
Qr_dis=1;
beta_d = beta/VAr_dis;
cref=0.2/(22.4*(310/273));

pO2=[20.9 20.1 19.4 18.6 17.9 17.3 16.6 16.0 15.4 14.8 14.3 14.3 13.7 13.2 12.7 12.3 11.8 11.4 11.0 10.5 10.1 9.7 9.4 9.0 8.7 8.4 8.1 7.8 7.5 7.2 6.9].*0.01;
Altft=[0 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 11000 12000 13000 14000 15000 16000 17000 18000 19000 20000 21000 22000 23000 24000 25000 26000 27000 28000 29000];

for i=1:1:31
    k=pO2(1,i);
    cstar=k/(22.4*(310/273));
    j=Altft(i);
    setup_lung
    cvsolve
    outchecklung
    figure(15)
    plot(j,PAbar,'go')
    hold on
    plot(j,Pabar,'bo')
    plot(j,Pv,'ko')

    legend('mean alveolar','mean arterial','venous')
    title('Partial Pressure vs Altitude')
    xlabel('Altitude (ft)')
    ylabel('Partial Pressure')
    
    figure(16)
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


%% Acute Asthma 
dis_fac=0.5;
VAr_dis=0.1;
Qr_dis=1;
beta=.02;
beta_d = beta/VAr_dis;

%% Severe Asthma 

%% Asthma With Bronchodilator 

%% COPD/ Blood Clot