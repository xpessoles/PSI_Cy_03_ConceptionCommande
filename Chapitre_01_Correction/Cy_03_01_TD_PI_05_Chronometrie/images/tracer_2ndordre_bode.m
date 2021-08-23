clear all
close all
scrsz = get(0,'ScreenSize');

wf=9/10;
hf=4/5;
figsize=[0 0  0.9*scrsz(3) 0.9*scrsz(4)];
pathsave='';
%------------------
Ks=25
xiA=0.02;
xiB=0.2;
xiC=0.8;
w0=21.8;
wrA=w0*sqrt(1-2*xiA^2);
wrB=w0*sqrt(1-2*xiA^2);
QA=1/(2*xiA*sqrt(1-xiA^2));
QAdb=20*log(QA)/log(10);
QB=1/(2*xiB*sqrt(1-xiB^2));
QBdb=20*log(QB)/log(10);

%Calcul de la fonction de transfert
%---------------------------------------


%tracer des diagrammes de bode
varlogw=0:0.01:3;
varw=10.^(varlogw);
varlogw_scale=10.^(-4:1:4);
G=20*log(Ks)/log(10);
vFTA=G./((i*varw).^2./w0^2+2*xiA*i*varw/w0+1);
vFTB=G./((i*varw).^2./w0^2+2*xiB*i*varw/w0+1);
vFTC=G./((i*varw).^2./w0^2+2*xiC*i*varw/w0+1);

vgainA=abs(vFTA);
vphiA=angle(vFTA);
vgainB=abs(vFTB);
vphiB=angle(vFTB);
vgainC=abs(vFTC);
vphiC=angle(vFTC);


asymp1=G*ones(1,length(varw));
asymp1(find(varw>=w0))=G./((i*varw(find(varw>=w0))).^2./w0^2);
phi_asymp1=angle(asymp1)*180/pi;
phi_asymp1(find(phi_asymp1==180))=-180;


% %tracer ordre 2
% %---------------------

% 
figure1=figure('position',figsize);
axes1=axes('parent',figure1,'YGrid','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'XMinorGrid','on',...
    'XGrid','on',...
  'position',[0.15 0.15 0.7 0.7],'fontsize',20);
box(axes1,'on');
hold(axes1,'all');


xlim([10^0 10^3])
ylim([-20 60])
% [hx,hy] = format_ticks(gca,{'$10^{-1}$','$10^{0}$','$\frac{1}{T_1}$','$10^{1}$','$\omega_0$','$10^{2}$','$\frac{1}{T_2}$','$10^{3}$'},...
%     {},...
% [10^(-1),10^(0),1/TA1,10^(1),w0,10^(2),1/TA2,10^(3)],[],0,0,0.01,...
% 'fontsize',25,'fontweight','bold');
set(axes1,'XTick',varlogw_scale)
xlabel('$\omega (rad\cdot s^{-1})$','fontsize',25,'interpreter','latex');
ylabel('$G (dB)$','fontsize',25,'interpreter','latex');
xlabh = get(gca,'xlabel');
set(xlabh,'position',get(xlabh,'position') - [0 3 0])
set(figure1,'paperpositionmode','auto');
print('-depsc','bode_gain0');

% 
figure1=figure('position',figsize);
axes1=axes('parent',figure1,'YGrid','on',...
    'XScale','log',...
    'XMinorTick','on',...
    'XMinorGrid','on',...
    'XGrid','on',...
  'position',[0.15 0.15 0.7 0.7],'fontsize',20);
box(axes1,'on');
hold(axes1,'all');

semilogx(varw,20*log(abs(vgainA))/log(10),'r-','linewidth',3)
semilogx(varw,20*log(abs(vgainB))/log(10),'b-','linewidth',3)
semilogx(varw,20*log(abs(vgainC))/log(10),'g-','linewidth',3)
line([w0,w0],[20*log(G)+10,-160],'color','k','linestyle','--','LineWidth',2);
semilogx(varw,20*log(abs(asymp1))/log(10),'k--','linewidth',3)

xlim([10^0 10^3])
ylim([-20 60])
% [hx,hy] = format_ticks(gca,{'$10^{-1}$','$10^{0}$','$\frac{1}{T_1}$','$10^{1}$','$\omega_0$','$10^{2}$','$\frac{1}{T_2}$','$10^{3}$'},...
%     {},...
% [10^(-1),10^(0),1/TA1,10^(1),w0,10^(2),1/TA2,10^(3)],[],0,0,0.01,...
% 'fontsize',25,'fontweight','bold');
set(axes1,'XTick',varlogw_scale)
xlabel('$\omega (rad\cdot s^{-1})$','fontsize',25,'interpreter','latex');
ylabel('$G (dB)$','fontsize',25,'interpreter','latex');
xlabh = get(gca,'xlabel');
set(xlabh,'position',get(xlabh,'position') - [0 3 0])
legend('\xi=0,02','\xi=0,2','\xi=0,8')
set(figure1,'paperpositionmode','auto');
print('-depsc','bode_gain');



% %-------------------------
%Cas 1 phase 

figure2=figure('position',figsize);
axes2=axes('parent',figure2,'ygrid','on',...
    'xscale','log',...
    'xminortick','on',...
    'xminorgrid','on',...
    'xgrid','on',...
  'position',[0.15 0.15 0.7 0.7],'fontsize',20);
box(axes2,'on');
hold(axes2,'all');


xlim([10^0 10^3])
ylim([-190 10])


xlabel('$\omega (rad\cdot s^{-1})$','fontsize',25,'interpreter','latex');
ylabel('$\varphi (^{\circ})$','fontsize',25,'interpreter','latex');
xlabh = get(gca,'xlabel');
set(xlabh,'position',get(xlabh,'position') - [0 6 0])
set(figure2,'paperpositionmode','auto');
print('-depsc','bode_phase0');

figure2=figure('position',figsize);
axes2=axes('parent',figure2,'ygrid','on',...
    'xscale','log',...
    'xminortick','on',...
    'xminorgrid','on',...
    'xgrid','on',...
  'position',[0.15 0.15 0.7 0.7],'fontsize',20);
box(axes2,'on');
hold(axes2,'all');


semilogx(varw,vphiA*180/pi,'r-','linewidth',3)
semilogx(varw,vphiB*180/pi,'b-','linewidth',3)
semilogx(varw,vphiC*180/pi,'g-','linewidth',3)
line([w0,w0],[-190,10],'color','k','linestyle','--','linewidth',2);

semilogx(varw,phi_asymp1,'k--','linewidth',3)
xlim([10^0 10^3])
ylim([-190 10])


xlabel('$\omega (rad\cdot s^{-1})$','fontsize',25,'interpreter','latex');
ylabel('$\varphi (^{\circ})$','fontsize',25,'interpreter','latex');
xlabh = get(gca,'xlabel');
set(xlabh,'position',get(xlabh,'position') - [0 6 0])
legend('\xi=0,02','\xi=0,2','\xi=0,8')
set(figure2,'paperpositionmode','auto');
print('-depsc','bode_phase');
