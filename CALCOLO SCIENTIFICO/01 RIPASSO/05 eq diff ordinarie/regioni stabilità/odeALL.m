function edoALL(odefun,tspan,y0,lambda,H)
    i=1;
    for j=1:5
        for h=H
            Nh=fix((tspan(2)-tspan(1))/h);
            if j==1
                [tn,un]=eulero_esp_sys(odefun,tspan,y0,Nh);
                titleName='eulero eplicito'
                plot_stability(1,h,lambda(1),i+1)
                plot_stability(1,h,lambda(2),i+2)
            elseif j==2
                if h==H(1)
                    pause; close all; figure(i);
                end
                [tn,un]=eulero_imp_s(odefun,tspan,y0,Nh);
                titleName='eulero implicito'
                plot_stability(2,h,lambda(1),i+1)
                plot_stability(2,h,lambda(2),i+2)
            elseif j==3
                if h==H(1)
                    pause; close all; figure(i);
                end
                [tn,un]=cranknicolson_s(odefun,tspan,y0,Nh);
                titleName='Crank-Nicolson'
                plot_stability(3,h,lambda(1),i+1)
                plot_stability(3,h,lambda(2),i+2)    
            elseif j==4
                if h==H(1)
                    pause; close all; figure(i);
                end
                [tn,un]=heun(odefun,tspan,y0,Nh);
                titleName='Heun'
                plot_stability(4,h,lambda(1),i+1)
                plot_stability(4,h,lambda(2),i+2)
            elseif j==5
                if h==H(1)
                    pause; close all; figure(i);
                end
                [tn,un]=rk4(odefun,tspan,y0,Nh);
                titleName='RK4'
                plot_stability(5,h,lambda(1),i+1)
                plot_stability(5,h,lambda(2),i+2)
            end
            figure(i)
            % stampo la prima componente
            subplot(2,2,1)
            plot(tn,un(:,1),'.--') % y(t)=y_1(t)
            grid on
            xlabel('t')
            ylabel('v(t)')
            title(titleName)
    
            % stampo la seconda componente
            subplot(2,2,2)
            plot(tn,un(:,2),'.--') % y'(t)=y_2(t)
            grid on
            xlabel('t')
            ylabel('i_1(t)')
            title(['h=',num2str(h)])
    
            % stampo il piano delle fasi
            subplot(2,2,3)
            plot(un(:,1),un(:,2),'.--')
            xlabel('v')
            ylabel('i_1')
            grid on
            hold on 
            plot(y0(1),y0(2),'.--','MarkerFaceColor','r')
            i=i+3;
        end
    end
end

