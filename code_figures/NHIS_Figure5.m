%Figure 5



time_indx=[1161 1171 1181 1191];

for i=time_indx;
  
    figure('Color',[1 1 1])  
    mind=-500;
    dl = 100;
    maxd = 500;
    L=mind:dl:maxd;

    yellow=[1 1 0];


    h_diff = h_full(:,:,i)' - h_noIOG(:,:,i)';
    h_diff(h_diff==0)=NaN;
    

    m_proj('stereographic', 'lon',270,'lat',90,'radius',39.5)
    hold on
    m_contourf(lon,lat,h_diff,L,'edgecolor','none')
    m_contour(lon,lat,GL_noIOG_matrix(:,:,i)','r','linewidth',0.5)
    m_contour(lon,lat,GL_full_matrix(:,:,i)','b','linewidth',0.5)
    m_coast('line','linewidth',0.5,'color','k');

    m_grid('tickdir','out','yticklabels',[],'xticklabels',[],'linestyle','none','ticklen',0,'linewidth',1.5);

    title(['Diff in ice thickness (IOG vs noIOG) at ' num2str(time(i)),' Ka'],'FontSize',17);
    colormap(CT2);
    caxis([mind maxd]);
    cbh=colorbar();
    set(cbh,'YTick',[mind:2*dl:maxd],'fontsize',20)
    
%      print(gcf,'-opengl','-dpdf',['diff_h(IOG_minus_noIOG)_',num2str(time(i)),'ka.pdf'])
end

%%
%bedrock


for i=time_indx;
    mind=-500;
    dl = 50;
    maxd = 0;
    L=mind:dl:maxd;
    CT = cbrewer('div','BrBG',length(L)-1); 

    figure('Color',[1 1 1])
    hb = hb_full(:,:,i)';
    hb(hb<=0)=NaN;
    hb(hb>0 ) = -50000;
 
    m_proj('stereographic', 'lon',270,'lat',90,'radius',39.5)
    hold on
    m_contourf(lon,lat,hb,-50000:5000:0,'edgecolor','none')
    m_grid('tickdir','out','yticklabels',[],'xticklabels',[],'linestyle','none','ticklen',0,'linewidth',0.1);


%     m_contour(lon,lat,GL_noIOG_matrix(:,:,i)','r','linewidth',0.5)
%     m_contour(lon,lat,GL_full_matrix(:,:,i)','b','linewidth',0.5)

    CT(end,:)=[0.85 0.85 0.85];
    colormap(CT)
    
    title(['Bedrock at ' num2str(time(i)),' Ka'],'FontSize',17);
%      print(gcf,'-opengl','-dpdf',['bedrock_',num2str(time(i)),'ka.pdf'])
end
