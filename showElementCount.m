function showElementCount(cluster, halo, cluster_num)
    for i = 0:cluster_num
        halo_filter = (halo == i);
        cluster_filter = (cluster == i);
        nc = length(find(cluster_filter));
        nh = length(find(halo_filter));
        fprintf('CLUSTER: %i, ELEMENTS: %i, CORE: %i, HALO: %i\n', i, nc, nh, nc-nh);
    end
end