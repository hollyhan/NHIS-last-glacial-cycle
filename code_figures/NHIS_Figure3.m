% Figure 3

%%

%Choose a time slot to plot
time_indx = [401 501]; % for time 80ka and 90ka
time_slice = time_indx(1):20:time_indx(2);
%%
%location of cross section
lat_i = 20;
lat_f = 60;
lon_indx=50; %cross section along this longitude
lon_cross=lon_indx;
lat_indx1=45; % To mark the end of Hudson Bay
lat_indx2=32;

%%
%Fig. 3a-b grounded ice for the deformable Earth+IOG case
for j=1:length(time_indx)
    i = time_indx(j);
    h =  h_full(:,:,i)';
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
    m_contour(lon,lat,GL_full_matrix(:,:,i)','b','linewidth',0.5)
    CT=cbrewer('seq','Blues',length(L)-1);
    colormap(CT);
    caxis([mind maxd]);
    cbh=colorbar();
    set(cbh,'YTick',[mind:2*dl:maxd],'fontsize',18)
    m_plot(lon(lon_indx),lat(lat_i:lat_f),'r-','LineWidth',2)
    m_line(lon(lon_indx-3:lon_indx+3),lat(lat_indx1),'Color','r','LineWidth',3)
    m_line(lon(lon_indx-2:lon_indx+2),lat(lat_indx2),'Color','r','LineWidth',3)
    m_line(lon(lon_indx-4:lon_indx+4),lat(50),'Color','r','LineWidth',3,'LineStyle','--')
    title(['grounded ice thickness at ' ,num2str(time(i)),'ka'],'FontSize',18)
%     print(gcf,'-opengl','-dpdf',['grounded ice thickness at',num2str(time(i)),'ka.pdf'])
end

%%Fig. 3a-b floating ice
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
%Figure 3c - cross section of ice surface and bedrock elevation over Hudson
%Bay for the deformable Earth+IOG case
time_indx = [401 501]; % for time 80ka and 90ka
time_slice = time_indx(1):20:time_indx(2);

hs = hs_full;
hb = hb_full;

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
txt=[num2str(time(yr)),'Ka\newline(Rigid Earth)']
plot(lat(lat_i:lat_f),hs_rigid(lon_cross,lat_i:lat_f,time_indx(1)),'m-','LineWidth',2,'DisplayName',txt);
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

plot(lat(lat_i:lat_f),hb_rigid(lon_cross,lat_i:lat_f,time_slice(1)),'m--','LineWidth',2);
plot(lat(lat_i:lat_f),zeroline,'r-','LineWidth',1)


plot([lat(lat_indx1) lat(lat_indx1)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)
plot([lat(lat_indx2) lat(lat_indx2)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)
plot([lat(50) lat(50)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)

set(gca,'FontSize',18)
xlabel('latitude (deg N)')
ylabel ('elevation (m)')
grid on


%%

%Fig. 3d-e grounded ice for the rigid Earth+IOG case
for j=1:length(time_indx)
    i = time_indx(j);
    h =  h_rigid(:,:,i)';
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
    m_contour(lon,lat,GL_rigid_matrix(:,:,i)','b','linewidth',0.5) %draw groundling lines
    CT=cbrewer('seq','Blues',length(L)-1);
    colormap(CT);
    caxis([mind maxd]);
    cbh=colorbar();
    set(cbh,'YTick',[mind:2*dl:maxd],'fontsize',18)
    m_plot(lon(lon_indx),lat(lat_i:lat_f),'r-','LineWidth',2)
    m_line(lon(lon_indx-3:lon_indx+3),lat(lat_indx1),'Color','r','LineWidth',3)
    m_line(lon(lon_indx-2:lon_indx+2),lat(lat_indx2),'Color','r','LineWidth',3)
    m_line(lon(lon_indx-4:lon_indx+4),lat(50),'Color','r','LineWidth',3,'LineStyle','--')
    title(['grounded ice thickness at ' ,num2str(time(i)),'ka'],'FontSize',18)
%     print(gcf,'-opengl','-dpdf',['grounded ice thickness at',num2str(time(i)),'ka.pdf'])
end

%%Fig. 3d-e floating ice
for j=1:length(time_indx)
    i = time_indx(j);
    h = hf_rigid(:,:,i)';
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
%Figure 3f - cross section of ice surface and bedrock elevation over Hudson
%Bay on the rigid Earth+IOG case
time_indx = [401 501]; % for time 80ka and 90ka
time_slice = time_indx(1):20:time_indx(2);

hs = hs_rigid;
hb = hb_rigid;

figure()
hold on
count=1;
e = 0:0.2:1; %for color gradient for the plot
% R1 = 0.5;
% G1 = 0.1;
% B1 = 0.1;
R1 = 0.5;
G1 = 0.5;
B1 = 0.9;
txt=[num2str(time(time_slice(1))),'Ka']
plot(lat(lat_i:lat_f),hs_rigid(lon_cross,lat_i:lat_f,time_indx(1)),'m-','LineWidth',2,'DisplayName',txt);
for i=2:length(time_slice);
    yr=time_slice(i);
    c = e(count);
    txt=[num2str(time(yr)),'Ka'];
    plot(lat(lat_i:lat_f),hs(lon_cross,lat_i:lat_f,yr),'Color',[R1,c,B1],'LineStyle','-','LineWidth',2,'DisplayName',txt);
    hold on
    count = count+1;
end 

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

plot(lat(lat_i:lat_f),hb_rigid(lon_cross,lat_i:lat_f,time_slice(1)),'m--','LineWidth',2);
plot(lat(lat_i:lat_f),zeroline,'r-','LineWidth',1)


plot([lat(lat_indx1) lat(lat_indx1)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)
plot([lat(lat_indx2) lat(lat_indx2)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)
plot([lat(50) lat(50)],[-700 250],'LineWidth',1, 'Color','r','LineStyle','-','LineWidth',1)

set(gca,'FontSize',18)
xlabel('latitude (deg N)')
ylabel ('elevation (m)')
ylim([cmin cmax]);
set(gca,'YTick',[cmin:1000:cmax])
grid on
%  print(gcf,'-opengl','-dpdf',['ice surface and bedrock elevation across HB (rigid Earth).pdf'])