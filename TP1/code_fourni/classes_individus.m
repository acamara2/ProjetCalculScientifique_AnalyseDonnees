clear variables
close all

% chargement du jeu de données
load('dataset.mat')


%% Calculer les axes principaux de X et la matrice C des données dans le nouveau repère

mX = mean(X,1);
X_centre = X - mX;
sigma = 1/size(X,1) * (X_centre')*X_centre;

% Calcul des valeurs propres et des vecteurs principaux
[axes,lambda] = eig(sigma);

[lambdaTri, indices] = sort(diag(lambda),'descend');
axesTri = axes(:,indices);

C = X_centre*axesTri;


%% Pourcentage d'information apporté par chaque axe

info_axes = 100*lambdaTri/sum(lambdaTri)';

figure(1), clf
bar(info_axes(1:20)); 
title("Pourcentage d'information contenue sur chaque composante principale")
xlabel('Numéro de la composante principale');ylabel("Pourcentage d'information (%)");


%% Affichage des donnees sur la premiere composante principale

figure(2); clf,
hold all;
p1 = plot([1.5*min(C(:,1)) 1.5*max(C(:,1))],[0 0],'k-','linewidth',2);
p2 = plot(C(:,1),0,'r+','linewidth',2);
grid on;

title('Visualisation des donnees sur le premier axe principal');
legend([p1;p2(1)],{'premier axe principal', 'Projection sur l axe principale'});


%% Affichage des donnees sur les deux premières composantes principales dans le plan

figure(3), clf, 
plot(C(:,1), C(:,2), 'r+', 'linewidth', 2);
grid on;
title('Projection des donnees sur les deux 1ers axes principaux');

% On distingue 6 clusters en 2D mais certains semblent être le regroupement
% de plusieurs clusters


%% Affichage des donnees sur les trois premières composantes principales dans l'espace

figure(4), clf,
plot3(C(:,1), C(:,2), C(:,3), 'r+', 'linewidth', 2);
grid on;
title('Projection des donnees sur les trois 1ers axes principaux');

% On distingue toujours 6 clusters, il faut maintenant regardé
% l'information contenu dans les 3 axes suivant étant donné que l'on a vu
% figure 2 que l'on a la majorité de l'information en prenant les 6
% premiers axes


%% Afficher l'ensemble des classes

figure(5); clf,
pointsize = 20;
scatter3(C(:,2), C(:,4), C(:,5), pointsize, C(:,6), 'filled');
grid on;
title('Projection des données sur les axes principaux 2, 4, 5 et 6');

% On a projeté X sur différentes combinaisons des 6 premiers axes jusqu'à
% en trouver une qui fasse ressortir de nouveaux clusters. On distingue
% maintenant 8 classes différentes.
