clear variables
close all

% chargement du jeu de données
load('dataset.mat')


%% Calculer les axes principaux de X et la matrice C des données dans le nouveau repère

X = X'; % On classifie maintenant les variables et non les individus
mX = mean(X,1);
X_centre = X - mX;
sigma = 1/size(X,1) * (X_centre')*X_centre;

% Calcul des valeurs propres et des vecteurs principaux
[axes,lambda] = eig(sigma);

[lambdaTri, indices] = sort(diag(lambda),'descend');
axesTri = axes(:,indices);

C = X_centre*axesTri;


%% Pourcentage d'information apporté par chaque axe

info_axes = 100*abs(lambdaTri/sum(lambdaTri))';

figure(1), clf
bar(info_axes(1:20));
title("Pourcentage d'information contenue sur chaque composante principale")
xlabel('Numéro de la composante principale');ylabel("Pourcentage d'information (%)");

% L'apport des composantes est négligeable à partir de 6, on travaillera
% donc sur les 5 premiers axes


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


%% Affichage des donnees sur les trois premières composantes principales dans l'espace

figure(4), clf,
plot3(C(:,1), C(:,2), C(:,3), 'r+', 'linewidth', 2);
grid on;
title('Projection des donnees sur les trois 1ers axes principaux');


%%  Affichage des donnees sur les quatres premières composantes principales dans l'espace

figure(5); clf,
pointsize = 20;
scatter3(C(:,1), C(:,2), C(:,3), pointsize, C(:,4), 'filled');
title('Projection des données sur les quatres 1ers axes principaux');
colorbar;

% Ici on observe dans tous les cas 6 clusters, ce qui signifie qu'il y a
% 6 classes de variables.
