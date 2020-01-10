%% calculate deltas£¬
function [deltas, nneigh] = getDistanceToHigherDensity(distset, rhos)
    deltas   = zeros(size(rhos));
    nneigh   = zeros(size(rhos));
    maxords  = zeros(size(rhos));
    max_rho  = max(rhos);
    %max_dist = max(max(distset));
    casenum  = size(distset, 1);
    for i = 1:casenum
        if rhos(i) == max_rho
            deltas(i) = 0;
            nneigh(i) = 0;
            maxords(i) = 1;
        else
            disti = distset(i, :);
            deltas(i) = min(disti(rhos > rhos(i)));
            neigh = find(disti == deltas(i) & rhos > rhos(i), 1);
            assert(neigh ~= 0, 'neigh is zero!');
            assert(rhos(neigh) > rhos(i), 'neigh has bug!');
            nneigh(i) = neigh;
        end
    end
    deltas(maxords == 1) = max(deltas);
end
