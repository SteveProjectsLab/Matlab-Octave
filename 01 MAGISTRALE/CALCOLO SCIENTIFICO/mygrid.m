function mygrid()
    grid on;
    xL = xlim;
    yL = ylim;
    line([0 0], yL,'color','k','DisplayName','y');  %y-axis
    line(xL, [0 0],'color','k','DisplayName','x');  %x-axis
    xlabel('x');
    ylabel('f(x)')
    legend('-dynamicLegend')
end

