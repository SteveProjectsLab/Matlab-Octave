function tempo(tn,un)
% tempo(tn,un)
% disegno in moto
% Input: tn: vettore dei tempi, dimensione (N,1)
%        un: array (N,3) contenente le tre componenti del vettore
%            posizione
% Visualizza le traiettorie del punto

xmin=min(un(:,1));xmax=max(un(:,1)); xr=(xmax-xmin)/5;
ymin=min(un(:,2));ymax=max(un(:,2)); yr=(ymax-ymin)/5;
zmin=min(un(:,3));zmax=max(un(:,3)); zr=(ymax-ymin)/5;
xmin=xmin-xr; xmax=xmax+xr;
ymin=ymin-yr; ymax=ymax+yr;
zmin=zmin-zr; zmax=zmax+zr;

    figNumber=figure( ...
        'Name','Traiettorie del sistema', ...
        'Visible','on');
    axes('Units','normalized', ...
        'Position',[0.1 0.10 0.85 0.85], ...
        'Visible','on');

    set(gca, ...
        'XLim',[xmin xmax],'YLim',[ymin ymax],'ZLim',[zmin zmax], ...
        'XTickMode','auto','YTickMode','auto','ZTickMode','auto', ...
        'XGrid','on','YGrid','on','ZGrid','on', ...
        'Visible','on', ...
        'NextPlot','add', ...
        'View',[37.5,18]);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
%    title(titolo);

color=colormap('colorcube');
lb = 20;
lt=10;
l=length(tn);

    body = animatedline(un(1:lb,1),un(1:lb,2),un(1:lb,3), ...
        'LineStyle','-', ...
        'Color',[0 0.44 0.74],...
        'LineWidth',2);
    tail=animatedline(un(1:lt,1),un(1:lt,2),un(1:lt,3), ...
        'LineStyle','-', ...
        'Color',[0.6 0.8 1],...
        'LineWidth',2);
for j=lb:l-2
j1=j-lt;
 
% Update the plot
 
 addpoints(body,un(j:j+2,1),un(j:j+2,2),un(j:j+2,3))
 addpoints(tail,un(j1:j1+2,1),un(j1:j1+2,2),un(j1:j1+2,3))
 pause(0.001)

end
hold off

