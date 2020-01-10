%% DPC-PCA-KNN Implementation 
% original paper tittle: Study on density peaks clustering based on k-nearest neighbors and principal component analysis
% Implemented by Yizhang Wang, Di Wang, Wei Pang, Chunyan Miao, Ah-Hwee Tan and You Zhou
%##########################
% This is experiment version, we fine-turn parameters, all the data clustering results 
% are same as the DPC-PCA-KNN in the original paper. Thus, this
% code is  consistent with the idea of DPC-PCA-KNN clustering.
%##########################
% ####parameter information######%
% d---reduce the original data to the d dimension by PCA.
% k---the parameter of KNN: k nearest data points, 
% percent--- the parameter of DPC
%############################
clc;clear;close all
% set the data, evaluation method path
addpath('D:\MEGAFile\work\evaluation', 'D:\MEGAFile\work\Complicate','D:\MEGAFile\work\UCI','D:\MEGAFile\work\drawGraph');
 load ('wine-red.mat');% load data
%data=load ('t5.8k.dat');% load data

%% parameters setting
percent  =0.8;% 
d = 8;
k=9;
%% pca process
[U, S] = pca(data);
Z = projectData(data, U, d);
shapeset =Z;
distset = shapeset2distset(shapeset);% 
dc = computeDc(distset, percent);% 
fprintf('average percentage of neighbours (hard coded): %5.6f\n', percent);
fprintf('Computing Rho with gaussian kernel of radius: %12.6f\n', dc);
%% rhos calculation method is consistent with the idea of DPC-PCA-KNN clustering
nn = kneigbour(k,distset);
kneigh=nn(:,k);
rhos = sum(kneigh,2)/k;
rhos =rhos';
rhos = exp(-(rhos).^ 2);%
%% clustering process
[deltas, nneigh] = getDistanceToHigherDensity(distset, rhos);% deltas
showDeltas(rhos, deltas);    
[min_rho, min_delta] = selectRect();
filter = (rhos > min_rho) & (deltas > min_delta);
cluster_num = sum(filter);
fprintf('rho: %f, delta: %f, number of clusters: %i \n', min_rho, min_delta, cluster_num);
ords = find(filter);
cluster = zeros(size(rhos));
color = 1;
for i = 1:size(ords, 2)
    cluster(ords(i)) = color;
    color = color + 1;
    end
    [sorted_rhos, rords] = sort(rhos, 'descend');
    for i = 1:size(rords, 2)
        if cluster(rords(i)) == 0
            neigh_cluster = cluster(nneigh(rords(i)));
            assert(neigh_cluster ~= 0, 'neigh_cluster has not assign!');
            cluster(rords(i)) = neigh_cluster;
        end
    end
%% evaluate the results and show the final clusters
figure()
drawgraph(cluster',data );
Evaluation(label,cluster');
 [FMeasure,Accuracy]=Accuracy(label',cluster);
 Accuracy
% figure()
% scatter(data(:,1),data(:,2),3,'filled');
% set(gca,'looseInset',[0 0 0 0]);
% box on;
