% Author: aleksander.grm@fpp.uni-lj.si
% Date: 20/09/2017

function plot_ts( n, e, x )
%plot_td plots the truss system with solution x

    fig = figure('Name','Truss System');
    hold on
    
    % plot edges
    for i = 1:length(e)
        ex = n([e(i,1) e(i,2)], 1);
        ey = n([e(i,1) e(i,2)], 2);
        
        dn = n(e(i,2),:) - n(e(i,1),:);
        emx = mean(ex);
        emy = mean(ey);
        
        if x(i) < 0
            plot(ex, ey, 'r-', 'LineWidth', 2)
            plot(emx, emy, 'or','MarkerSize', 16);
        elseif x(i) == 0
            plot(ex, ey, 'b-', 'LineWidth', 2)
            plot(emx, emy, 'oblue','MarkerSize', 16);
        else
            plot(ex, ey, 'g-', 'LineWidth', 2)
            plot(emx, emy, 'og','MarkerSize', 16);
        end
        
        if dn(1) == 0
            text(emx, emy, num2str(i),...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'FontWeight', 'bold'); 
        elseif dn(2) == 0
            text(emx, emy, num2str(i),...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'FontWeight', 'bold'); 
        else
            text(emx, emy, num2str(i),...
                'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FontSize', 14, 'FontWeight', 'bold'); 
        end
        
    end
    
    % plot nodes
    plot(n(:,1), n(:,2), 'oblack','MarkerSize', 16);
    for i= 1:length(n)
        text(n(i,1), n(i,2), num2str(i),...
            'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle',...
            'FontSize', 14, 'FontWeight', 'bold', 'Color', 'black'); 
    end
    
    k = 0.1;
    minX = min(n(:,1));
    maxX = max(n(:,1));
    dX = (maxX - minX)*k;
    minY = min(n(:,2));
    maxY = max(n(:,2));
    dY = (maxY - minY)*k;
    
    plot([minX-dX, minX-dX, maxX+dX, maxX+dX, minX-dX], [minY-dY, maxY+dY, maxY+dY, minY-dY, minY-dY],...
        '-black', 'LineWidth', 1);
    
end

