function orbite_2d(xn,un)
% orbite_2d(xn,un)
% preparo le variabili 
xmin=min(un(:,1));xmax=max(un(:,1)); xr=(xmax-xmin)/5;
ymin=min(un(:,2));ymax=max(un(:,2)); yr=(ymax-ymin)/5;
xmin=xmin-xr; xmax=xmax+xr;
ymin=ymin-yr; ymax=ymax+yr;

    figNumber=figure( ...
        'Name','Piano delle fasi', ...
        'Visible','on');
    colordef(figNumber,'white');
    axes( ...
        'Units','normalized', ...
        'Position',[0.05 0.10 0.75 0.95], ...
        'Visible','on');

    axis([-1 1 -1 1]);
    axHndl=gca;
    figNumber=gcf;
    set(axHndl, ...
        'XLim',[xmin xmax],'YLim',[ymin ymax], ...
        'XTick',[],'YTick',[], ...
        'Drawmode','fast', ...
        'Visible','on', ...
        'NextPlot','add', ...
        'View',[0,90]);
    xlabel('X');
    ylabel('Y');

l=length(xn);
plot(un(1:2,1),un(1:2,2))
for k=2:l-1
  plot(un(k:k+1,1),un(k:k+1,2));
  pause(0.01)
end
plot(un(l,1),un(l,2),'or');
