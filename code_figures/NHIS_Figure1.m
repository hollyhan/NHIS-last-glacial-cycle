

%Figure 1
% find index in for variables from coupled simulations (size 1X1301), while variables from the uncoupled simulation (ice sheet model alone) has size of 1X131
for i=1:131%length(time_fort22)%length(time)
    
    if i==1 
        n=i;
    else

        n=(i-1)*10+1 ;% for 1301 index
    end
    f(i)=n; % f is the index for time_coupled to be consistent with time1
end

%Figure 1a
figure('Color', [ 1 1 1])
plot(time_uncoup(11:end),toti_full(f(11:end)),'b','LineWidth',2)
hold on
plot(time_uncoup(11:end),toti_noIOG(f(11:end)),'b-.','Linewidth',2)

plot(time_uncoup(11:end),toti_rigid(f(11:end)),'r','LineWidth',2)
plot(time_uncoup(11:end),toti_rigid_noIOG(f(11:end)),'r-.','LineWidth',2)
plot(time_uncoup(11:end),toti_uncoup(11:end),'Color',[0.5 0.5 0.5],'LineWidth',2)
leg = legend('deformable Earth, IOG','deformable Earth, NoIOG','rigid Earth, IOG','rigid Earth, NoIOG','uncoupled')
leg.FontSize=15;
leg.Location='northwest';
legend boxoff
% title('Ice Volume','fontsize',18)
ylabel('volume, m^3','fontsize',18)
xlabel('time (in Ka)','fontsize',18)
set(gca, 'XDir','reverse')
set(gca,'FontSize',18)
 
 
%%

%figure 1b -ice volume in a unit of GMSLE 
figure('Color', [ 1 1 1])
plot(time_uncoup(11:end),Eus_NAIS_wrt_present(11:end),'k','LineWidth',2)
hold on
plot(time_uncoup(11:end),Eus_EIS_wrt_present(11:end),'k-.','LineWidth',2)
plot(time_uncoup(11:end),Eus_GIS_wrt_present(11:end),'k:','LineWidth',2)
title('GMSLE relative to present','fontsize',18)
ylabel('sea level (m)','fontsize',18)
xlabel('time (in Ka)','fontsize',18)
set(gca, 'XDir','reverse')
set(gca,'FontSize',18)
leg = legend('North American Ice Sheet','Eurasian Ice Sheet','Greenland Ice Sheet')
leg.FontSize=14;
leg.Location='southwest';

%%
%figure 1c - rate of change of the ice volume in GMSLE
figure('Color', [ 1 1 1])
plot(time_uncoup(11:end),deus_NAIS(11:end),'k','LineWidth',2)
hold on
plot(time_uncoup(11:end),deus_EIS(11:end),'k-.','LineWidth',2)
plot(time_uncoup(11:end),deus_GIS(11:end),'k:','LineWidth',2)

leg = legend('North American Ice Sheet','Eurasian Ice Sheet','Greenland Ice Sheet')
leg.FontSize=14;
title('rate of GMSLE change','fontsize',18)
ylabel('sea level change (m/ky)','fontsize',18)
xlabel('time (in Ka)','fontsize',18)
set(gca, 'XDir','reverse')
set(gca,'FontSize',18)
leg.Location='southeast';
