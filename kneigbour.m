% calculate the knn distance
function nn = kneigbour(k,DM)
for i=1:size(DM,1)
    DM(i,i)=inf;
nn(i,:)=sort(DM(i,:),2,'ascend');
end
end