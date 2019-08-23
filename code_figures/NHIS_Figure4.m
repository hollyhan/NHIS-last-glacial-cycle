% Figure 4
time_indx=[476 490 497];

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
 
    m_proj('stereographic', 'lon',270,'lat',80,'radius',40)
    hold on
    m_contourf(lon,lat,hb,-50000:5000:0,'edgecolor','none')
    m_grid('tickdir','out','yticklabels',[],'xticklabels',[],'linestyle','none','ticklen',0,'linewidth',0.1);

    m_contour(lon,lat,GL_full_matrix(:,:,i)','b','linewidth',0.5)
    m_contour(lon,lat,GL_noIOG_matrix(:,:,i)','r','linewidth',0.5)
    title(['Grounding lines at ', num2str(time(i)),' Ka'],'FontSize',16)

    CT(1,:)=[0.85 0.85 0.85];
    colormap(CT)
end