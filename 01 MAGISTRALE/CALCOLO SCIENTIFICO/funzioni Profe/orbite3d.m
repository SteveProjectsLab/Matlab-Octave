function orbite3d(tn,un)
% Uso: orbite3d(tn,un)
%
% Input: tn: vettore dei tempi, dimensione (N,1)
%        un: array contenente le tre componenti del vettore spostamento
%            dimension(N,3)
% Visualizza le traiettorie del punto
% materiale vincolato ad una sfera e soggetto ad una 
% forza esterna. 
%

% tempo di pausa durante l'aggiornamento del grafico.
% se l'animazione e' troppo lenta, ridurre il numeratore
% se l'animazione e' troppo veloce, aumentare il numeratore
tpause=20/length(tn);
xmin=-1.2;xmax=1.2;ymin=-1.2;ymax=1.2;zmin=-1.2;zmax=1.2;

    figure( ...
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
 

[X,Y,Z]=sphere(40);
s1=mesh(X,Y,Z);hold on
set(s1,'FaceAlpha',0.3)
axis equal

   h=animatedline;
   set(h,"LineWidth",2)
   view(3);
   for k=1:length(tn)
     addpoints(h,un(k,1),un(k,2),un(k,3));
     drawnow limitrate
     pause(tpause)
   end
hold off
