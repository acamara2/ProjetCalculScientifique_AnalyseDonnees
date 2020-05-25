clear variables;clc
% tolerance relative minimum pour l'ecart entre deux iteration successives 
% de la suite tendant vers la valeur propre dominante 
% (si |lambda-lambda_old|/|lambda_old|<eps, l'algo a converge)
eps = 1e-8;
% nombre d iterations max pour atteindre la convergence 
% (si i > kmax, l'algo finit)
kmax = 10000; 

% Generation d une matrice rectangulaire aleatoire A de taille n x p.
% On cherche le vecteur propre et la valeur propre dominants de AA^T puis
% de A^TA
n = 3; p = 3;
A = 5*randn(n,p);
% AAt, AtA sont deux matrices carrees de tailles respectives (n x n) et 
% (p x p). Elles sont appelees "equations normales" de la matrice A
AAt = A*A'; AtA = A'*A;
%% Methode de la puissance iteree pour la matrice AAt de taille nxn
% Point de depart de l'algorithme de la puissance iteree : une matrice
% aleatoire, normalise
v = randn(n); v = v/norm(v);
disp('Matrice AAt :');
disp(AAt);
disp('Vecteurs propres de AAt :');
[vecteurs_propres,valeurs_propres] = eig(AAt);
disp(vecteurs_propres);

cv = false;
iv1 = 0;  % pour compter le nombre d'iterations effectuees
t_v1 =  cputime; % pour calculer le temps d execution de l'algo
err1 = 0; % residu de la norme du vecteur propre. On sort de la boucle 
% quand err1 <eps 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODER L'ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS L'ENONCE
% POUR LA MATRICE AAt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
beta = v'*AAt*v;
while(~cv)
   beta_old = beta;
   v = AAt*v;
   v = v / norm(v);
   beta = v'*AAt*v;
   iv1 = iv1 + 1;
   cv =  (iv1 > kmax);
end
t_v1 = cputime-t_v1; % t_version1 : temps d execution de l algo de la 
% puissance iteree pour la matrice AAt
lambdav1 = beta;

disp('Matrice V finale :');
disp(v);

disp('Coefficients multiplicatifs séparants chaque élément du vecteur');
disp('propre de AAt associé à la plus grande valeur propre et des colonnes');
disp('de V :');
disp(vecteurs_propres(:,n)./v(:,1));
disp(vecteurs_propres(:,n)./v(:,2));
disp('On remarque que les vecteurs sont tous liés');
% 
% %% Methode de la puissance iteree pour la matrice AtA de taille pxp
% % Point de depart de l'algorithme de la puissance iteree : un vecteur
% % aleatoire, normalise
% v = randn(p); v = v/norm(v);
% 
% cv = false;
% iv2 = 0;  % pour compter le nombre d iterations effectuees
% t_v2 =  cputime; % pour calculer le temps d execution de l'algo
% err2 = 0; % residu de la norme du vecteur propre. On sort de la boucle 
% % quand err2 <eps 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % CODER L ALGORITHME DE LA PUISSANCE ITEREE TEL QUE DONNE DANS L'ENONCE
% % POUR LA MATRICE AtA
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% beta = v'*AtA*v;
% while(~cv)
%    beta_old = beta;
%    v = AtA*v;
%    v = v/norm(v);
%    beta = v'*AtA*v;
%    iv2 = iv2 + 1;
%    cv = (abs(norm(beta) - norm(beta_old))/norm(beta) <= eps) | (iv2 > kmax);
% end
% t_v2 = cputime-t_v2;
% lambdav2 = beta;
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % APRES VOUS ETRE ASSURE DE LA CONVERGENCE DES DEUX METHODES, AFFICHER 
% % L'ECART RELATIF ENTRE LES DEUX VALEURS PROPRES TROUVEES, ET LE TEMPS
% % MOYEN PAR ITERATION POUR CHACUNE DES DEUX METHODES. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eigv1 = eig(AAt);
% err1 = abs(lambdav1(end) - eigv1(end));
% eigv2 = eig(AtA);
% err2 = abs(lambdav2(end) - eigv2(end));
% 
% ecart = abs(lambdav1(end) - lambdav2(end));
% 
% fprintf('Erreur relative pour la methode avec la grande matrice = %0.3e\n',err1);
% fprintf('Erreur relative pour la methode avec la petite matrice = %0.3e\n',err2);
% fprintf('Ecart relatif entre les deux valeurs propres trouvees = %1.2e\n', ecart);
% fprintf('Temps pour une itÃ©ration avec la grande matrice = %0.3e\n',t_v1/iv1);
% fprintf('Temps pour une itÃ©ration avec la petite matrice = %0.3e\n',t_v2/iv2);
% fprintf('Nombre d''itÃ©rations avec la grande matrice = %d\n',iv1);
% fprintf('Nombre d''itÃ©rations avec la petite matrice = %d\n',iv2);
% fprintf('Temps total avec la grande matrice = %0.3e\n',t_v1);
% fprintf('Temps total avec la petite matrice = %0.3e\n',t_v2);
