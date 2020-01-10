function Z = projectData(X, U, K)
%on to the top k eigenvectors
%   Z = projectData(X, U, K) computes the projection of 
%   the normalized inputs X into the reduced dimensional space spanned by
%   the first K columns of U. It returns the projected examples in Z.
%
Z = zeros(size(X, 1), K);
for i = 1:size(X,1)
  for k = 1:K
    x= X(i, :)';
    Z(i,k) = x' * U(:, k);
  end
end
end
%  Run PCA