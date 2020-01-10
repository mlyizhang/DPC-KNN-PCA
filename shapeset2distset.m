function distset = shapeset2distset(shapeset)
    distvar = pdist(shapeset, 'euclidean');
    distset = squareform(distvar);
end

function distset = shapeset1distset(shapeset)
    casenum = size(shapeset, 1);
    distset = zeros(casenum, casenum);
    for i = 1:casenum-1
        case1 = shapeset(i, 1:end-1);
        for j = 2:casenum
            case2 = shapeset(j, 1:end-1);
            dist = sqrt((case1 - case2) * (case1 - case2)');
            distset(i, j) = dist;
            distset(j, i) = dist;
        end
    end
end