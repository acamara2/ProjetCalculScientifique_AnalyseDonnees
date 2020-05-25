clear;
close all;

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
load donneesCouleur;
figure('Name','Individu moyen et eigenfaces','Position',[0,0,0.67*L,0.67*H]);

% Calcul de l'individu moyen :
individu_moyen = mean(X,1);

% Centrage des donnees : 
Xc = X - individu_moyen;

% Calcul de la matrice Sigma_2 (de taille n x n) [voir Annexe 1 pour la nature de Sigma_2] :
Sigma_2 = 1/size(X,1) * Xc*(Xc');

% Calcul des vecteurs/valeurs propres de la matrice Sigma_2 :
[vecteurs_propres, valeurs_propres] = eig(Sigma_2);

% Tri par ordre decroissant des valeurs propres de Sigma_2 :
[valeurs_propres, indices] = sort(diag(abs(valeurs_propres)), 'descend');

% Tri des vecteurs propres de Sigma_2 dans le meme ordre :
vecteurs_propres = vecteurs_propres(:,indices);

% Elimination du dernier vecteur propre de Sigma_2 :
vecteurs_propres = vecteurs_propres(:,1:end-1);

% Vecteurs propres de Sigma (deduits de ceux de Sigma_2) :
W = (Xc')*vecteurs_propres;
    
% Normalisation des vecteurs propres de Sigma
% [les vecteurs propres de Sigma_2 sont normalisés
% mais le calcul qui donne W, les vecteurs propres de Sigma,
% leur fait perdre cette propriété] :
W = normc(W);

% Affichage de l'individu moyen et des eigenfaces sous forme d'images :
% colormap gray;
img = reshape(individu_moyen,nb_lignes,nb_colonnes,3);
subplot(nb_individus,nb_postures,1);
imagesc(img);
axis image;
axis off;
title('Individu moyen','FontSize',15);
for k = 1:n-1
	img = reshape(W(:,k), nb_lignes, nb_colonnes,3);
	subplot(nb_individus,nb_postures,k+1);
	imagesc(img);
	axis image;
	axis off;
	title(['Eigenface ',num2str(k)],'FontSize',15);
end


save exercice_8;