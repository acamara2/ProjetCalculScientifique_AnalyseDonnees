clear variables;close all;clc;

%% Utilisation de l'ACP pour detecter deux classes

% Creation d'un echantillon contenant deux classes que nous allons
% retrouver via l'ACP
nb_indiv1 = 100;nb_indiv2 = 150;nb_indiv = nb_indiv1+nb_indiv2; 
nb_param = 30;
% Creation de la premiere classe autour de l'element moyen -.5*(1 .... 1)
X1 = randn(nb_indiv1,nb_param);X1 = X1 - 0.5*ones(nb_indiv1,1)*ones(1,nb_param);  
% Creation de la premiere classe autour de l'element moyen + (1 .... 1)
X2 = randn(nb_indiv2,nb_param);X2 = X2 + 1*ones(nb_indiv2,1)*ones(1,nb_param); 
% Creation du tableau des donnees (concatenation des deux classes) 
X = [X1;X2]; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X, ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mX = mean(X,1);
X_centre = X - mX;
sigma = 1/size(X,1) * (X_centre')*X_centre;

% Calcul des valeurs propres et des vecteurs principaux
[axes,lambda] = eig(sigma);

[lambdaTri, indices] = sort(diag(lambda),'descend');
axesTri = axes(:,indices);

C = X_centre*axesTri;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LA PROJECTION DES INDIVIDUS DE XC SUR LE PREMIER AXE DU REPERE 
% CANONIQUE. LES INDIVIDUS DES DEUX CLASSES DOIVENT ETRE REPRESENTES PAR 
% DEUX COULEURS DIFFERENTES.
% AFFICHER LA PROJECTION DE CES MEMES INDIVIDUS SUR LE PREMIER AXE 
% PRINCIPAL (AVEC A NOUVEAU UNE COULEUR PAR CLASSE).
% COMMENTER.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1), clf, 

% Affichage des donnees sur la premiere composante canonique :
% les individus de la premiere classe sont en rouge (p. ex), ceux de la 
% seconde classe sont en bleu
subplot(2,1,1)
hold all;
p1 = plot([1.5*min(X(:,1)) 1.5*max(X(:,1))],[0 0],'k-','linewidth',2);
p2 = plot(X_centre(1:100,1),0,'r+','linewidth',2);
p3 = plot(X_centre(101:250,1),0,'b+','linewidth',2);grid on; 

title('Visualisation des donnees sur le premier axe canonique')
legend([p1;p2(1);p3(1)],{'premier axe canonique', 'classe 1', 'classe 2'});
hold off;

% Affichage des donnees sur la premiere composante principale : (même
% code couleur)
subplot(2,1,2)
hold all;
p1 = plot([1.5*min(C(:,1)) 1.5*max(C(:,1))],[0 0],'k-','linewidth',2);
p2 = plot(C(1:100,1),0,'r+','linewidth',2);
p3 = plot(C(101:250,1),0,'b+','linewidth',2);grid on;

title('Visualisation des donnees sur le premier axe principal');
legend([p1;p2(1);p3(1)],{'premier axe principal', 'classe 1', 'classe 2'});
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
% CHAQUE COMPOSANTE PRINCIPALE. 
% EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
% ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
% NB : ETANT DONNEE QU'ON A REORDONNE LES AXES PRINCIPAUX DANS L'ORDRE
% DECROISSANT DE L'INFORMATION APPORTEE, LA COURBE DOIT ETRE DECROISSANTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2), clf

info_axes_2 = 100*lambdaTri/sum(lambdaTri)';

bar(info_axes_2(1:20));
title("Pourcentage d'information contenue sur chaque composante principale")
xlabel('Numéro de la composante principale');ylabel("Pourcentage d'information (%)");

%% Utilisation de l'ACP pour detecter plusieurs classes

