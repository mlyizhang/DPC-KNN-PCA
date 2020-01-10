function showHaloShape(shapeset, cluster, halo, cluster_num, ords)
    subplot(2,2,4); 
    hold on;    
    cmap = colormap;
    for i = 0:cluster_num
        filter = (halo == i);
        x = shapeset(:, 1)';
        y = shapeset(:, 2)';
        xx = x(filter);
        yy = y(filter);
        ic = int8(i * 32.0 / cluster_num) + 1;
        %fprintf('i: %d, cluster_element: %d\n', i, size(xx, 2));
        tt=plot(xx, yy, 'o', 'MarkerSize', 2, 'MarkerFaceColor', cmap(ic,:), 'MarkerEdgeColor', cmap(ic,:));
    end
    for i = 1:size(ords, 2)
        color = cluster(ords(i));
        x = shapeset(ords(i), 1);
        y = shapeset(ords(i), 2);
        ic = int8(color * 64.0 / cluster_num);
        tt=plot([x], [y], 'o', 'MarkerSize', 10, 'MarkerFaceColor', cmap(ic,:), 'MarkerEdgeColor', cmap(ic,:));
    end    
    text = strcat('HaloShape: ', num2str(cluster_num));
    title (text, 'FontSize', 15.0);
    xlabel ('x');
    ylabel ('y');    
end