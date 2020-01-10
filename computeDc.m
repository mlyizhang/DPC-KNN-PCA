%% calculate dc
function dc = computeDc(distset, percent)
    casenum = size(distset, 1);
    filter = logical(triu(ones(casenum, casenum),1)); 
    crossnum = sum(sum(filter));% ¡£
    pos = round(crossnum * percent / 100);%
    sda = sort(distset(filter)); % 
    dc = sda(pos);% 
end