% Dans le fichier 'jeu_de_donnees.mat' se trouvent 4 tableaux des donnees 
% d'individus vivant dans le meme espace. Chacun de ces tableaux 
% represente une classe. On concatene ces tableaux en un unique tableau X, 
% et on va chercher combien de composantes principales il faut prendre en 
% compte afin de detecter toutes les classes
load('quatre_classes.mat')
n1 = size(X1,1);n2 = size(X2,1);n3 = size(X3,1);n4 = size(X4,1);
n = n1+n2+n3+n4;
X = [X1;X2;X3;X4];
nb_param = size(X,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULER LA MATRICE DE VARIANCE/COVARIANCE DU TABLEAU DES DONNEES X ET
% LES AXES PRINCIPAUX. REORDONNER CES AXES PAR ORDRE DECROISSANT DU
% CONTRASTE QU'ILS FOURNISSENT.
% CALCULER LA MATRICE C DE L'ECHANTILLON DANS CE NOUVEAU REPERE.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mX = mean(X,1);
X_centre = X - mX;
sigma = 1/size(X,1) * (X_centre')*X_centre;

% Calcul des valeurs propres et des vecteurs principaux
[axes,lambda] = eig(sigma);

[lambdaTri, indices] = sort(diag(lambda),'descend');
axesTri = axes(:,indices);

C = X_centre*axesTri;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LA PROJECTION DE XC SUR :
% - LE PREMIER AXE PRINCIPAL
% - LE DEUXIEME AXE PRINCIPAL
% - LE TROISIEME AXE PRINCIPAL
% EN UTILISANT UNE COULEUR PAR CLASSE.
%
% QUESTION 5 RAPPORT :
% COMBIEN DE CLASSES EST-ON CAPABLE DE DETECTER AVEC LA PREMIERE 
% COMPOSANTE, LA DEUXIEME, LA TROISIEME, PUIS LES TROIS ENSEMBLES ?
% NB : VOTRE FIGURE DOIT CORRESPONDRE A LA FIGURE 2(b) DE L'ENONCE.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3),clf
subplot(3,1,1)
plot([1.5*min(C(:,1)) 1.5*max(C(:,1))],[0 0],'k-',...
    C(1:n1,1),0,'r+',...
    C(n1+1:n1+n2,1),0,'b+',...
    C(n1+n2+1:n1+n2+n3,1),0,'g+',...
    C(n1+n2+n3+1:n,1),0,'m+','linewidth',2);
title('1ere composante principale')

subplot(3,1,2)
plot([1.5*min(C(:,2)) 1.5*max(C(:,2))],[0 0],'k-',...
    C(1:n1,2),0,'r+',...
    C(n1+1:n1+n2,2),0,'b+',...
    C(n1+n2+1:n1+n2+n3,2),0,'g+',...
    C(n1+n2+n3+1:n,2),0,'m+','linewidth',2);
title('2eme composante principale')

subplot(3,1,3)
plot([1.5*min(C(:,3)) 1.5*max(C(:,3))],[0 0],'k-',...
    C(1:n1,3),0,'r+',...
    C(n1+1:n1+n2,3),0,'b+',...
    C(n1+n2+1:n1+n2+n3,3),0,'g+',...
    C(n1+n2+n3+1:n,3),0,'m+','linewidth',2);
title('3eme composante principale')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER LES DEUX PREMIERES COMPOSANTES PRINCIPALES DE X DANS LE PLAN, 
% PUIS AFFICHER LES TROIS PREMIERES COMPOSANTES PRINCIPALES DE X DANS 
% L'ESPACE. UTILISER UNE COULEUR PAR CLASSE. 
%
% QUESTION 5 RAPPORT :
% COMBIEN DE CLASSES PEUT-ON DETECTER DANS LE PLAN ? DANS L'ESPACE ?
% NB : VOS FIGURES DOIVENT CORRESPONDRE AUX FIGURES 2(c) ET (d) DE L'ENONCE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4), clf, 
grid on
hold all;
p1 = plot(C(1:n1,1), C(1:n1,2), 'r+', 'linewidth', 2);
p2 = plot(C(n1+1:n1+n2,1), C(n1+1:n1+n2,2), 'b+', 'linewidth', 2);
p3 = plot(C(n1+n2+1:n1+n2+n3,1), C(n1+n2+1:n1+n2+n3,2), 'g+', 'linewidth', 2);
p4 = plot(C(n1+n2+n3+1:n,1), C(n1+n2+n3+1:n,2), 'm+', 'linewidth', 2);
legend([p1(1);p2(1);p3(1);p4(1)],'classe 1', 'classe 2','classe 3','classe 4');
title('Projection des donnees sur les deux 1ers axes principaux')
hold off;

figure(5),clf, 
plot3(C(1:n1,1), C(1:n1,2),  C(1:n1,3), 'r+',...
	C(n1+1:n1+n2,1), C(n1+1:n1+n2,2), C(n1+1:n1+n2,3), 'b+',...
	C(n1+n2+1:n1+n2+n3,1), C(n1+n2+1:n1+n2+n3,2), C(n1+n2+1:n1+n2+n3,3), 'g+',...
    C(n1+n2+n3+1:n,1), C(n1+n2+n3+1:n,2), C(n1+n2+n3+1:n,3), 'm+', 'linewidth', 2);
grid on;
title('Projection des donnees sur 3 1ers axes principaux')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% AFFICHER UNE FIGURE MONTRANT LE POURCENTAGE D'INFORMATION APPORTEE PAR
% CHAQUE COMPOSANTE PRINCIPALE. 
% EN ABSCISSE DOIT SE TROUVER LE NUMERO DE LA COMPOSANTE OBSERVEE, EN 
% ORDONNEE ON MONTRERA LE POURCENTAGE D'INFO QUE CONTIENT CETTE COMPOSANTE.
% NB : ETANT DONNEE QU'ON A REORDONNE LES AXES PRINCIPAUX DANS L'ORDRE
% DECROISSANT DE L'INFORMATION APPORTEE, LA COURBE DOIT ETRE DECROISSANTE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6),clf

info_axes_4 = 100*lambdaTri/sum(lambdaTri)';
bar(info_axes_4(1:20));

title("Pourcentage d'information contenue sur chaque composante principale -- 4 classes")
xlabel('Numéro de la composante principale');ylabel("Pourcentage d'information (%)");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPARER CETTE FIGURE AVEC LA MEME FIGURE OBTENUE POUR LA CLASSIFICATION
% EN DEUX GROUPES.
%
% QUESTION 5 RAPPORT :
% COMMENTER.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(7),clf

hold all;
info_axes = [info_axes_2, info_axes_4];
hb = bar(info_axes(1:20,:));
set(hb(1), 'FaceColor','r')
set(hb(2), 'FaceColor','b')
legend('2 classes', '4 classes');
title("Pourcentage d'information contenue sur chaque composante principale -- 2 et 4 classes")
xlabel('Numéro de la composante principale');ylabel("Pourcentage d'information (%)");
hold off;