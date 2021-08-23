clear all
close all

Zc0=0.05;
K2=2.78*1E-2;
K1=856;
Tm=3*1E-2;
Cr0=2.7*1E-3;
Cr0=0;
Kp=0.075;
Ti=1;



R=sim('Schema_Complet3','AbsTol','1e-5','MaxStep','1e-5',...
'StopTime','0.5','SaveTime','on','TimeSaveName','tp');
tp=R.get('tp');
s=R.get('simout').data(:,1);
tp=R.get('simout').Time(:,1);

% wf=8/10;
% hf=4/5;
% figsize=[0 0  0.4*scrsz(3) 0.9*scrsz(4)];

figure1 = figure;
axes1 = axes('Parent',figure1);
plot(tp,s,'b-','LineWidth',3)
grid on
% yticks([0:0.1:1.6]);
% xticks([0:0.02:0.2]);

set(axes1,'FontSize',16);
xlabel('temps en s','FontSize',20)
ylabel('y(t) en m','FontSize',20)


scrsz = get(0,'ScreenSize');



print('-depsc','rep_temp');  


