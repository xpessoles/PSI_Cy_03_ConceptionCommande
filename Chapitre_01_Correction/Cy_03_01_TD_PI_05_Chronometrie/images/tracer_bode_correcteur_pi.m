clear all
close all
scrsz = get(0,'ScreenSize');

wf=9/10;
hf=4/5;
figsize=[0 0  0.9*scrsz(3) 0.9*scrsz(4)];
pathsave='';
%------------------
Kp=1;
K2=2.78*1e-2;
K1=856;
Tm=3*1e-2;
Cr0=2.3*1e-3;

G=K1*Kp;
Ti=1





%Calcul de la fonction de transfert
%---------------------------------------


%tracer des diagrammes de bode
varlogw=-1:0.01:3;
varw=10.^(varlogw);
varlogw_scale=10.^(-4:1:4);

HPI=Kp*(1+Ti*i*varw)./(Ti*i*varw);
HBO=G./((i*varw).*(1+Tm*i*varw));

HBO_cor=HBO.*HPI;

vgainBO=abs(HBO);
vphiBO=angle(HBO);

vgainBO_cor=abs(HBO_cor);
vphiBO_cor=angle(HBO_cor);


asymp1=G./(i*varw);
asymp1(find(varw>=1/Tm))=G./((i*varw(find(varw>=1/Tm))).*(Tm*i*varw(find(varw>=1/Tm))));
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

semilogx(varw,20*log(abs(vgainBO))/log(10),'b-','linewidth',3)
semilogx(varw,20*log(abs(vgainBO_cor))/log(10),'r-','linewidth',3)
%line([1/Tm,1/Tm],[20*log(Kp*K1)+10,-160],'color','k','linestyle','--','LineWidth',2);
%semilogx(varw,20*log(abs(asymp1))/log(10),'k--','linewidth',3)

xlim([10^(-1) 10^3])
ylim([-40 80])
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
print('-depsc','bode_gain_bo_pi');


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


semilogx(varw,vphiBO*180/pi,'b-','linewidth',3)
semilogx(varw,vphiBO_cor*180/pi,'r-','linewidth',3)
%line([1/Tm,1/Tm],[-190,10],'color','k','linestyle','--','linewidth',2);

%semilogx(varw,phi_asymp1,'k--','linewidth',3)
xlim([10^(-1) 10^3])
ylim([-190 10])


xlabel('$\omega (rad\cdot s^{-1})$','fontsize',25,'interpreter','latex');
ylabel('$\varphi (^{\circ})$','fontsize',25,'interpreter','latex');
xlabh = get(gca,'xlabel');
set(xlabh,'position',get(xlabh,'position') - [0 6 0])
set(figure2,'paperpositionmode','auto');
print('-depsc','bode_phase_BO_pi');
