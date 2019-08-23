%%
% Figure 2
%this plotting code uses variables in 'fig.2.mat' 
%this plotting code code also functions in m_map package for plotting and cbrewer for
%colorbar that can be externally downloaded

addpath('/Users/username/Documents/MATLAB/toolbox/m_map');
addpath('/Users/username/Documents/MATLAB/cbrewer/cbrewer/cbrewer');
%%
%Choose a time slot to plot
time_indx = [101 201]; %for time 120ka 110ka
time_slice = time_indx(1):20:time_indx(2);
%%

lat_i = 20;
lat_f = 60;
lon_indx=50; %cross section along this longitude
lon_cross=lon_indx;
lat_indx1=45; % To mark the end of Hudson Bay
lat_indx2=32; 

%%
%Figure 2a-b
for j=1:length(time_indx)
    i = time_indx(j);
    h =  h_full(:,:,i)'; % ice thickness from the fully-coupled simulation (i.e. "deformable+IOG" simulation)

    h(h==0) =NaN;

    figure() 
    mind=0;
    dl=500;
    maxd=5000;
    L=mind:dl:maxd;
    m_proj('stereographic', 'lon',270,'lat',76,'radius',51.5)
    hold on
    m_contourf(lon,lat,h,L,'edgecolor','none')
    m_coast('line','linewidth',1.8,'color','k');
    m_grid('tickdir','out','yticklabels',[],'xticklabels',[],'linestyle','none','ticklen',0,'linewidth',1.5);
    m_contour(lon,lat,GL_full_matrix(:,:,i)','b','linewidth',0.5) %draw groundling lines
    CT=cbrewer('seq','Blues',length(L)-1);
    colormap(CT);
    caxis([mind maxd]);
    cbh=colorbar();
    set(cbh,'YTick',[mind:2*dl:maxd],'fontsize',18)
    m_plot(lon(lon_indx),lat(lat_i:lat_f),'r-','LineWidth',2) %cross section line along Hudson Bay
    m_line(lon(lon_indx-3:lon_indx+3),lat(lat_indx1),'Color','r','LineWidth',3) %marked points A, B, C along the line on Hudson Bay
    m_line(lon(lon_indx-2:lon_indx+2),lat(lat_indx2),'Color','r','LineWidth',3)
    m_line(lon(lon_indx-4:lon_indx+4),lat(50),'Color','r','LineWidth',3,'LineStyle','--')

%     print(gcf,'-opengl','-dpdf',['ice thickness at',num2str(time(i)),'ka.pdf'])
end
%%Fig. 2a-b floating ice
for j=1:length(time_indx)
    i = time_indx(j);
    h = hf_full(:,:,i)';
    h(h==0) =NaN;
    figure() 
   
    mind=0;
    dl=100;
    maxd=500;
    L=mind:dl:maxd;
    
    m_proj('stereographic', 'lon',270,'lat',76,'radius',51.5)
    hold on
    m_contourf(lon,lat,h,L,'edgecolor','none')
    m_coast('line','linewidth',1.8,'color','k');
    m_grid('tickdir','out','yticklabels',[],'xticklabels',[],'linestyle','none','ticklen',0,'linewidth',1.5);

    CT=cbrewer('seq','RdPu',length(L)-1);
    colormap(CT);
    caxis([mind maxd]);
    cbh=colorbar();
    set(cbh,'YTick',[mind:dl:maxd],'fontsize',18)    
    title(['floating ice thickness at ' ,num2str(time(i)),'ka'],'FontSize',18)
%     print(gcf,'-opengl','-dpdf',['floating ice thickness at ',num2str(time(i)),'ka.pdf'])
end

%%
% Figure 2c
%cross section of surface and bedrock elevation 'hs' and 'hb'
hs = hs_full;
hb = hb_full;
%  hs = hs_rigid;
%  hb = hb_rigid;

figure()
hold on
count=1;
e = 0:0.2:1; %for color gradient for the plot
R1 = 0.5;
G1 = 0.1;
B1 = 0.1;

for yr=time_slice;
    c = e(count);
    txt=[num2str(time(yr)),'Ka'];
    plot(lat(lat_i:lat_f),hs(lon_cross,lat_i:lat_f,yr),'Color',[R1,c,B1],'LineStyle','-','LineWidth',2,'DisplayName',txt);
    hold on
    count = count+1;
end 
txt=[num2str(time(yr)),'Ka\newline(Rigid Earth)'];
plot(lat(lat_i:lat_f),hs_rigid(lon_cross,lat_i:lat_f,time_indx(end)),'m-','LineWidth',2,'DisplayName',txt);
legend show
legend boxoff

count=1;
for yr=time_slice;
    c = e(count);
    txt=[num2str(time(yr)),'Ka'];
    hold on
    count = count+1;
    plot(lat(lat_i:lat_f),hb(lon_cross,lat_i:lat_f,yr),'-.','Color',[R1,c,B1],'LineWidth',2,'DisplayName',txt);
      
end 
zeroline=zeros(1,length(lat_i:lat_f));
plot(lat(lat_i:lat_f),hb_rigid(lon_cross,lat_i:lat_f,time_slice(end)),'m--','LineWidth',2);
plot(lat(lat_i:lat_f),zeroline,'r-','LineWidth',1)


plot([lat(lat_indx1) lat(lat_indx1)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)
plot([lat(lat_indx2) lat(lat_indx2)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)
plot([lat(50) lat(50)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)

set(gca,'FontSize',18)
xlabel('latitude (deg N)')
ylabel ('elevation (m)')

grid on


%%
% Figure 2d
wab_f=[];
wab_r=[];
figure()
i=1;
for j=time_slice(1):time_slice(end)
    wab_f(i)= budgsnow_full(lon_indx,lat_indx2,j)'; %full
    wab_r(i)= budgsnow_rigid(lon_indx,lat_indx2,j)'; %rigid
    i=i+1;
end

plot(time(101:201), wab_f,'k','LineWidth',2)
hold on
plot(time(101:201), wab_r,'r','LineWidth',2)
leg = legend('deformable Earth','rigid Earth')
leg.FontSize=14;
title('Rate of snowfall at point A ','fontsize',18)
ylabel('m/y','fontsize',18)
xlabel('time (in Ka)','fontsize',18)
set(gca, 'XDir','reverse')
set(gca,'FontSize',18)