X = [-4 -2; -3 -1; -1 0; 2 0; 2 1; 4 2];
Sigma = 1/size(X,1)*(X')*X;
[vecp, vp] = eig(Sigma);
W = [vecp(:,2), vecp(:,1)];
W = W/norm(W);
C = X*W;
X_reconstruit = zeros(size(X));
for q = 1:2
    X_reconstruit = X_reconstruit + C(:,q).*(W(:,q)')
end
% for i=1:6
%     X_reconstruit(i,:) = transpose(C1(i)*vecp(:,2) + C2(i)*vecp(:,1));
% end

